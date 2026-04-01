#!/usr/bin/env bash
# Room 09 Solution - Ghost Process
# Password: daemon77

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 09: Ghost Process ==="
echo ""

# Create ghost_loop.sh
cat > /tmp/ghost_loop.sh << 'LOOP'
#!/bin/bash
while true; do sleep 1; done
LOOP
chmod +x /tmp/ghost_loop.sh

# Create ghost_user if it doesn't exist
if ! id ghost_user &>/dev/null; then
    if command -v useradd &>/dev/null; then
        sudo useradd ghost_user 2>/dev/null || true
    elif command -v adduser &>/dev/null; then
        sudo adduser -D ghost_user 2>/dev/null || true
    fi
fi

# Run as ghost_user in background
sudo -u ghost_user bash /tmp/ghost_loop.sh &
sleep 1

# Find PID
PID=$(ps -eo pid,user,args | grep ghost_user | grep ghost_loop | grep -v grep | awk '{print $1}' | head -1)
echo "Ghost PID: $PID"

bash script.sh "$PID"
