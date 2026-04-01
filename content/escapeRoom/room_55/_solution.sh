#!/usr/bin/env bash
# Room 55 Solution - System Inspector
# Password: procctrl

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 55: System Inspector ==="
echo ""

bash script.sh "$(whoami)" "$(uname -s)"
