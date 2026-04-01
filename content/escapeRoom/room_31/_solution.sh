#!/usr/bin/env bash
# Room 31 Solution - Dollar Signs
# Password: matched7

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Room 31: Dollar Signs ==="
echo ""

count=$(grep -c '\$' "$ROOM_DIR/symbols.txt")
echo "Password: matched${count}"
