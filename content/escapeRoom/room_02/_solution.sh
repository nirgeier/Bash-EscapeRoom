#!/usr/bin/env bash
# Room 02 Solution - Radio Intercepts
# Password: signal<N> where N = count of SOS lines

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Room 02: Radio Intercepts ==="
echo ""

count=$(grep -c "SOS" "$ROOM_DIR/radio_intercepts.txt")
echo "Password: signal${count}"
