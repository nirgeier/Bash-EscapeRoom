#!/usr/bin/env bash
# Room 12 Solution - Grand Pipeline
# Password: pipeline (first letters of city names, lowercase)

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Room 12: The Grand Pipeline ==="
echo ""

password=$(cut -d'|' -f1 "$ROOM_DIR/stations.txt" | cut -c1 | tr -d '\n' | tr 'A-Z' 'a-z')
echo "Password: $password"
