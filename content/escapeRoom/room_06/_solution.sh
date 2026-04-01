#!/usr/bin/env bash
# Room 06 Solution - Vault Gems
# Password: unique<N>

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Room 06: Vault Gems ==="
echo ""

count=$(comm -23 <(sort "$ROOM_DIR/vault_a.txt" | uniq) <(sort "$ROOM_DIR/vault_b.txt" | uniq) | wc -l | tr -d ' ')
echo "Password: unique${count}"
