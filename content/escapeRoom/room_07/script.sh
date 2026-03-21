#!/bin/bash

source ../_utils.sh

EXPECTED=("755" "644" "700" "444" "775" "660" "511")
ALL_CORRECT=true

for i in {1..7}; do
    perm=$(stat -c "%a" "gate_$i" 2>/dev/null)
    expected="${EXPECTED[$((i-1))]}"
    if [ "$perm" != "$expected" ]; then
        echo -e "${BRed}Gate $i: permission $perm (expected $expected)${NO_COLOR}"
        ALL_CORRECT=false
    else
        echo -e "${BGreen}Gate $i: correct ($perm)${NO_COLOR}"
    fi
done

if $ALL_CORRECT; then
    echo ""
    echo -e "${BGreen}All gates unlocked!${NO_COLOR}"
    echo -e "The password for the next room is: ${BYELLOW}access42${NO_COLOR}"
    echo ""
else
    echo ""
    echo -e "${BRed}Some gates still have wrong permissions. Fix them!${NO_COLOR}"
fi
