#!/usr/bin/env bash
# Room 26 Solution - Parameter Expansion
# Password: expand99

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Room 26: Parameter Expansion ==="
echo ""

source "$ROOM_DIR/vault_env.sh"
password="${TREASURE_PATH##*/}"
echo "Password: $password"
