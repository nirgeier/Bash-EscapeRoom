const express = require("express");
const http = require("http");
const WebSocket = require("ws");
const pty = require("node-pty");
const path = require("path");

const app = express();
const server = http.createServer(app);
const wss = new WebSocket.Server({ server });

const PORT = process.env.PORT || 3000;

// Serve static files
app.use(express.static(path.join(__dirname, "public")));

// Serve built mkdocs site at /docs/ (DOCS_DIR env var or ./docs/ fallback)
const docsDir = process.env.DOCS_DIR || path.join(__dirname, "docs");
app.use("/docs", express.static(docsDir));

// Health check — returns 200 only when escape user setup is complete
const fs = require("fs");
const READY_FILE = "/tmp/escape-room-ready";
app.get("/health", (req, res) => {
  if (fs.existsSync(READY_FILE)) {
    res.json({ status: "ready" });
  } else {
    res.status(503).json({ status: "starting" });
  }
});

// WebSocket connection handling
wss.on("connection", (ws) => {
  // Spawn a login shell as the 'escape' user so .bash_profile is sourced
  // and the user lands in room_01 with the welcome message
  const shell = pty.spawn("su", ["-", "escape"], {
    name: "xterm-256color",
    cols: 120,
    rows: 40,
    cwd: "/",
    env: { TERM: "xterm-256color", LANG: "en_US.UTF-8" },
  });

  // Send shell output to the client
  shell.onData((data) => {
    try {
      ws.send(JSON.stringify({ type: "output", data }));
    } catch (e) {
      // Client disconnected
    }
  });

  // Handle shell exit
  shell.onExit(({ exitCode }) => {
    try {
      ws.send(JSON.stringify({ type: "exit", exitCode }));
      ws.close();
    } catch (e) {
      // Client already disconnected
    }
  });

  // Receive input from the client
  ws.on("message", (msg) => {
    try {
      const message = JSON.parse(msg);
      switch (message.type) {
        case "input":
          shell.write(message.data);
          break;
        case "resize":
          if (message.cols && message.rows) {
            shell.resize(message.cols, message.rows);
          }
          break;
      }
    } catch (e) {
      // Ignore malformed messages
    }
  });

  // Clean up on disconnect
  ws.on("close", () => {
    shell.kill();
  });
});

server.listen(PORT, "0.0.0.0", () => {
  console.log("");
  console.log("╔══════════════════════════════════════════════════╗");
  console.log("║   Bash Escape Room - Container Ready             ║");
  console.log("║                                                  ║");
  console.log("║   All rooms initialized and encrypted.           ║");
  console.log("║   Open:  http://localhost:3000                   ║");
  console.log("╚══════════════════════════════════════════════════╝");
  console.log("");
});
