#!/usr/bin/env node
// Room 14 - Web Server Puzzle
// GET /        → lists available endpoints
// GET /secret  → requires header X-Access-Key: escape, returns {"password":"..."}
const http = require("http");
const _0xd4c1 = (() => {
  const _s = [119, 101, 98, 102, 101, 116, 99, 104];
  const _k = [101, 115, 99, 97, 112, 101];
  return { p: String.fromCharCode(..._s), k: String.fromCharCode(..._k) };
})();
const _0x9b3a = 3456;
const _0x2f7c = (c, d) => {
  const b = JSON.stringify(d);
  return { code: c, body: b, len: Buffer.byteLength(b) };
};
http
  .createServer((req, res) => {
    const _send = (c, d) => {
      const { code, body, len } = _0x2f7c(c, d);
      res.writeHead(code, {
        "Content-Type": "application/json",
        "Content-Length": len,
      });
      res.end(body);
    };
    if (req.method !== "GET") {
      return _send(405, { error: "Method Not Allowed" });
    }
    const _p = req.url.split("?")[0];
    if (_p === "/") {
      _send(200, {
        message: "Welcome to the Room 14 server!",
        endpoints: ["/secret"],
        hint:
          'Try: curl -H "X-Access-Key: escape" http://localhost:' +
          _0x9b3a +
          "/secret",
      });
    } else if (_p === "/secret") {
      const _h = req.headers["x-access-key"] || "";
      if (_h === _0xd4c1.k) {
        _send(200, { password: _0xd4c1.p });
      } else {
        _send(403, {
          error: "Forbidden",
          hint: "You need the right X-Access-Key header",
        });
      }
    } else {
      _send(404, { error: "Not found" });
    }
  })
  .listen(_0x9b3a, "0.0.0.0", () => {
    process.stdout.write("[room14] server listening on port " + _0x9b3a + "\n");
  });
