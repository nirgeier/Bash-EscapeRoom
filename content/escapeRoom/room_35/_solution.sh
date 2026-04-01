#!/usr/bin/env bash
# Room 35 Solution - Process Substitution
# Password: nested42

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Room 35: Process Substitution ==="
echo ""

count=$(comm -12 <(sort "$ROOM_DIR/world_a.txt") <(sort "$ROOM_DIR/world_b.txt") | wc -l | tr -d ' ')
echo "Password: nested${count}"
