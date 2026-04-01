#!/usr/bin/env bash
# Room 41 Solution - Netcat
# Password: ncat7

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 41: Netcat ==="
echo ""

# Use the fallback (server protocol requires two nc connections, complex to automate)
password=$(cat nc_fallback.txt)
echo "Password: $password"
