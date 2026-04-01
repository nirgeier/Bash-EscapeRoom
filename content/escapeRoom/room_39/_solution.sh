#!/usr/bin/env bash
# Room 39 Solution - Network Socket
# Password: port80

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Room 39: Network Socket ==="
echo ""

# Try live port scan, fall back to file
port=$(ss -tlnp 2>/dev/null | grep ':8[0-9][0-9][0-9]' | awk '{print $4}' | cut -d: -f2 | head -1)
if [ -n "$port" ]; then
    password=$(curl -s "http://localhost:$port" || nc localhost "$port" 2>/dev/null)
    echo "Password: $password"
else
    password=$(cat "$ROOM_DIR/network_secret.txt")
    echo "Password (fallback): $password"
fi
