#!/bin/bash
# Create a 1000-line file with the password on line 777
{
    for i in $(seq 1 776); do
        echo "Ancient text line $i: $(tr -dc 'a-z ' < /dev/urandom | fold -w 40 | head -n 1)"
    done
    echo "SECRET: vimmode"
    for i in $(seq 778 1000); do
        echo "Ancient text line $i: $(tr -dc 'a-z ' < /dev/urandom | fold -w 40 | head -n 1)"
    done
} > ancient_tome.txt
