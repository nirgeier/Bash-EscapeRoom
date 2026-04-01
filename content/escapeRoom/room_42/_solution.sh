#!/usr/bin/env bash
# Room 42 Solution - lsof
# Password: openfd

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 42: lsof ==="
echo ""

# Use the shortcut
password=$(cat lsof_secret.txt)
echo "Password: $password"
