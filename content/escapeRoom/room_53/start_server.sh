#!/bin/bash
PORT=9053
WWW_DIR="$(cd "$(dirname "$0")/www" && pwd)"

echo "Starting beacon server on port $PORT..."
echo "Retrieve the key with: wget -q -O - http://127.0.0.1:$PORT/key.txt"
echo "Press Ctrl+C to stop."

cd "$WWW_DIR"
if command -v python3 &>/dev/null; then
    python3 -m http.server $PORT
elif command -v python &>/dev/null; then
    python -m SimpleHTTPServer $PORT
else
    # Fallback: nc-based server
    while true; do
        echo -e "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nmonitor5" | nc -l -p $PORT -q 1
    done
fi
