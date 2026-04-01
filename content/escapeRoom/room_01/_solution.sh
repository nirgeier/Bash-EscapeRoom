#!/usr/bin/env bash
# Room 01 Solution - The Lost Expedition
# Password: northstar

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Room 01: The Lost Expedition ==="
echo ""

# Find all .map files, sort by path, concatenate contents
password=$(find "$ROOM_DIR/expedition" -name "*.map" | sort | xargs cat | tr -d '\n')
echo "Password: $password"
