#!/usr/bin/env bash
# Room 20 Solution - Hex Dump
# Password: deadbeef

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 20: Hex Dump ==="
echo ""

# Run setup if hex file doesn't exist
if [ ! -f hex_message.hex ]; then
    bash setup.sh
fi

password=$(xxd -r hex_message.hex)
echo "Password: $password"
