#!/usr/bin/env bash
# Room 54 Solution - System Monitor
# Password: sysinfo9

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 54: System Monitor ==="
echo ""

# Run setup if snapshot doesn't exist
if [ ! -f system_snapshot.txt ]; then
    bash setup.sh
fi

total_mem=$(grep "Mem:" system_snapshot.txt | awk '{print $2}')
load1=$(grep "load average" system_snapshot.txt | awk -F': ' '{print $2}' | cut -d, -f1 | xargs)
running=$(grep "running" system_snapshot.txt | awk '{print $4}')

echo "Total mem: ${total_mem}MB, Load: ${load1}, Running: ${running}"
bash script.sh "$total_mem" "$load1" "$running"
