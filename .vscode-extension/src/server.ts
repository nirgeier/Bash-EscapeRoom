/**
 * Embedded escape room server - replaces Docker.
 *
 * Spawns a Node.js/express + node-pty server in-process so the extension
 * needs no Docker at all. The server:
 *   - Serves the xterm.js web terminal UI  (public/index.html)
 *   - Serves the MkDocs static site        (/docs/*)
 *   - Exposes a WebSocket terminal         (ws://localhost:<port>)
 *   - Exposes /config and /health
 */

import * as http from 'http';
import * as path from 'path';
import * as fs from 'fs';
import * as os from 'os';
// express and ws are bundled by esbuild into extension.js
// node-pty is external (native binary) - loaded from node_modules at runtime
// eslint-disable-next-line @typescript-eslint/no-var-requires
const express = require('express');
// eslint-disable-next-line @typescript-eslint/no-var-requires
const WebSocket = require('ws');
// node-pty must resolve from the extension's own node_modules
// eslint-disable-next-line @typescript-eslint/no-var-requires
const pty = require('node-pty');

export interface ServerConfig {
  port: number;
  /** Absolute path to content/escapeRoom/  */
  roomsPath: string;
  /** Absolute path to mkdocs-site/         */
  docsPath: string;
  /** Absolute path to .escaperoom-framework/public/ */
  publicPath: string;
}

export type ServerStatus = 'stopped' | 'starting' | 'running' | 'error';

export class EscapeRoomServer {
  private _httpServer?: ReturnType<typeof http.createServer>;
  private _status: ServerStatus = 'stopped';
  private _onStatusChange?: (s: ServerStatus) => void;
  private _onLog?: (line: string) => void;
  private _onRoomChange?: (room: number) => void;
  private _port: number = 3000;

  get status(): ServerStatus { return this._status; }
  get port(): number { return this._port; }

  onStatusChange(cb: (s: ServerStatus) => void): void { this._onStatusChange = cb; }
  onLog(cb: (line: string) => void): void { this._onLog = cb; }
  onRoomChange(cb: (room: number) => void): void { this._onRoomChange = cb; }

  async start(cfg: ServerConfig): Promise<void> {
    if (this._status === 'running' || this._status === 'starting') { return; }
    this._log('▶ Starting Bash Escape Room server…');
    this._log(`  rooms  : ${cfg.roomsPath}`);
    this._log(`  docs   : ${cfg.docsPath}`);
    this._log(`  public : ${cfg.publicPath}`);
    this._setStatus('starting');

    try {
      await this._boot(cfg);
      this._setStatus('running');
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : String(err);
      this._log(`❌ Boot failed: ${msg}`);
      this._setStatus('error');
      throw err;
    }
  }

  async stop(): Promise<void> {
    this._log('■ Stopping server…');
    await new Promise<void>((resolve) => {
      if (this._httpServer) {
        this._httpServer.close(() => resolve());
      } else {
        resolve();
      }
    });
    this._httpServer = undefined;
    this._log('✅ Server stopped');
    this._setStatus('stopped');
  }

  private _setupRoomPermissions(roomsPath: string): void {
    this._log('  Setting room_07 gate permissions…');
    // Room 07 - set deliberately wrong gate permissions (mirrors Dockerfile)
    const gates: Record<string, number> = {
      gate_1: 0o000, gate_2: 0o777, gate_3: 0o644,
      gate_4: 0o755, gate_5: 0o000, gate_6: 0o777, gate_7: 0o644,
    };
    let ok = 0, skip = 0;
    for (const [gate, mode] of Object.entries(gates)) {
      const p = path.join(roomsPath, 'room_07', gate);
      try { fs.chmodSync(p, mode); ok++; } catch { skip++; }
    }
    this._log(`  room_07: ${ok} gates set, ${skip} skipped`);
  }

  private async _boot(cfg: ServerConfig): Promise<void> {
    // Apply room permissions that can't be stored in VSIX
    this._setupRoomPermissions(cfg.roomsPath);

    this._log('  Creating HTTP + WebSocket server…');
    const app = express();
    const server = http.createServer(app);
    const wss = new WebSocket.Server({ server });

    // ── Static: web terminal UI ──────────────────────────────────────────
    if (fs.existsSync(cfg.publicPath)) {
      app.use(express.static(cfg.publicPath));
      this._log(`  ✓ Terminal UI  → ${cfg.publicPath}`);
    } else {
      this._log(`⚠️  public/ not found at ${cfg.publicPath} - using built-in terminal`);
    }

    // ── Static: MkDocs site at /docs ─────────────────────────────────────
    if (fs.existsSync(cfg.docsPath)) {
      app.use('/docs', express.static(cfg.docsPath));
      this._log(`  ✓ Docs         → ${cfg.docsPath}`);
    } else {
      this._log(`⚠️  mkdocs-site/ not found at ${cfg.docsPath}`);
    }

    // ── /config ──────────────────────────────────────────────────────────
    app.get('/config', (_req: unknown, res: { json: (o: unknown) => void }) => {
      res.json({
        title: 'Bash Escape Room',
        totalRooms: 56,
        accentColor: '#e94560',
        accent2Color: '#1abc9c',
        bgDeep: '#0d0d1a',
        bgPanel: '#12122a',
        bgHeader: '#0a0a1f',
        border: '#1e1e3f',
        docsUrl: '/docs/',
      });
    });

    // ── Fallback terminal UI (when no publicPath) ─────────────────────────
    app.get('/', (_req: unknown, res: { send: (s: string) => void }) => {
      res.send(TERMINAL_HTML(cfg.port));
    });

    // ── /health ──────────────────────────────────────────────────────────
    app.get('/health', (_req: unknown, res: { json: (o: unknown) => void }) => {
      res.json({ status: 'ready' });
    });

    // ── /room-change - called by _utils.sh when user types room/next ──────
    app.use(express.json());
    app.post('/room-change', (req: { body: { room?: number } }, res: { json: (o: unknown) => void }) => {
      const room = Number(req.body?.room);
      if (room > 0) { this._onRoomChange?.(room); }
      res.json({ ok: true });
    });

    // ── WebSocket terminal ────────────────────────────────────────────────
    wss.on('connection', (ws: typeof WebSocket) => {
      this._log('Terminal client connected');

      // Spawn a bash shell with the escape room environment set up
      const shell = pty.spawn('bash', ['--login'], {
        name: 'xterm-256color',
        cols: 120,
        rows: 40,
        cwd: cfg.roomsPath,
        env: {
          ...process.env,
          TERM: 'xterm-256color',
          LANG: 'en_US.UTF-8',
          HOME: os.homedir(),
          ESCAPE_ROOMS: cfg.roomsPath,
          // Inject the helper functions inline via BASH_ENV
          BASH_ENV: path.join(cfg.roomsPath, '_utils.sh'),
          PS1: '\\[\\033[01;32m\\]escape\\[\\033[00m\\]:\\[\\033[01;34m\\]\\w\\[\\033[00m\\]\\$ ',
        },
      });

      // Change into room_01 on first connect + source helpers
      const initCmd =
        `[ -f "${cfg.roomsPath}/_utils.sh" ] && source "${cfg.roomsPath}/_utils.sh"; ` +
        `cd "${cfg.roomsPath}/room_01" 2>/dev/null || true; ` +
        `echo -e "\\033[0;32mWelcome to Bash Escape Room!\\033[0m"; ` +
        `echo -e "\\033[0;36mYou are in room_01. Type 'ls' to begin.\\033[0m"\n`;
      shell.write(initCmd);

      shell.onData((data: string) => {
        try { ws.send(JSON.stringify({ type: 'output', data })); } catch { /* ws closed */ }
      });

      shell.onExit(({ exitCode }: { exitCode: number }) => {
        try { ws.send(JSON.stringify({ type: 'exit', exitCode })); ws.close(); } catch { /* ok */ }
        this._log(`Shell exited (code ${exitCode})`);
      });

      ws.on('message', (msg: Buffer | string) => {
        try {
          const message = JSON.parse(msg.toString());
          switch (message.type) {
            case 'input': shell.write(message.data); break;
            case 'resize':
              if (message.cols && message.rows) { shell.resize(message.cols, message.rows); }
              break;
          }
        } catch { /* ignore bad frames */ }
      });

      ws.on('close', () => { shell.kill(); this._log('Terminal client disconnected'); });
    });

    // ── Listen - auto-advance port if busy ───────────────────────────────
    const port = await new Promise<number>((resolve, reject) => {
      const tryPort = (p: number) => {
        server.removeAllListeners('error');
        server.on('error', (err: NodeJS.ErrnoException) => {
          if (err.code === 'EADDRINUSE' && p < cfg.port + 10) {
            this._log(`Port ${p} in use, trying ${p + 1}…`);
            tryPort(p + 1);
          } else {
            reject(err);
          }
        });
        server.listen(p, '127.0.0.1', () => resolve(p));
      };
      tryPort(cfg.port);
    });
    this._log(`✅ Server ready on http://localhost:${port}`);
    this._port = port;
    this._httpServer = server;
  }

  private _setStatus(s: ServerStatus): void {
    this._status = s;
    this._onStatusChange?.(s);
  }

  private _log(line: string): void {
    this._onLog?.(line);
  }
}

// ── Built-in xterm.js terminal UI ─────────────────────────────────────────────
function TERMINAL_HTML(port: number): string {
  return `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <title>Bash Escape Room - Terminal</title>
  <script src="https://cdn.jsdelivr.net/npm/xterm@5.3.0/lib/xterm.min.js"><\/script>
  <script src="https://cdn.jsdelivr.net/npm/xterm-addon-fit@0.8.0/lib/xterm-addon-fit.min.js"><\/script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/xterm@5.3.0/css/xterm.min.css"/>
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { background: #0d0d1a; display: flex; flex-direction: column; height: 100vh; font-family: monospace; }
    #header { background: #0a0a1f; padding: 8px 16px; color: #e94560; font-size: 13px; font-weight: 700; border-bottom: 1px solid #1e1e3f; }
    #terminal { flex: 1; padding: 8px; }
  </style>
</head>
<body>
  <div id="header">🏃 Bash Escape Room - Terminal</div>
  <div id="terminal"></div>
  <script>
    const term = new Terminal({ cursorBlink: true, fontSize: 14, theme: { background: '#0d0d1a', foreground: '#c8d0e0', cursor: '#e94560' } });
    const fitAddon = new FitAddon.FitAddon();
    term.loadAddon(fitAddon);
    term.open(document.getElementById('terminal'));
    fitAddon.fit();

    const ws = new WebSocket('ws://localhost:${port}');
    ws.onopen = () => { ws.send(JSON.stringify({ type: 'resize', cols: term.cols, rows: term.rows })); };
    ws.onmessage = (e) => { const m = JSON.parse(e.data); if (m.type === 'output') term.write(m.data); };
    ws.onclose = () => term.write('\\r\\n\\x1b[31m[disconnected]\\x1b[0m\\r\\n');
    term.onData((d) => ws.send(JSON.stringify({ type: 'input', data: d })));
    window.addEventListener('resize', () => { fitAddon.fit(); ws.send(JSON.stringify({ type: 'resize', cols: term.cols, rows: term.rows })); });
  <\/script>
</body>
</html>`;
}
