#!/usr/bin/env bash
# Room 99 Solution - The Exit Exam
# This room asks 5 random Linux command questions interactively.
# Run ./getKey.sh and answer the questions correctly.

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 99: The Exit Exam ==="
echo ""
echo "This room is interactive - run: bash getKey.sh"
echo "Answer 5 random Linux command questions correctly to complete the escape room."
echo ""
echo "Common topics: commands, symbols, directories, operators"
echo "Examples: ls, grep, find, |, >, /etc, /var, etc."
