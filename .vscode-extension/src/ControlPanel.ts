import * as vscode from 'vscode';
import * as path from 'path';
import { EscapeRoomServer, ServerStatus } from './server';

export class ControlPanel implements vscode.WebviewViewProvider {
  public static readonly viewType = 'bashEscapeRoom.controlPanel';

  private _sidebarView?: vscode.WebviewView;
  private _terminalPanel?: vscode.WebviewPanel;
  private _docsPanel?: vscode.WebviewPanel;

  private readonly _server: EscapeRoomServer;
  private readonly _extensionUri: vscode.Uri;
  private readonly _workspaceRoot: string;
  private _logs: string[] = [];
  private _status: ServerStatus = 'stopped';

  constructor(extensionUri: vscode.Uri, workspaceRoot: string) {
    this._extensionUri = extensionUri;
    this._workspaceRoot = workspaceRoot;

    this._server = new EscapeRoomServer();
    this._server.onStatusChange((s) => {
      this._status = s;
      this._syncSidebar();
    });
    this._server.onLog((line) => this._appendLog(line));
  }

  // ── Sidebar (WebviewView) ─────────────────────────────────────────────────

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
    view.webview.html = this._getSidebarHtml(view.webview);
    view.webview.onDidReceiveMessage(async (msg) => {
      switch (msg.command) {
        case 'ready': this._syncSidebar(); break;
        case 'launch': await this.launch(); break;
        case 'stop': await this.stop(); break;
        case 'openTerminal': this.openTerminalPanel(); break;
        case 'openDocs': this.openDocsPanel(); break;
      }
    });
  }

  // ── Public API ────────────────────────────────────────────────────────────

  async launch(): Promise<void> {
    if (this._status === 'starting' || this._status === 'running') {
      vscode.window.showInformationMessage('Escape Room is already running.');
      return;
    }

    const config = vscode.workspace.getConfiguration('bashEscapeRoom');
    const port = config.get<number>('port', 3000);
    const autoOpen = config.get<boolean>('autoOpen', true);
    const roomsPath = config.get<string>('roomsPath', '') ||
      path.join(this._workspaceRoot, 'content', 'escapeRoom');
    const docsPath = path.join(this._workspaceRoot, 'mkdocs-site');
    const publicPath = path.join(this._workspaceRoot, '.escaperoom-framework', 'public');

    try {
      await this._server.start({ port, roomsPath, docsPath, publicPath });
      if (autoOpen) { this.openTerminalPanel(); }
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : String(err);
      vscode.window.showErrorMessage(`Bash Escape Room failed to start: ${msg}`);
    }
  }

  async stop(): Promise<void> {
    this._appendLog('Stopping server…');
    await this._server.stop();
    // Close open panels
    this._terminalPanel?.dispose();
    this._docsPanel?.dispose();
  }

  openTerminalPanel(): void {
    const config = vscode.workspace.getConfiguration('bashEscapeRoom');
    const port = config.get<number>('port', 3000);
    const url = `http://localhost:${port}`;

    if (this._terminalPanel) {
      this._terminalPanel.reveal(vscode.ViewColumn.One);
      return;
    }

    this._terminalPanel = vscode.window.createWebviewPanel(
      'bashEscapeRoom.terminal',
      '🏃 Bash Escape Room',
      vscode.ViewColumn.One,
      {
        enableScripts: true,
        retainContextWhenHidden: true,
        // Allow loading from localhost
        localResourceRoots: [],
      }
    );

    this._terminalPanel.webview.html = this._getFrameHtml(
      this._terminalPanel.webview,
      url,
      '🏃 Bash Escape Room - Terminal'
    );

    this._terminalPanel.onDidDispose(() => {
      this._terminalPanel = undefined;
    });
  }

  openDocsPanel(): void {
    const config = vscode.workspace.getConfiguration('bashEscapeRoom');
    const port = config.get<number>('port', 3000);
    const url = `http://localhost:${port}/docs/`;

    if (this._docsPanel) {
      this._docsPanel.reveal(vscode.ViewColumn.Two);
      return;
    }

    this._docsPanel = vscode.window.createWebviewPanel(
      'bashEscapeRoom.docs',
      '📖 Escape Room Docs',
      vscode.ViewColumn.Two,
      {
        enableScripts: true,
        retainContextWhenHidden: true,
        localResourceRoots: [],
      }
    );

    this._docsPanel.webview.html = this._getFrameHtml(
      this._docsPanel.webview,
      url,
      '📖 Bash Escape Room - Documentation'
    );

    this._docsPanel.onDidDispose(() => {
      this._docsPanel = undefined;
    });
  }

  // ── Sync sidebar state ────────────────────────────────────────────────────

  private _syncSidebar(): void {
    const config = vscode.workspace.getConfiguration('bashEscapeRoom');
    this._sidebarView?.webview.postMessage({
      command: 'setState',
      status: this._status,
      port: config.get<number>('port', 3000),
      logs: this._logs,
    });
  }

  private _appendLog(line: string): void {
    this._logs.push(line);
    if (this._logs.length > 400) { this._logs.shift(); }
    this._sidebarView?.webview.postMessage({ command: 'appendLog', line });
  }

  // ── Full-tab WebviewPanel HTML (iframe pointing at localhost) ─────────────
  //
  // VS Code WebviewPanel cannot directly load http:// URLs via src, but we can
  // use the simpleBrowser approach: render the content ourselves by proxying,
  // OR instruct VS Code to open simpleBrowser. The cleanest approach that works
  // without Content-Security-Policy issues is to use VS Code's built-in
  // simpleBrowser command (which is what "Open Simple Browser" does).
  // We keep our own panel as a wrapper with toolbar buttons.

  private _getFrameHtml(
    _webview: vscode.Webview,
    url: string,
    title: string
  ): string {
    // We embed a meta-redirect + message to open the simple browser.
    // The panel itself becomes a launcher/status page that also offers
    // a "Reload" and "Open in external browser" button.
    const nonce = getNonce();
    return /* html */`<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta http-equiv="Content-Security-Policy"
    content="default-src 'none'; script-src 'nonce-${nonce}'; style-src 'unsafe-inline';"/>
  <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    body {
      background: #0d0d1a;
      color: #c8d0e0;
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
      display: flex;
      flex-direction: column;
      height: 100vh;
      align-items: center;
      justify-content: center;
      gap: 24px;
    }
    .title { font-size: 22px; font-weight: 700; color: #e94560; }
    .url   { font-size: 13px; color: #1abc9c; font-family: monospace; }
    .hint  { font-size: 12px; color: #5a6072; max-width: 380px; text-align: center; line-height: 1.6; }
    .actions { display: flex; gap: 12px; flex-wrap: wrap; justify-content: center; }
    .btn {
      padding: 8px 18px;
      border-radius: 6px;
      border: none;
      font-size: 13px;
      cursor: pointer;
      font-weight: 600;
      transition: filter .15s;
    }
    .btn:hover { filter: brightness(1.15); }
    .btn-primary { background: #e94560; color: #fff; }
    .btn-ghost   { background: #1e1e3f; color: #c8d0e0; border: 1px solid #1e1e3f; }
    #status { font-size: 12px; color: #fab387; }
  </style>
</head>
<body>
  <div class="title">${escHtml(title)}</div>
  <div class="url">${escHtml(url)}</div>
  <div id="status">Opening Simple Browser…</div>
  <div class="actions">
    <button class="btn btn-primary" id="btn-simple">Open in VS Code Browser</button>
    <button class="btn btn-ghost"   id="btn-ext">Open in External Browser</button>
  </div>
  <div class="hint">
    The escape room runs on <strong style="color:#1abc9c">${escHtml(url)}</strong>.<br/>
    Click "Open in VS Code Browser" to launch it in a VS Code tab,
    or "Open in External Browser" to view it in your default browser.
  </div>
  <script nonce="${nonce}">
    const vscode = acquireVsCodeApi();
    const TARGET = ${JSON.stringify(url)};

    document.getElementById('btn-simple').addEventListener('click', () => {
      vscode.postMessage({ command: 'openSimpleBrowser', url: TARGET });
    });
    document.getElementById('btn-ext').addEventListener('click', () => {
      vscode.postMessage({ command: 'openExternal', url: TARGET });
    });

    // Auto-open simple browser after a short delay
    setTimeout(() => {
      vscode.postMessage({ command: 'openSimpleBrowser', url: TARGET });
      document.getElementById('status').textContent = 'Simple Browser launched ✓';
    }, 800);
  </script>
</body>
</html>`;
  }

  // ── Sidebar control panel HTML ────────────────────────────────────────────

  private _getSidebarHtml(webview: vscode.Webview): string {
    const nonce = getNonce();
    const cssUri = webview.asWebviewUri(
      vscode.Uri.joinPath(this._extensionUri, 'media', 'style.css')
    );
    const jsUri = webview.asWebviewUri(
      vscode.Uri.joinPath(this._extensionUri, 'media', 'panel.js')
    );

    return /* html */`<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta http-equiv="Content-Security-Policy"
    content="default-src 'none';
             style-src ${webview.cspSource} 'unsafe-inline';
             script-src 'nonce-${nonce}';"/>
  <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
  <link href="${cssUri}" rel="stylesheet"/>
  <title>Bash Escape Room</title>
</head>
<body>
<div id="app">
  <div class="header">
    <span class="header-icon">🏃</span>
    <span class="header-title">Bash Escape Room</span>
  </div>

  <div class="status-row">
    <div class="status-dot" id="status-dot"></div>
    <span class="status-text" id="status-text">Stopped</span>
    <span class="status-port hidden" id="status-port"></span>
  </div>

  <div class="actions">
    <button class="btn btn-primary" id="btn-launch"   onclick="launch()">▶ Launch</button>
    <button class="btn btn-ghost"   id="btn-terminal" onclick="openTerminal()" disabled>⬛ Terminal</button>
    <button class="btn btn-ghost"   id="btn-docs"     onclick="openDocs()"     disabled>📖 Docs</button>
    <button class="btn btn-danger"  id="btn-stop"     onclick="stop()"         disabled>■ Stop</button>
  </div>

  <div class="info-card">
    <div class="info-row">
      <span class="info-label">Mode</span>
      <span class="info-value">Native (no Docker)</span>
    </div>
    <div class="info-row">
      <span class="info-label">Port</span>
      <span class="info-value" id="info-port">-</span>
    </div>
    <div class="info-row">
      <span class="info-label">Terminal</span>
      <span class="info-value info-url" id="info-terminal" onclick="openTerminal()">-</span>
    </div>
    <div class="info-row">
      <span class="info-label">Docs</span>
      <span class="info-value info-url" id="info-docs" onclick="openDocs()">-</span>
    </div>
  </div>

  <div class="progress-wrap hidden" id="progress-wrap">
    <div class="progress-bar"><div class="progress-fill"></div></div>
    <span class="progress-label">Starting server…</span>
  </div>

  <div class="log-header">
    <span>Logs</span>
    <button class="btn-clear" onclick="clearLogs()">clear</button>
  </div>
  <div class="log-box" id="log-box"></div>
</div>
<script nonce="${nonce}" src="${jsUri}"></script>
</body>
</html>`;
  }
}

function getNonce(): string {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  return Array.from({ length: 32 }, () =>
    chars[Math.floor(Math.random() * chars.length)]
  ).join('');
}

function escHtml(s: string): string {
  return s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
}
