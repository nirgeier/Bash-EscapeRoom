#!/bin/bash

source ../_utils.sh

CURRENT_YEAR=$(date +%Y)
errors=0

read -p "Question 1: What shell are we using? " ans1
if [ "$ans1" != "bash" ]; then
    echo -e "${BRed}Wrong! Expected: bash${NO_COLOR}"
    errors=$((errors + 1))
else
    echo -e "${BGreen}Correct!${NO_COLOR}"
fi

read -p "Question 2: What is the name of this game? " ans2
if [ "$ans2" != "escape" ]; then
    echo -e "${BRed}Wrong! Expected: escape${NO_COLOR}"
    errors=$((errors + 1))
else
    echo -e "${BGreen}Correct!${NO_COLOR}"
fi

read -p "Question 3: What is the current year? " ans3
if [ "$ans3" != "$CURRENT_YEAR" ]; then
    echo -e "${BRed}Wrong! Expected: $CURRENT_YEAR${NO_COLOR}"
    errors=$((errors + 1))
else
    echo -e "${BGreen}Correct!${NO_COLOR}"
fi

echo ""
if [ $errors -eq 0 ]; then
    echo -e "${BGreen}All questions answered correctly!${NO_COLOR}"
    echo -e "The password for the next room is: ${BYELLOW}readline${NO_COLOR}"
else
    echo -e "${BRed}$errors answer(s) wrong. Try again!${NO_COLOR}"
fi
