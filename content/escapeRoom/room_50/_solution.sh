#!/usr/bin/env bash
# Room 50 Solution - Final Challenge
# Password: masterkey

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 50: Final Challenge ==="
echo ""

# Run setup if final_challenge doesn't exist
if [ ! -d final_challenge ]; then
    bash setup.sh
fi

sum=$(find final_challenge/ -name "*.key" | sort | xargs -I{} sh -c \
    'base64 -d "$1" 2>/dev/null || base64 -D -i "$1" 2>/dev/null' -- {} \
    | grep -E '^[0-9]+$' | awk '{s+=$1} END {print s}')

echo "Sum: $sum"
bash script.sh "$sum"
