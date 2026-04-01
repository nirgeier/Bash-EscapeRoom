#!/usr/bin/env bash
# Room 07 Solution - Gate Permissions
# Password: access42

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 07: Gate Permissions ==="
echo ""

chmod 755 gate_1
chmod 644 gate_2
chmod 700 gate_3
chmod 444 gate_4
chmod 775 gate_5
chmod 660 gate_6
chmod 511 gate_7

# Verify permissions (macOS-compatible)
EXPECTED=("755" "644" "700" "444" "775" "660" "511")
ALL_CORRECT=true
for i in {1..7}; do
    perm=$(stat -c "%a" "gate_$i" 2>/dev/null || stat -f "%Lp" "gate_$i" 2>/dev/null)
    expected="${EXPECTED[$((i-1))]}"
    if [ "$perm" != "$expected" ]; then
        echo "Gate $i: FAIL (got $perm, expected $expected)"
        ALL_CORRECT=false
    else
        echo "Gate $i: OK ($perm)"
    fi
done

if $ALL_CORRECT; then
    echo ""
    echo "All gates unlocked!"
    echo "Password: access42"
fi
