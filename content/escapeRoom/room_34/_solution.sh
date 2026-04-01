#!/usr/bin/env bash
# Room 34 Solution - Heredoc
# Password: heredoc5

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 34: Heredoc ==="
echo ""

bash verify_config.sh << 'EOF'
MODE=escape
LEVEL=master
KEY=ancient
EOF
