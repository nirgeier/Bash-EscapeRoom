#!/usr/bin/env bash
# Room 17 Solution - Cron Schedule
# Password: cron5min

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Room 17: Cron Schedule ==="
echo ""

# Find ALARM cron entry and extract the */N interval
interval=$(grep -A1 "# ALARM" "$ROOM_DIR/schedule.cron" | grep -v "# ALARM" | awk '{print $1}' | grep -o '[0-9]*')
echo "Password: cron${interval}min"
