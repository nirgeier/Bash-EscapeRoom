#!/usr/bin/env bash
# Room 16 Solution - Space Station Storage
# Password: modulereactor

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 16: Space Station Storage ==="
echo ""

# Run setup if station dir doesn't exist
if [ ! -d station ]; then
    bash setup.sh
fi

largest=$(du -sh station/*/ | sort -rh | head -1 | awk '{print $2}' | xargs basename)
echo "Password: module${largest}"
