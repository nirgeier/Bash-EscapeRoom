#!/usr/bin/env bash
# Room 38 Solution - Countdown Timeout
# Password: timeout3

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 38: Countdown Timeout ==="
echo ""

# Clear previous log
> progress.log

# Run countdown and kill after 5 seconds (timeout not available on macOS)
if command -v timeout &>/dev/null; then
    timeout 5 bash countdown.sh || true
else
    bash countdown.sh &
    BG_PID=$!
    sleep 5
    kill "$BG_PID" 2>/dev/null
    wait "$BG_PID" 2>/dev/null
fi
sleep 0.3

# Extract BOMB_CODE
password=$(grep "BOMB_CODE" progress.log | tail -1 | cut -d'=' -f2)
echo "Password: $password"
