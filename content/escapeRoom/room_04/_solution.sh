#!/usr/bin/env bash
# Room 04 Solution - Cipher
# Password: sedmaster

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Room 04: The Cipher ==="
echo ""

# Decode the substitution cipher using sed
decoded=$(sed 's/Z7/s/g; s/Q3/e/g; s/X9/d/g; s/K1/m/g; s/J2/a/g; s/W8/t/g; s/P6/r/g' "$ROOM_DIR/cipher.txt")
echo "$decoded"
echo ""
echo "Password: sedmaster"
