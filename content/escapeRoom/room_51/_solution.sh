#!/usr/bin/env bash
# Room 51 Solution - Command Assembler (xargs)
# Password: chownit

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 51: Command Assembler ==="
echo ""

# Run setup if parts don't exist
if [ ! -d parts ]; then
    bash setup.sh
fi

# Ensure parts directory is traversable
chmod -R 755 parts/ 2>/dev/null

sum=$(find parts/ -name "*.part" | xargs grep -h "VALUE=" | cut -d= -f2 | awk '{s+=$1} END {print s}')
echo "Sum: $sum"
bash script.sh "$sum"
