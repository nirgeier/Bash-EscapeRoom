/**
 * Embedded escape room server - replaces Docker.
 *
 * Lightweight HTTP-only server (no node-pty, no WebSocket).
 * The terminal is provided by VS Code's built-in createTerminal() API.
 *
 * The server:
 *   - Serves the MkDocs static site  (/docs/*)
 *   - Exposes /config and /health
 *   - Exposes /room-change  (called by _utils.sh when user types next/room)
 */

import * as http from 'http';
import * as path from 'path';
import * as fs from 'fs';
// eslint-disable-next-line @typescript-eslint/no-var-requires
const express = require('express');

export interface ServerConfig {
  port: number;
  /** Absolute path to content/escapeRoom/  */
  roomsPath: string;
  /** Absolute path to mkdocs-site/         */
  docsPath: string;
  /** Absolute path to .escaperoom-framework/public/ (unused, kept for API compat) */
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
    this._setupRoomPermissions(cfg.roomsPath);

    this._log('  Creating HTTP server…');
    const app = express();

    // ── Static: MkDocs site at /docs ─────────────────────────────────────
    if (fs.existsSync(cfg.docsPath)) {
      app.use('/docs', express.static(cfg.docsPath));
      this._log(`  ✓ Docs → ${cfg.docsPath}`);
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

    // ── Listen - auto-advance port if busy ───────────────────────────────
    const port = await new Promise<number>((resolve, reject) => {
      const server = http.createServer(app);
      this._httpServer = server;
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
  }

  private _setStatus(s: ServerStatus): void {
    this._status = s;
    this._onStatusChange?.(s);
  }

  private _log(line: string): void {
    this._onLog?.(line);
  }
}
