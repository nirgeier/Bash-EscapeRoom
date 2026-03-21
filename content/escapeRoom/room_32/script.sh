#!/bin/bash
source ../_utils.sh

ANSWER=$1

if [ -z "$ANSWER" ]; then
    echo "Usage: ./getKey.sh <sum_of_valid_product_IDs>"
    echo "Sum the numeric parts of all PROD-XX lines in assembly.txt"
    exit 1
fi

if [ "$ANSWER" = "200" ]; then
    echo ""
    echo -e "${BGreen}Correct! All functions validated!${NO_COLOR}"
    echo -e "The password for the next room is: ${BYELLOW}funcret${NO_COLOR}"
    echo ""
else
    echo -e "${BRed}Incorrect sum. Hint: only process lines starting with PROD-${NO_COLOR}"
fi
