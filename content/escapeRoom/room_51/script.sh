#!/bin/bash
source ../_utils.sh

ANSWER=$1

if [ -z "$ANSWER" ]; then
    echo "Usage: ./getKey.sh <sum>"
    echo "Hint: find parts/ -name '*.part' | xargs grep -h 'VALUE=' | cut -d= -f2 | paste -sd+ | bc"
    exit 1
fi

if [ "$ANSWER" = "777" ]; then
    echo ""
    echo -e "${BGreen}COMMAND ASSEMBLER UNLOCKED!${NO_COLOR}"
    echo -e "${BYELLOW}The xargs master has assembled the truth!${NO_COLOR}"
    echo ""
    echo -e "The password for Room 52 is: ${BYELLOW}chownit${NO_COLOR}"
    echo ""
else
    echo -e "${BRed}Incorrect sum. Check your xargs pipeline.${NO_COLOR}"
    echo "Hint: find parts/ -name '*.part' | xargs grep -h 'VALUE=' | cut -d= -f2 | paste -sd+ | bc"
fi
