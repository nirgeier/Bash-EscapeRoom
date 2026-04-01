#!/usr/bin/env bash
# Room 40 Solution - DNS TXT Record
# Password: resolve9

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Room 40: DNS TXT Record ==="
echo ""

# Try DNS query, fall back to file
password=$(dig TXT secret.escape.local +short 2>/dev/null | tr -d '"')
if [ -z "$password" ]; then
    password=$(cat "$ROOM_DIR/dns_fallback.txt")
    echo "Password (fallback): $password"
else
    echo "Password: $password"
fi
