#!/usr/bin/env bash
# Room 23 Solution - UNIX Timestamps
# Password: epoch6026

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Room 23: UNIX Timestamps ==="
echo ""

total=0
while IFS= read -r line; do
    [[ "$line" =~ ^# ]] && continue
    [[ -z "$line" ]] && continue
    # macOS: date -r, Linux: date -d @
    if date -r "$line" &>/dev/null 2>&1; then
        year=$(date -r "$line" +%Y)
    else
        year=$(date -d "@$line" +%Y)
    fi
    echo "  $line -> $year"
    total=$(( total + year ))
done < "$ROOM_DIR/timestamps.txt"

echo ""
echo "Sum of years: $total"
echo "Password: epoch${total}"
