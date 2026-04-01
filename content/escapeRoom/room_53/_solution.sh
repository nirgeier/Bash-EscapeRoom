#!/usr/bin/env bash
# Room 53 Solution - Network Probe
# Password: monitor5

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 53: Network Probe ==="
echo ""

# Start the beacon server in background
bash start_server.sh &
SERVER_PID=$!
sleep 1

# Retrieve key
password=$(wget -q -O - http://127.0.0.1:9053/key.txt 2>/dev/null || curl -s http://127.0.0.1:9053/key.txt 2>/dev/null)
kill "$SERVER_PID" 2>/dev/null

if [ -z "$password" ]; then
    # Read directly from www directory
    password=$(cat www/key.txt 2>/dev/null)
fi
echo "Password: $password"
