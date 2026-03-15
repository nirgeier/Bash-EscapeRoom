#!/bin/bash
source ../_utils.sh

ANSWER=$1

if [ -z "$ANSWER" ]; then
    echo "Usage: ./getKey.sh <sum>"
    echo "Hint: sum the numeric values decoded from all .key files in final_challenge/"
    exit 1
fi

if [ "$ANSWER" = "1000" ]; then
    echo ""
    echo -e "${BGreen}MASTER TERMINAL UNLOCKED!${NO_COLOR}"
    echo -e "${BYELLOW}You have completed all 50 rooms!${NO_COLOR}"
    echo ""
    echo -e "The password for the Final Exam is: ${BYELLOW}masterkey${NO_COLOR}"
    echo ""
    echo -e "${BGreen}Congratulations! You are a true Bash Master!${NO_COLOR}"
else
    echo -e "${BRed}Incorrect sum. Check your pipeline.${NO_COLOR}"
    echo "Hint: decode each .key file with base64 -d, filter numeric values, sum them"
fi
