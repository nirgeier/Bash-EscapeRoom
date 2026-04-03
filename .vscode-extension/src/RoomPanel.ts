import * as vscode from 'vscode';
import * as path from 'path';
import * as fs from 'fs';
import { EscapeRoomServer } from './server';

// ── Room metadata (derived from README at runtime) ────────────────────────────
interface RoomInfo {
  number: number;
  title: string;
  section: string;
  tasks: string[];
  hints: string[];
  commands: string[];
  hint: string; // legacy compat
  raw: string;
}


export class RoomPanel {
  public static readonly sidebarViewType = 'bashEscapeRoom.controlPanel';

  private _sidebarView?: vscode.WebviewView;
  private _lessonPanel?: vscode.WebviewPanel;
  private _currentRoom: number = 1;
  private _server: EscapeRoomServer;
  private _logs: string[] = [];
  private _roomsPath: string;
  private _docsPath: string;
  private _metadata: Record<number, RoomInfo> = {};
  private _publicPath: string;
  private readonly _extensionUri: vscode.Uri;
  private readonly _context: vscode.ExtensionContext;
  private _stateFile: string;

  constructor(extensionUri: vscode.Uri, _workspaceFolders: string[], context: vscode.ExtensionContext) {
    this._extensionUri = extensionUri;
    this._context = context;

    const ext = extensionUri.fsPath;
    this._roomsPath = path.join(ext, 'content', 'escapeRoom');
    this._docsPath = path.join(ext, 'docs');
    this._publicPath = path.join(ext, 'public');
    this._stateFile = path.join(require('os').homedir(), '.escape_room_state');

    // Load pre-built metadata JSON (README files are stripped from bundle)
    try {
      const metaFile = path.join(ext, 'content', 'rooms-metadata.json');
      this._metadata = JSON.parse(fs.readFileSync(metaFile, 'utf8'));
    } catch { this._metadata = {}; }

    // Restore last saved room
    this._currentRoom = context.globalState.get<number>('bashEscapeRoom.currentRoom', 1);

    this._server = new EscapeRoomServer();
    this._server.onLog((l) => this._appendLog(l));
    this._server.onStatusChange(() => this._syncSidebar());

    // Watch ~/.escape_room_state - written by _utils.sh on room/next
    this._startFileWatcher();
  }

  private _startFileWatcher(): void {
    // Touch the file so it exists before watching
    try { if (!fs.existsSync(this._stateFile)) { fs.writeFileSync(this._stateFile, ''); } } catch { /* ok */ }

    const handle = () => {
      try {
        const raw = fs.readFileSync(this._stateFile, 'utf8').trim();
        const n = parseInt(raw, 10);
        if (!isNaN(n) && n > 0 && n !== this._currentRoom) {
          // Marshal back to extension host main thread
          setImmediate(() => {
            this._currentRoom = n;
            this._context.globalState.update('bashEscapeRoom.currentRoom', n);
            this._context.globalState.update('bashEscapeRoom.savedAt', new Date().toISOString());
            const info = this._readRoom(n);
            if (info) { this._openLessonPanel(info); }
            this._syncSidebar();
          });
        }
      } catch { /* ignore */ }
    };

    // Use watchFile (polling) - reliable on macOS unlike fs.watch
    try {
      fs.watchFile(this._stateFile, { interval: 500, persistent: false }, handle);
    } catch { /* ignore if watch fails */ }
  }


  // ── Sidebar (slim control strip) ─────────────────────────────────────────

  resolveWebviewView(
    view: vscode.WebviewView,
    _ctx: vscode.WebviewViewResolveContext,
    _token: vscode.CancellationToken
  ): void {
    this._sidebarView = view;
    view.webview.options = {
      enableScripts: true,
      localResourceRoots: [this._extensionUri],
    };
    view.webview.html = this._sidebarHtml(view.webview);
    view.webview.onDidReceiveMessage(async (msg) => {
      switch (msg.command) {
        case 'ready': this._syncSidebar(); break;
        case 'launch': await this.launch(); break;
        case 'stop': await this.stop(); break;
        case 'openRoom': await this.openRoom(msg.room ?? this._currentRoom); break;
        case 'openTerminal': this.openTerminal(); break;
        case 'prevRoom': await this.openRoom(Math.max(1, this._currentRoom - 1)); break;
        case 'nextRoom': await this.openRoom(this._currentRoom + 1); break;
      }
    });
  }

  // ── Public API ────────────────────────────────────────────────────────────

  async launch(): Promise<void> {
    if (this._server.status === 'running' || this._server.status === 'starting') {
      vscode.window.showInformationMessage('Escape Room server already running.');
      return;
    }
    const cfg = vscode.workspace.getConfiguration('bashEscapeRoom');
    const port = cfg.get<number>('port', 3000);

    // Allow override via setting
    const overridePath = cfg.get<string>('roomsPath', '');
    if (overridePath) { this._roomsPath = overridePath; }

    try {
      await this._server.start({
        port,
        roomsPath: this._roomsPath,
        docsPath: this._docsPath,
        publicPath: this._publicPath,
      });
    } catch (e: unknown) {
      vscode.window.showErrorMessage(`Failed to start: ${e instanceof Error ? e.message : e}`);
      return;
    }

    // Try to open room 1 - if rooms not found, still show server-is-up notice
    const info = this._readRoom(1);
    if (info) {
      this._openLessonPanel(info);
    } else {
      vscode.window.showWarningMessage(
        `Server running on :${port} but rooms not found at: ${this._roomsPath}. ` +
        `Open your Bash-EscapeRoom workspace folder, or set bashEscapeRoom.roomsPath in Settings.`,
        'Open Terminal'
      ).then((choice) => { if (choice === 'Open Terminal') { this.openTerminal(); } });
    }
    this._syncSidebar();
  }

  async stop(): Promise<void> {
    await this._server.stop();
    this._lessonPanel?.dispose();
  }

  async openRoom(n: number): Promise<void> {
    this._currentRoom = n;
    // Auto-save progress whenever room changes
    this._context.globalState.update('bashEscapeRoom.currentRoom', n);
    this._context.globalState.update('bashEscapeRoom.savedAt', new Date().toISOString());
    const info = this._readRoom(n);
    if (!info) {
      vscode.window.showWarningMessage(`Room ${n} not found.`);
      return;
    }
    this._openLessonPanel(info);
    this._syncSidebar();
    // Keep terminal in sync with current room
    if (vscode.window.terminals.find(t => t.name === 'Escape Room')) {
      this.openTerminal();
    }
  }

  openTerminal(): void {
    const roomNum = String(this._currentRoom).padStart(2, '0');
    const roomDir = path.join(this._roomsPath, `room_${roomNum}`);
    const cwd = fs.existsSync(roomDir) ? roomDir : this._roomsPath;
    const utils = path.join(this._roomsPath, '_utils.sh');

    const existing = vscode.window.terminals.find(t => t.name === 'Escape Room');

    if (existing) {
      existing.show(false);
      existing.sendText(`source "${utils}" && cd "${cwd}" && echo -e "\\033[0;36m[Room ${roomNum}]\\033[0m"`, true);
      return;
    }

    const term = vscode.window.createTerminal({
      name: 'Escape Room',
      cwd,
      env: { ESCAPE_ROOMS: this._roomsPath, ESCAPE_ROOM_PORT: String(this._server.port) },
    });
    term.show(false);

    // sendText is queued - source _utils.sh as the very first command so
    // next/room/progress/resume are available immediately in any shell
    if (fs.existsSync(utils)) {
      term.sendText(`source "${utils}"`, true);
    }
    term.sendText(`echo -e "\\033[0;32mWelcome to Bash Escape Room!\\033[0m \\033[0;36m[Room ${roomNum}]\\033[0m"`, true);
  }

  // ── Room reader - uses pre-built JSON metadata (no README in bundle) ──────

  private _readRoom(n: number): RoomInfo | null {
    const entry = this._metadata[n];
    if (!entry) { return null; }
    return {
      ...entry,
      hints: entry.hints ?? [],
      commands: entry.commands ?? [],
      hint: (entry.hints ?? [])[0] ?? '',
      raw: entry.raw ?? '',
    };
  }

  // ── Lesson WebviewPanel (LEFT ) ───────────────────────────

  private _openLessonPanel(info: RoomInfo): void {
    if (this._lessonPanel) {
      this._lessonPanel.title = `🏃 ${info.title}`;
      this._lessonPanel.webview.html = this._lessonHtml(info);
      this._lessonPanel.reveal(vscode.ViewColumn.One, false);
      return;
    }

    this._lessonPanel = vscode.window.createWebviewPanel(
      'bashEscapeRoom.lesson',
      `🏃 ${info.title}`,
      vscode.ViewColumn.One,
      {
        enableScripts: true,
        retainContextWhenHidden: true,
        localResourceRoots: [this._extensionUri],
      }
    );

    this._lessonPanel.webview.html = this._lessonHtml(info);

    this._lessonPanel.webview.onDidReceiveMessage(async (msg) => {
      switch (msg.command) {
        case 'nextRoom': await this.openRoom(this._currentRoom + 1); break;
        case 'prevRoom': await this.openRoom(Math.max(1, this._currentRoom - 1)); break;
      }
    });

    this._lessonPanel.onDidDispose(() => { this._lessonPanel = undefined; });
  }

  // ── Open README in real editor tab (RIGHT ) ──────────────

  private async _openReadmeInEditor(n: number): Promise<void> {
    const readme = path.join(
      this._roomsPath,
      `room_${String(n).padStart(2, '0')}`,
      'README'
    );
    if (!fs.existsSync(readme)) { return; }
    const doc = await vscode.workspace.openTextDocument(vscode.Uri.file(readme));
    await vscode.window.showTextDocument(doc, {
      viewColumn: vscode.ViewColumn.Two,
      preview: false,
      preserveFocus: true,
    });
  }

  // ── Sync sidebar ──────────────────────────────────────────────────────────

  private _syncSidebar(): void {
    const cfg = vscode.workspace.getConfiguration('bashEscapeRoom');
    const maxRooms = this._countRooms();
    // Build room list: [{num, title}]
    const rooms = Object.values(this._metadata).map((r: RoomInfo) => ({
      num: r.number,
      title: String(r.number).padStart(2, '0') + ' - ' + r.title.replace(/^Room\s+\d+\s*[-–]\s*/i, '').trim(),
    })).sort((a, b) => a.num - b.num);
    const savedAt = this._context.globalState.get<string>('bashEscapeRoom.savedAt', '');
    this._sidebarView?.webview.postMessage({
      command: 'setState',
      status: this._server.status,
      port: this._server.port,
      currentRoom: this._currentRoom,
      maxRooms,
      rooms,
      savedAt,
    });
  }

  private _appendLog(line: string): void {
    this._logs.push(line);
    if (this._logs.length > 300) { this._logs.shift(); }
    this._sidebarView?.webview.postMessage({ command: 'appendLog', line });
  }

  private _countRooms(): number {
    const count = Object.keys(this._metadata).length;
    return count > 0 ? count : 56;
  }

  // ── LESSON PANEL HTML (mirrors ) ───────────────────────

  private _lessonHtml(info: RoomInfo): string {
    const nonce = getNonce();
    const roomNum = String(info.number).padStart(2, '0');
    const readmeHtml = readmeToHtml(info.raw);

    return /* html */`<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta http-equiv="Content-Security-Policy"
    content="default-src 'none'; style-src 'unsafe-inline'; script-src 'nonce-${nonce}';"/>
  <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
  <style>
    /* ── Reset ── */
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    :root {
      --bg:       #000000; /* Override with pure black for better contrast */
      --panel:   #12122a;
      --border:  #1e1e3f;
      --accent:  #e94560;
      --green:   #1abc9c;
      --yellow:  #f0c040;
      --purple:  #c792ea;
      --blue:    #89b4fa;
      --text:    #c8d0e0;
      --muted:   #5a6380;
    }

    html, body {
      height: 100%;
      background: var(--bg);
      color: var(--text);
      font-family: 'Segoe UI', system-ui, sans-serif;
      overflow-x: hidden;
    }

    /* ── Layout: top nav + two-column content ── */
    .layout {
      display: flex;
      flex-direction: column;
      height: 100vh;
    }

    /* ── Top nav bar ── */
    .topbar {
      display: flex;
      align-items: center;
      gap: 12px;
      padding: 10px 20px;
      background: #0a0a1f;
      border-bottom: 1px solid var(--border);
      flex-shrink: 0;
    }
    .topbar-title {
      font-size: 13px;
      font-weight: 700;
      color: var(--accent);
      letter-spacing: 0.05em;
      margin-right: auto;
    }
    .topbar-room {
      font-size: 11px;
      color: var(--muted);
      font-family: monospace;
    }
    .nav-btn {
      background: var(--panel);
      border: 1px solid var(--border);
      color: var(--text);
      padding: 4px 12px;
      border-radius: 4px;
      font-size: 12px;
      cursor: pointer;
      transition: all .15s;
    }
    .nav-btn:hover { background: var(--border); color: #fff; }
    .btn-action {
      background: var(--accent);
      border: none;
      color: #fff;
      padding: 4px 14px;
      border-radius: 4px;
      font-size: 12px;
      font-weight: 600;
      cursor: pointer;
      transition: filter .15s;
    }
    .btn-action:hover { filter: brightness(1.15); }
    .btn-docs {
      background: transparent;
      border: 1px solid var(--green);
      color: var(--green);
      padding: 4px 12px;
      border-radius: 4px;
      font-size: 12px;
      cursor: pointer;
      transition: all .15s;
    }
    .btn-docs:hover { background: rgba(26,188,156,.15); }

    /* ── Main content ── */
    .main {
      display: flex;
      flex: 1;
      overflow: hidden;
    }

    /* ── LEFT: big visual card () ── */
    .visual-col {
      width: 30%;
      min-width: 220px;
      background: var(--panel);
      border-right: 1px solid var(--border);
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: flex-start;
      padding: 32px 24px;
      gap: 20px;
      overflow-y: auto;
    }

    .room-badge {
      font-size: 11px;
      font-weight: 700;
      letter-spacing: .1em;
      text-transform: uppercase;
      color: var(--accent);
      border: 1px solid var(--accent);
      border-radius: 20px;
      padding: 3px 12px;
    }

    /* Big room title  */
    .room-title {
      font-size: clamp(22px, 3.5vw, 40px);
      font-weight: 900;
      text-transform: uppercase;
      text-align: center;
      line-height: 1.15;
      letter-spacing: .04em;
      color: var(--text);
    }
    .room-title .hl-accent { color: var(--accent); }
    .room-title .hl-green  { color: var(--green); }

    .section-tag {
      font-size: 11px;
      color: var(--green);
      letter-spacing: .08em;
      text-transform: uppercase;
      font-weight: 600;
    }

    /* ASCII art block */
    .nav-prompt {
      font-family: monospace;
      font-size: 13px;
      color: var(--green);
      background: rgba(26,188,156,.08);
      border: 1px solid rgba(26,188,156,.2);
      border-radius: 6px;
      padding: 10px 16px;
      text-align: center;
      width: 100%;
    }
    .nav-prompt kbd {
      display: inline-block;
      background: rgba(26,188,156,.2);
      color: var(--green);
      border-radius: 3px;
      padding: 1px 6px;
      font-family: monospace;
      font-size: 12px;
    }

    /* ── RIGHT: full README content ── */
    .content-col {
      flex: 1;
      overflow-y: auto;
      padding: 32px 36px;
      display: flex;
      flex-direction: column;
      gap: 20px;
    }

    /* Rendered README markdown */
    .readme-body { display: flex; flex-direction: column; gap: 14px; flex: 1; }

    .readme-body h2 {
      font-size: 13px; font-weight: 700; letter-spacing: .08em;
      text-transform: uppercase; color: var(--muted);
      padding-bottom: 4px; border-bottom: 1px solid var(--border);
      margin-top: 8px;
    }
    .readme-body h3 { font-size: 13px; font-weight: 700; color: var(--green); margin-top: 4px; }

    .readme-body p { font-size: 14px; line-height: 1.75; color: var(--text); }
    .readme-body p strong { color: var(--yellow); }

    .readme-body code {
      font-family: 'Cascadia Code','Fira Code',monospace;
      font-size: 12px;
      background: rgba(137,180,250,.12);
      color: var(--blue);
      border-radius: 3px;
      padding: 1px 5px;
    }
    .readme-body pre {
      background: rgba(137,180,250,.06);
      border: 1px solid rgba(137,180,250,.15);
      border-radius: 6px;
      padding: 12px 16px;
      overflow-x: auto;
    }
    .readme-body pre code {
      background: none; padding: 0;
      font-size: 13px; color: var(--green);
    }

    /* Numbered task items (## Tasks section) */
    .readme-body ol { list-style: none; padding: 0; margin: 0; display: flex; flex-direction: column; gap: 10px; counter-reset: task-counter; }
    .readme-body ol > li {
      display: flex; gap: 12px; align-items: flex-start;
      background: rgba(255,255,255,.03);
      border: 1px solid var(--border); border-radius: 6px;
      padding: 10px 14px; counter-increment: task-counter;
      transition: border-color .2s;
    }
    .readme-body ol > li:hover { border-color: var(--accent); }
    .readme-body ol > li::before {
      content: counter(task-counter);
      width: 22px; height: 22px; min-width: 22px; border-radius: 50%;
      background: var(--accent); color: #fff;
      font-size: 11px; font-weight: 700;
      display: flex; align-items: center; justify-content: center;
      flex-shrink: 0; margin-top: 1px;
    }

    /* Unordered list (bullets) */
    .readme-body ul { padding-left: 18px; display: flex; flex-direction: column; gap: 6px; }
    .readme-body ul li { font-size: 13px; line-height: 1.6; color: var(--text); }

    /* Hint lines (>> prefix) */
    .readme-hint {
      font-size: 12px; line-height: 1.6; color: #fffafa;
      background: rgba(240,192,64,.05);
      border-left: 3px solid var(--yellow);
      border-radius: 0 6px 6px 0;
      padding: 8px 14px;
    }
    .readme-hint::before {
      content: "HINT";
      display: inline-block;
      font-size: 10px; font-weight: 700;
      text-transform: uppercase; letter-spacing: .08em;
      color: var(--yellow); margin-right: 6px;
    }

    /* Markdown table */
    .readme-body table { border-collapse: collapse; width: 100%; font-size: 13px; }
    .readme-body th {
      background: var(--panel); color: var(--accent);
      font-weight: 700; padding: 6px 12px;
      border: 1px solid var(--border); text-align: left;
    }
    .readme-body td {
      padding: 6px 12px; border: 1px solid var(--border);
      color: var(--text); font-family: monospace;
    }
    .readme-body tr:nth-child(even) td { background: rgba(255,255,255,.02); }

    /* Horizontal rule */
    .readme-body hr { border: none; border-top: 1px solid var(--border); margin: 4px 0; }

    /* ">> To move..." nav hint - styled differently */
    .readme-nav {
      font-size: 13px; color: var(--green);
      background: rgba(26,188,156,.06);
      border: 1px solid rgba(26,188,156,.2);
      border-radius: 6px; padding: 10px 16px;
      font-family: monospace;
    }

    /* Next room CTA */
    .next-room {
      margin-top: auto;
      padding-top: 16px;
      border-top: 1px solid var(--border);
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 12px;
    }
    .next-room-text {
      font-size: 12px;
      color: var(--muted);
    }
    .next-room-text code {
      font-family: monospace;
      color: var(--green);
      font-size: 12px;
    }

    /* Scrollbar */
    ::-webkit-scrollbar { width: 4px; }
    ::-webkit-scrollbar-track { background: transparent; }
    ::-webkit-scrollbar-thumb { background: var(--border); border-radius: 2px; }
  </style>
</head>
<body>
<div class="layout">

  <!-- Top nav bar -->
  <div class="topbar">
    <span class="topbar-title">🏃 Bash Escape Room</span>
    <span class="topbar-room">room_${roomNum} / 56</span>
    <button class="nav-btn" id="btn-prev">← Prev</button>
    <button class="nav-btn" id="btn-next">Next →</button>
  </div>

  <!-- Main split -->
  <div class="main">

    <!-- LEFT: visual card -->
    <div class="visual-col">
      <div class="room-badge">Room ${roomNum}</div>

      <div class="room-title">
        ${formatTitle(info.title)}
      </div>

      <div class="section-tag">📂 ${escHtml(info.section)}</div>

      <div class="nav-prompt">
        To advance: <kbd>next</kbd><br/>
        Jump to room: <kbd>room &lt;N&gt;</kbd>
      </div>
    </div>

    <!-- RIGHT: full README content -->
    <div class="content-col">
      <div class="readme-body">${readmeHtml}</div>
      <div class="next-room">
        <button class="nav-btn" id="btn-next-room">Next Room →</button>
      </div>
    </div>

  </div>
</div>

<script nonce="${nonce}">
  const vscode = acquireVsCodeApi();
  function post(cmd) { vscode.postMessage({ command: cmd }); }
  document.getElementById('btn-prev')     .addEventListener('click', () => post('prevRoom'));
  document.getElementById('btn-next')     .addEventListener('click', () => post('nextRoom'));
  document.getElementById('btn-next-room').addEventListener('click', () => post('nextRoom'));
</script>
</body>
</html>`;
  }

  // ── SIDEBAR HTML - fully self-contained (no external src/href) ──────────
  // External <script src> and <link href> are blocked by VS Code's webview
  // sandbox even when cspSource is listed. Inline everything so only the
  // nonce-tagged inline <script> is needed.

  private _sidebarHtml(_webview: vscode.Webview): string {
    const nonce = getNonce();
    // Read version from package.json at runtime
    let version = '';
    try {
      const pkg = JSON.parse(
        fs.readFileSync(
          path.join(this._extensionUri.fsPath, 'package.json'), 'utf8'
        )
      );
      version = `v${pkg.version}`;
    } catch { /* ignore */ }

    return /* html */`<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta http-equiv="Content-Security-Policy"
    content="default-src 'none'; style-src 'unsafe-inline'; script-src 'nonce-${nonce}';"/>
  <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
  <style nonce="${nonce}">
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root {
      --bg:       var(--vscode-sideBar-background,   #0d0d1a);
      --bg-alt:   var(--vscode-editor-background,    #12122a);
      --bg-hover: var(--vscode-list-hoverBackground, #1e1e3f);
      --border:   var(--vscode-panel-border,         #1e1e3f);
      --fg:       var(--vscode-foreground,           #c8d0e0);
      --muted:    var(--vscode-descriptionForeground,#5a6380);
      --accent:   #e94560;
      --green:    #1abc9c;
      --yellow:   #f0c040;
      --font:     var(--vscode-font-family, -apple-system, sans-serif);
      --mono:     var(--vscode-editor-font-family, monospace);
      --r:        6px;
    }
    body { background: var(--bg); color: var(--fg); font-family: var(--font); font-size: 13px; }
    .hidden { display: none !important; }
    .brand { display: flex; align-items: center; gap: 10px; padding: 14px 12px 10px; border-bottom: 1px solid var(--border); }
    .brand-icon { font-size: 22px; }
    .brand-name { font-size: 13px; font-weight: 700; color: var(--accent); }
    .brand-sub  { font-size: 11px; color: var(--muted); }
    .status-row { display: flex; align-items: center; gap: 8px; padding: 10px 12px 6px; }
    .dot { width: 8px; height: 8px; border-radius: 50%; background: var(--muted); flex-shrink: 0; transition: background .3s; }
    .dot.stopped  { background: var(--muted); }
    .dot.starting { background: var(--yellow); animation: pulse 1s infinite; }
    .dot.running  { background: var(--green); }
    .dot.error    { background: var(--accent); }
    @keyframes pulse { 0%,100%{opacity:1} 50%{opacity:.3} }
    #status-text { font-size: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: .06em; }
    .port-badge { font-size: 10px; font-family: var(--mono); color: var(--green); background: rgba(26,188,156,.1); border: 1px solid rgba(26,188,156,.25); border-radius: 10px; padding: 1px 7px; }
    .btn-group { display: flex; gap: 6px; padding: 6px 12px; }
    .btn-primary, .btn-stop { flex: 1; padding: 6px 0; border-radius: var(--r); font-size: 12px; font-weight: 600; cursor: pointer; border: none; transition: filter .15s; font-family: var(--font); }
    .btn-primary:disabled, .btn-stop:disabled { opacity: .4; cursor: default; }
    .btn-primary { background: var(--accent); color: #fff; }
    .btn-primary:not(:disabled):hover { filter: brightness(1.12); }
    .btn-stop { background: transparent; color: var(--accent); border: 1px solid var(--accent); }
    .btn-stop:not(:disabled):hover { background: rgba(233,69,96,.1); }
    .section-label { font-size: 10px; font-weight: 700; letter-spacing: .09em; text-transform: uppercase; color: var(--muted); padding: 10px 12px 4px; display: flex; align-items: center; justify-content: space-between; }
    /* ── Quick links row ── */
    .quick-links { display: flex; gap: 6px; padding: 0 12px 6px; }
    .link-btn { flex: 1; padding: 6px 4px; background: var(--bg-alt); border: 1px solid var(--border); color: var(--muted); border-radius: var(--r); font-size: 11px; cursor: pointer; transition: all .15s; font-family: var(--font); text-align: center; }
    .link-btn:not(:disabled):hover { background: var(--bg-hover); color: var(--fg); }
    .link-btn:disabled { opacity: .35; cursor: default; }
    /* ── Room nav widget ── */
    .room-nav { display: flex; align-items: center; margin: 4px 12px 0; background: var(--bg-alt); border: 1px solid var(--border); border-radius: var(--r); overflow: hidden; }
    .room-nav-btn { padding: 8px 14px; background: none; border: none; color: var(--fg); font-size: 18px; cursor: pointer; transition: background .15s; line-height: 1; }
    .room-nav-btn:not(:disabled):hover { background: var(--bg-hover); }
    .room-nav-btn:disabled { opacity: .3; cursor: default; }
    .room-display { flex: 1; text-align: center; border-left: 1px solid var(--border); border-right: 1px solid var(--border); padding: 5px 0 4px; }
    .room-num-big { font-size: 20px; font-weight: 700; color: var(--accent); font-family: var(--mono); }
    .room-of-text { font-size: 11px; color: var(--muted); margin-left: 3px; }
    /* Progress bar */
    .progress-wrap { padding: 6px 12px 4px; }
    .progress-bar { height: 4px; background: var(--border); border-radius: 2px; overflow: hidden; }
    .progress-fill { height: 100%; background: var(--green); border-radius: 2px; transition: width .3s; width: 0%; }
    .progress-label { font-size: 10px; color: var(--muted); text-align: right; margin-top: 2px; }
    /* Rooms list */
    .saved-at { font-size: 10px; color: var(--muted); font-family: var(--mono); padding: 2px 12px 4px; display: block; }
    .rooms-label { border-top: 1px solid var(--border); margin-top: 6px; }
    .rooms-list { flex: 1; overflow-y: auto; padding: 4px 0 12px; }
    .room-item {
      display: flex; align-items: center; gap: 10px;
      padding: 6px 14px;
      cursor: pointer;
      border-radius: 0;
      transition: background .12s;
      user-select: none;
    }
    .room-item:hover { background: var(--bg-hover); }
    .room-item.active { background: rgba(26,188,156,.08); }
    .room-check {
      width: 20px; height: 20px; border-radius: 50%;
      border: 2px solid var(--muted);
      flex-shrink: 0;
      display: flex; align-items: center; justify-content: center;
      font-size: 12px; color: transparent;
      transition: all .15s;
    }
    .room-item.active .room-check {
      border-color: var(--green);
      background: var(--green);
      color: #fff;
    }
    .room-item.current .room-check {
      border-color: var(--accent);
      border-style: dashed;
    }
    .room-item-title { font-size: 13px; color: var(--fg); line-height: 1.35; }
    ::-webkit-scrollbar { width: 3px; }
    ::-webkit-scrollbar-thumb { background: var(--border); border-radius: 2px; }
  </style>
</head>
<body>
<div id="app">
  <div class="brand">
    <span class="brand-icon">🏃</span>
    <div>
      <div class="brand-name">Bash Escape Room</div>
      <div class="brand-sub">${version} · Learn Bash by escaping</div>
    </div>
  </div>
  <div class="status-row">
    <span class="dot" id="dot"></span>
    <span id="status-text">Stopped</span>
    <span class="port-badge hidden" id="port-badge"></span>
  </div>
  <div class="btn-group">
    <button class="btn-primary" id="btn-launch">▶ Launch</button>
    <button class="btn-stop"    id="btn-stop"   disabled>■ Stop</button>
  </div>
  <div class="quick-links">
    <button class="link-btn" id="btn-terminal" disabled>⬛ Terminal</button>
    <button class="link-btn" id="btn-open"     disabled>📖 Open Room</button>
  </div>
  <div class="room-nav">
    <button class="room-nav-btn" id="btn-prev" disabled>‹</button>
    <div class="room-display">
      <span class="room-num-big" id="room-num">01</span>
      <span class="room-of-text" id="room-of">/ 57</span>
    </div>
    <button class="room-nav-btn" id="btn-next" disabled>›</button>
  </div>
  <div class="progress-wrap">
    <div class="progress-bar"><div class="progress-fill" id="progress-fill"></div></div>
    <div class="progress-label" id="progress-label">Room 1 of 57</div>
  </div>
  <span class="saved-at" id="saved-at"></span>
  <div class="section-label rooms-label">Rooms</div>
  <div class="rooms-list" id="rooms-list"></div>
</div>

<script nonce="${nonce}">
  const vscode = acquireVsCodeApi();
  let _currentRoom = 1, _maxRooms = 56;

  // ── Wire button clicks ──
  document.getElementById('btn-launch')  .addEventListener('click', () => vscode.postMessage({ command: 'launch' }));
  document.getElementById('btn-stop')    .addEventListener('click', () => vscode.postMessage({ command: 'stop' }));
  document.getElementById('btn-open')    .addEventListener('click', () => vscode.postMessage({ command: 'openRoom', room: _currentRoom }));
  document.getElementById('btn-prev')    .addEventListener('click', () => vscode.postMessage({ command: 'prevRoom' }));
  document.getElementById('btn-next')    .addEventListener('click', () => vscode.postMessage({ command: 'nextRoom' }));
  document.getElementById('btn-terminal').addEventListener('click', () => vscode.postMessage({ command: 'openTerminal' }));

  // ── Handle messages from extension ──
  window.addEventListener('message', ({ data: msg }) => {
    if (msg.command === 'setState') { applyState(msg); }
  });

  let _rooms = [];

  function applyState(msg) {
    _currentRoom = msg.currentRoom ?? 1;
    _maxRooms    = msg.maxRooms   ?? 56;
    const s = msg.status ?? 'stopped';
    document.getElementById('dot').className = 'dot ' + s;
    const labels = { stopped:'Stopped', starting:'Starting…', running:'Running', error:'Error' };
    document.getElementById('status-text').textContent = labels[s] ?? s;
    const pb = document.getElementById('port-badge');
    if (s === 'running') { pb.textContent = ':' + msg.port; pb.classList.remove('hidden'); }
    else                 { pb.classList.add('hidden'); }
    const running = s === 'running';
    setDis('btn-launch',   s === 'starting' || running);
    setDis('btn-stop',     s === 'stopped');
    setDis('btn-open',     !running);
    setDis('btn-terminal', !running);
    setDis('btn-prev',     !running || _currentRoom <= 1);
    setDis('btn-next',     !running || _currentRoom >= _maxRooms);
    document.getElementById('room-num').textContent = String(_currentRoom).padStart(2, '0');
    document.getElementById('room-of').textContent  = '/ ' + _maxRooms;
    const pct = Math.round((_currentRoom / _maxRooms) * 100);
    document.getElementById('progress-fill').style.width  = pct + '%';
    document.getElementById('progress-label').textContent = 'Room ' + _currentRoom + ' of ' + _maxRooms + ' · ' + pct + '%';
    if (msg.savedAt) {
      const d = new Date(msg.savedAt);
      document.getElementById('saved-at').textContent = 'saved ' + d.toLocaleDateString() + ' ' + d.toLocaleTimeString([], {hour:'2-digit',minute:'2-digit'});
    }
    if (msg.rooms && msg.rooms.length) {
      _rooms = msg.rooms;
      renderRooms();
    } else {
      updateRoomHighlight();
    }
  }

  function renderRooms() {
    const list = document.getElementById('rooms-list');
    list.innerHTML = '';
    for (const r of _rooms) {
      const item = document.createElement('div');
      item.className = 'room-item' + (r.num < _currentRoom ? ' active' : '') + (r.num === _currentRoom ? ' current' : '');
      item.dataset.num = r.num;
      item.innerHTML =
        '<div class="room-check">' + (r.num < _currentRoom ? '✓' : '') + '</div>' +
        '<span class="room-item-title">' + r.title + '</span>';
      item.addEventListener('click', () => vscode.postMessage({ command: 'openRoom', room: r.num }));
      list.appendChild(item);
    }
    scrollToCurrentRoom();
  }

  function updateRoomHighlight() {
    const items = document.querySelectorAll('.room-item');
    items.forEach(item => {
      const n = parseInt(item.dataset.num);
      item.className = 'room-item' + (n < _currentRoom ? ' active' : '') + (n === _currentRoom ? ' current' : '');
      const check = item.querySelector('.room-check');
      if (check) { check.textContent = n < _currentRoom ? '✓' : ''; }
    });
    scrollToCurrentRoom();
  }

  function scrollToCurrentRoom() {
    const current = document.querySelector('.room-item.current');
    if (current) { current.scrollIntoView({ block: 'nearest' }); }
  }

  function setDis(id, disabled) {
    const el = document.getElementById(id);
    if (el) { el.disabled = disabled; }
  }

  // Signal ready
  vscode.postMessage({ command: 'ready' });
</script>
</body>
</html>`;
  }
}

// ── Helpers ───────────────────────────────────────────────────────────────────

function getNonce(): string {
  const c = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  return Array.from({ length: 32 }, () => c[Math.floor(Math.random() * c.length)]).join('');
}

function escHtml(s: string): string {
  return s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
}

/**
 * Convert a room README (plain-text markdown-like format) to HTML.
 * Handles: ## headings, numbered lists, bullet lists, tables,
 * backtick code, >> hint lines, >> To move nav lines, bold, hr.
 */
function readmeToHtml(raw: string): string {
  if (!raw) { return '<p>No content available.</p>'; }

  const inlineFormat = (s: string): string => {
    s = s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
    s = s.replace(/\*\*([^*]+)\*\*/g, '<strong>$1</strong>');
    s = s.replace(/`([^`]+)`/g, '<code>$1</code>');
    return s;
  };

  // ── Pass 1: join continuation lines into their parent ────────────────────
  // A continuation line is one that is indented (starts with spaces/tab)
  // AND does not start a new block element. We join it onto the previous line.
  const rawLines = raw.split('\n');
  const joined: string[] = [];
  for (const line of rawLines) {
    const trimmed = line.trim();
    const isIndented = line.length > 0 && (line[0] === ' ' || line[0] === '\t');
    const isBlockStart = !trimmed ||
      /^#+\s/.test(trimmed) ||
      /^\d+\./.test(trimmed) ||
      /^[-*]/.test(trimmed) ||
      /^\|/.test(trimmed) ||
      /^>\s*>/.test(trimmed) ||
      /^-{3,}$/.test(trimmed);

    if (isIndented && !isBlockStart && joined.length > 0) {
      joined[joined.length - 1] += ' ' + trimmed;
    } else {
      joined.push(line);
    }
  }

  // ── Pass 2: render ────────────────────────────────────────────────────────
  const out: string[] = [];
  let inOl = false;
  let inUl = false;
  let inTable = false;
  let tableHeaderDone = false;

  const closeOl = () => { if (inOl) { out.push('</ol>'); inOl = false; } };
  const closeUl = () => { if (inUl) { out.push('</ul>'); inUl = false; } };
  const closeTable = () => { if (inTable) { out.push('</tbody></table>'); inTable = false; tableHeaderDone = false; } };
  const closeAll = () => { closeOl(); closeUl(); closeTable(); };

  for (const line of joined) {
    const trimmed = line.trim();

    // Skip blank, top-level heading, bare dashes, congratulations, hint/nav lines
    if (!trimmed) { closeTable(); continue; }
    if (trimmed.startsWith('# ')) { continue; }
    if (/^-{2,}$/.test(trimmed)) { continue; }
    if (trimmed.startsWith('- Congratulations')) { continue; }
    if (/^>\s*>/.test(trimmed)) { continue; }   // hints omitted from task view

    // ## / ### headings - close everything including lists
    if (trimmed.startsWith('### ')) { closeAll(); out.push(`<h3>${inlineFormat(trimmed.slice(4))}</h3>`); continue; }
    if (trimmed.startsWith('## ')) { closeAll(); out.push(`<h2>${inlineFormat(trimmed.slice(3))}</h2>`); continue; }

    // Table rows
    if (/^\|/.test(trimmed)) {
      if (!inTable) { closeOl(); closeUl(); out.push('<table>'); inTable = true; tableHeaderDone = false; }
      if (/^\|[-| :]+\|$/.test(trimmed)) { if (!tableHeaderDone) { out.push('<tbody>'); tableHeaderDone = true; } continue; }
      const cells = trimmed.split('|').slice(1, -1).map(c => c.trim());
      if (!tableHeaderDone) {
        out.push('<thead><tr>' + cells.map(c => `<th>${inlineFormat(c)}</th>`).join('') + '</tr></thead>');
      } else {
        out.push('<tr>' + cells.map(c => `<td>${inlineFormat(c)}</td>`).join('') + '</tr>');
      }
      continue;
    } else if (inTable) { closeTable(); }

    // Numbered list: "1. text" - keep <ol> open so counter stays continuous across blank lines
    if (/^\d+\.\s/.test(trimmed)) {
      closeUl(); closeTable();
      if (!inOl) { out.push('<ol>'); inOl = true; }
      out.push(`<li>${inlineFormat(trimmed.replace(/^\d+\.\s*/, ''))}</li>`);
      continue;
    }

    // Bullet list: "- text" or "* text"
    if (/^[-*]\s/.test(trimmed)) {
      closeOl(); closeTable();
      if (!inUl) { out.push('<ul>'); inUl = true; }
      out.push(`<li>${inlineFormat(trimmed.replace(/^[-*]\s*/, ''))}</li>`);
      continue;
    }

    // Paragraph - close lists only when we hit actual paragraph text (not blank lines)
    closeOl(); closeUl(); closeTable();
    out.push(`<p>${inlineFormat(trimmed)}</p>`);
  }

  closeAll();
  return out.join('\n');
}

/** Break the room title into styled spans - capitalise first word in accent color */
function formatTitle(title: string): string {
  // Remove "Room NN - " prefix
  const clean = title.replace(/^Room\s+\d+\s*[-–]\s*/i, '').trim();
  const words = clean.split(/\s+/);
  return words
    .map((w, i) =>
      i === 0
        ? `<span class="hl-accent">${escHtml(w)}</span>`
        : escHtml(w)
    )
    .join('<br/>');
}
