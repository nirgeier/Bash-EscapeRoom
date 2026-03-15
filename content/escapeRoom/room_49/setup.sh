#!/bin/bash
# Create factory_log.txt
# M001 has 9 successes (the most), so password = pipeline9
{
    # M001: 9 successes, 3 failures
    for i in $(seq 1 9); do
        echo "2024-01-$(printf '%02d' $i) M001 SUCCESS $((50 + i * 7))"
    done
    for i in $(seq 10 12); do
        echo "2024-01-$(printf '%02d' $i) M001 FAILURE $((i * 3))"
    done
    # M002: 6 successes
    for i in $(seq 1 6); do
        echo "2024-01-$(printf '%02d' $i) M002 SUCCESS $((60 + i * 5))"
    done
    # M003: 4 successes
    for i in $(seq 1 4); do
        echo "2024-01-$(printf '%02d' $i) M003 SUCCESS $((40 + i * 9))"
    done
    # M004: 7 successes
    for i in $(seq 1 7); do
        echo "2024-01-$(printf '%02d' $i) M004 SUCCESS $((55 + i * 6))"
    done
    # M005: 2 successes
    for i in $(seq 1 2); do
        echo "2024-01-$(printf '%02d' $i) M005 SUCCESS $((30 + i * 4))"
    done
} | shuf > factory_log.txt
