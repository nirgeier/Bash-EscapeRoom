#!/usr/bin/env bash
# Room 47 Solution - SSH Key Auth
# Password: sshkey

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 47: SSH Key Authentication ==="
echo ""

# Use the shortcut
password=$(cat ssh_secret.txt)
echo "Password: $password"
