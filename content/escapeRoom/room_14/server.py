#!/usr/bin/env python3
"""
Room 14 - Web Server Puzzle
Runs on port 3456 and exposes two endpoints:
  GET /         → lists available endpoints
  GET /secret   → requires header X-Access-Key: escape, returns {"password": "..."}
"""
import json
from http.server import BaseHTTPRequestHandler, HTTPServer

PASSWORD = "webfetch"
ACCESS_KEY = "escape"
PORT = 3456


class Room14Handler(BaseHTTPRequestHandler):
    def log_message(self, format, *args):  # suppress request logs
        pass

    def _send_json(self, code, data):
        body = json.dumps(data).encode()
        self.send_response(code)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def do_GET(self):
        if self.path == "/":
            self._send_json(200, {
                "message": "Welcome to the Room 14 server!",
                "endpoints": ["/secret"],
                "hint": "Try: curl -H \"X-Access-Key: escape\" http://localhost:3456/secret"
            })
        elif self.path == "/secret":
            key = self.headers.get("X-Access-Key", "")
            if key == ACCESS_KEY:
                self._send_json(200, {"password": PASSWORD})
            else:
                self._send_json(403, {
                    "error": "Forbidden",
                    "hint": "You need the right X-Access-Key header"
                })
        else:
            self._send_json(404, {"error": "Not found"})


if __name__ == "__main__":
    httpd = HTTPServer(("0.0.0.0", PORT), Room14Handler)
    print(f"[room14] server listening on port {PORT}", flush=True)
    httpd.serve_forever()
