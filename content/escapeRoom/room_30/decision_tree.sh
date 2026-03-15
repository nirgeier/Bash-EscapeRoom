#!/bin/bash
# Decision tree - find the correct arguments

NUM=$1
STR=$2

if [ -z "$NUM" ] || [ -z "$STR" ]; then
    echo "Usage: $0 <number> <string>"
    exit 1
fi

if [ "$NUM" -gt 0 ] 2>/dev/null; then
    if [ "$NUM" -lt 100 ]; then
        if [ "$NUM" -eq 42 ]; then
            if [ "$STR" = "unlock" ]; then
                echo "All conditions met!"
                echo "The password is: branch3"
            else
                echo "Wrong string. Hint: it means to open a lock."
            fi
        else
            echo "Wrong number. Hint: it is the answer to everything."
        fi
    else
        echo "Number too large. Must be less than 100."
    fi
else
    echo "Number must be positive."
fi
