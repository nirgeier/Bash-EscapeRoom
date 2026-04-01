#!/usr/bin/env bash
# Room 46 Solution - Vim / sed line 777
# Password: vimmode

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 46: Text Editor (line 777) ==="
echo ""

# Run setup if file doesn't exist
if [ ! -f ancient_tome.txt ]; then
    bash setup.sh
fi

line=$(sed -n '777p' ancient_tome.txt)
echo "Line 777: $line"
password=$(echo "$line" | awk -F': ' '{print $2}')
echo "Password: $password"
