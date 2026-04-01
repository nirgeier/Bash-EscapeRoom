#!/usr/bin/env bash
# Room 15 Solution - JSON Database
# Password: json64

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Room 15: JSON Database ==="
echo ""

password=$(jq -r '.agents[] | select(.status == "active") | .code' "$ROOM_DIR/database.json" | sort | tr -d '\n')
echo "Password: $password"
