#!/usr/bin/env bash
# Room 28 Solution - Loop and Sum Chambers
# Password: loop50

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 28: Loop and Sum Chambers ==="
echo ""

# Run setup if chambers don't exist
if [ ! -d chambers ]; then
    bash setup.sh
fi

total=0
for f in chambers/chamber_*.txt; do
    total=$(( total + $(cat "$f") ))
done
echo "Password: loop${total}"
