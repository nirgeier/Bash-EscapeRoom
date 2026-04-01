#!/usr/bin/env bash
# Room 33 Solution - getopts Flags
# Password: optparse

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 33: getopts Flags ==="
echo ""

bash locked_program.sh -u agent -p 1337 -v
