#!/usr/bin/env bash
# Room 10 Solution - Data Mine
# Password: awk2025

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Room 10: The Data Mine ==="
echo ""

sum=$(awk -F',' 'NR>1 && $2>50 {s+=$3} END {print s}' "$ROOM_DIR/mine_data.csv")
echo "Password: awk${sum}"
