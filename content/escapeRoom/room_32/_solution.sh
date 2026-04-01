#!/usr/bin/env bash
# Room 32 Solution - Assembly Functions
# Password: funcret

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 32: Assembly Functions ==="
echo ""

total=0
while IFS= read -r code; do
    [[ "$code" == PROD-* ]] && total=$(( total + ${code#PROD-} ))
done < assembly.txt

echo "Sum of PROD IDs: $total"
bash script.sh "$total"
