#!/usr/bin/env bash
# Room 05 Solution - 3-Layer Decoder
# Password: translate

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Room 05: 3-Layer Decoder ==="
echo ""

# Undo layers in reverse: base64 decode -> ROT13 -> reverse
if command -v base64 &>/dev/null; then
    # macOS uses -D, Linux uses -d
    if base64 --version 2>/dev/null | grep -q GNU; then
        password=$(base64 -d "$ROOM_DIR/encoded_message.txt" | tr 'a-zA-Z' 'n-za-mN-ZA-M' | rev)
    else
        password=$(base64 -D -i "$ROOM_DIR/encoded_message.txt" | tr 'a-zA-Z' 'n-za-mN-ZA-M' | rev)
    fi
fi

echo "Password: $password"
