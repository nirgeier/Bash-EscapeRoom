#!/usr/bin/env bash
# Room 44 Solution - rsync
# Password: synced

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 44: rsync ==="
echo ""

# Run setup if source_archive doesn't exist
if [ ! -d source_archive ]; then
    bash setup.sh
fi

rsync -av --delete source_archive/ mirror_archive/
echo ""
bash script.sh
