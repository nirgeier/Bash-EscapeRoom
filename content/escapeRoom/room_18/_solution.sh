#!/usr/bin/env bash
# Room 18 Solution - Blueprint Diff
# Password: patch13

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Room 18: Blueprint Diff ==="
echo ""

added=$(diff "$ROOM_DIR/blueprint_v1.txt" "$ROOM_DIR/blueprint_v2.txt" | grep '^>' | sed 's/^> //')
echo "Added line: $added"
# Extract the password word (after "SecretCode: ")
password=$(echo "$added" | awk -F': ' '{print $2}')
echo "Password: $password"
