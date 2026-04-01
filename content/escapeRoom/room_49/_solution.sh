#!/usr/bin/env bash
# Room 49 Solution - Factory Pipeline
# Password: pipeline9

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 49: Factory Pipeline ==="
echo ""

# Run setup if factory_log doesn't exist (uses shuf which may not be on macOS)
if [ ! -s factory_log.txt ]; then
    {
        for i in $(seq 1 9); do echo "2024-01-$(printf '%02d' $i) M001 SUCCESS $((50+i*7))"; done
        for i in $(seq 10 12); do echo "2024-01-$(printf '%02d' $i) M001 FAILURE $((i*3))"; done
        for i in $(seq 1 6); do echo "2024-01-$(printf '%02d' $i) M002 SUCCESS $((60+i*5))"; done
        for i in $(seq 1 4); do echo "2024-01-$(printf '%02d' $i) M003 SUCCESS $((40+i*9))"; done
        for i in $(seq 1 7); do echo "2024-01-$(printf '%02d' $i) M004 SUCCESS $((55+i*6))"; done
        for i in $(seq 1 2); do echo "2024-01-$(printf '%02d' $i) M005 SUCCESS $((30+i*4))"; done
    } > factory_log.txt
fi

result=$(awk '$3 == "SUCCESS" {print $2}' factory_log.txt | sort | uniq -c | sort -rn | head -1)
count=$(echo "$result" | awk '{print $1}')
echo "Top machine: $result"
echo "Password: pipeline${count}"
