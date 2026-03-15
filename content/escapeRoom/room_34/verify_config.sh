#!/bin/bash

source ../_utils.sh

mode=""
level=""
key=""

while IFS='=' read -r field value; do
    case "$field" in
        MODE)  mode="$value" ;;
        LEVEL) level="$value" ;;
        KEY)   key="$value" ;;
    esac
done

errors=0

if [ "$mode" != "escape" ]; then
    echo -e "${BRed}MODE must be 'escape' (got: '$mode')${NO_COLOR}"
    errors=$((errors + 1))
else
    echo -e "${BGreen}MODE: OK${NO_COLOR}"
fi

if [ "$level" != "master" ]; then
    echo -e "${BRed}LEVEL must be 'master' (got: '$level')${NO_COLOR}"
    errors=$((errors + 1))
else
    echo -e "${BGreen}LEVEL: OK${NO_COLOR}"
fi

if [ "$key" != "ancient" ]; then
    echo -e "${BRed}KEY must be 'ancient' (got: '$key')${NO_COLOR}"
    errors=$((errors + 1))
else
    echo -e "${BGreen}KEY: OK${NO_COLOR}"
fi

if [ $errors -eq 0 ]; then
    echo ""
    echo -e "${BGreen}Configuration verified!${NO_COLOR}"
    echo -e "The password for the next room is: ${BYELLOW}heredoc5${NO_COLOR}"
    echo ""
else
    echo ""
    echo -e "${BRed}$errors field(s) incorrect. Fix your heredoc!${NO_COLOR}"
fi
