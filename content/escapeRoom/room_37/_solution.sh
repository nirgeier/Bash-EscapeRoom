#!/usr/bin/env bash
# Room 37 Solution - Guardian Questions
# Password: readline

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 37: Guardian Questions ==="
echo ""

printf "bash\nescape\n$(date +%Y)\n" | bash guardian.sh
