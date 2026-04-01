#!/usr/bin/env bash
# Room 14 Solution - Web Server
# Password: webfetch

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Room 14: Network Tools - Web Server ==="
echo ""

# Try live server first, fall back to backup file
if curl -s --connect-timeout 2 http://localhost:3456/ &>/dev/null; then
    password=$(curl -s -H "X-Access-Key: escape" http://localhost:3456/secret)
    echo "Password: $password"
else
    password=$(cat "$ROOM_DIR/backup_password.txt")
    echo "Password (fallback): $password"
fi
