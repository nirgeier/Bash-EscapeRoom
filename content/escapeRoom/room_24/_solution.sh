#!/usr/bin/env bash
# Room 24 Solution - Printf Formatting
# Password: format77

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Room 24: Printf Formatting ==="
echo ""

printf "%-10s | %05d | %s\n" "alpha" 1 "noise"
printf "%-10s | %05d | %s\n" "beta" 2 "noise"
printf "%-10s | %05d | %s\n" "gamma" 3 "noise"
printf "%-10s | %05d | %s\n" "delta" 4 "noise"
printf "%-10s | %05d | %s\n" "key" 77 "format77"
echo ""
echo "Password: format77"
