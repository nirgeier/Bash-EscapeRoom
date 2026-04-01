#!/usr/bin/env bash
# Room 22 Solution - Math Equations
# Password: calc1337

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Room 22: Math Equations ==="
echo ""

# Extract and solve each equation
sum=0
while IFS= read -r line; do
    # Skip comment lines and empty lines
    [[ "$line" =~ ^# ]] && continue
    [[ -z "$line" ]] && continue
    result=$(echo "$line" | bc)
    echo "  $line = $result"
    sum=$(( sum + result ))
done < "$ROOM_DIR/equations.txt"

echo ""
echo "Sum: $sum"
echo "Password: calc${sum}"
