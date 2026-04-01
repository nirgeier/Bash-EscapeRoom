#!/usr/bin/env bash
# Room 29 Solution - While Read Loop
# Password: while100

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 29: While Read Loop ==="
echo ""

# Run setup if door_log is empty (shuf not available on macOS, use simple generation)
if [ ! -s door_log.txt ]; then
    {
        for i in $(seq 1 100); do echo "door_$(printf '%03d' $i) OPEN"; done
        for i in $(seq 101 200); do echo "door_$(printf '%03d' $i) CLOSED"; done
    } > door_log.txt
fi

count=$(grep -c "OPEN" door_log.txt)
echo "Password: while${count}"
