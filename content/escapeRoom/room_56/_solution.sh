#!/usr/bin/env bash
# Room 56 Solution - Process Controller
# Password: allclear

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 56: Process Controller ==="
echo ""

# Clean up any prior agents
pkill -f agent_keeper.sh 2>/dev/null || true
pkill -f agent_worker 2>/dev/null || true
sleep 0.5

# Launch agents
bash launch_agents.sh
sleep 1

# Kill the keeper and workers
pkill -f agent_keeper.sh 2>/dev/null || true
pkill -f agent_worker 2>/dev/null || true
sleep 1

bash script.sh
