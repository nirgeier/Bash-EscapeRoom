#!/usr/bin/env bash
# Room 45 Solution - OpenSSL Decrypt
# Password: cipher99

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 45: OpenSSL Decrypt ==="
echo ""

# Run setup if encrypted file doesn't exist
if [ ! -f encrypted_message.enc ]; then
    bash setup.sh
fi

password=$(openssl enc -aes-256-cbc -d -a -pbkdf2 -in encrypted_message.enc -pass pass:cryptokey2024 2>/dev/null)
echo "Password: $password"
