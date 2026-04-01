#!/usr/bin/env bash
# Room 21 Solution - Binary Analysis
# Password: hidden42

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 21: Binary Analysis ==="
echo ""

# Run setup if binary doesn't exist
if [ ! -f vault_binary ]; then
    bash setup.sh
fi

password=$(strings vault_binary | grep "PASSWORD" | cut -d'=' -f2)
echo "Password: $password"
