#!/usr/bin/env bash
# Room 13 Solution - Symlink Labyrinth
# Password: link42

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 13: Symlink Labyrinth ==="
echo ""

# Run setup if symlinks don't exist
if [ ! -L start.link ]; then
    bash setup.sh
fi

password=$(cat start.link)
echo "Password: $password"
