#!/usr/bin/env bash
# Room 27 Solution - Array Unique Weapons
# Password: array10

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Room 27: Array Unique Weapons ==="
echo ""

count=$(sort "$ROOM_DIR/weapons.txt" | uniq | wc -l | tr -d ' ')
echo "Password: array${count}"
