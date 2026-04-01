#!/usr/bin/env bash
# Room 03 Solution - The Time Capsule
# Password: rewind99

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Room 03: The Time Capsule ==="
echo ""

lines=$(wc -l < "$ROOM_DIR/time_capsule.txt" | tr -d ' ')
# Reverse line order (tac on Linux, tail -r on macOS), take first line, reverse chars
if command -v tac &>/dev/null; then
    word=$(tac "$ROOM_DIR/time_capsule.txt" | head -1 | rev)
else
    word=$(tail -r "$ROOM_DIR/time_capsule.txt" | head -1 | rev)
fi
# Extract just the secret word from "The secret word is: WORD"
secret=$(echo "$word" | awk '{print $NF}')
echo "Password: ${secret}${lines}"
