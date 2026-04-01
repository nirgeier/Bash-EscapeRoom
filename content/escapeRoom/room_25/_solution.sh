#!/usr/bin/env bash
# Room 25 Solution - tee Pipeline
# Password: teeoff

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 25: tee Pipeline ==="
echo ""

password=$(bash generate_signal.sh | tee signal.log | grep "CODE:" | cut -d':' -f2 | tr -d ' ')
echo "Password: $password"
