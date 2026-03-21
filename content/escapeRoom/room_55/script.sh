#!/bin/bash
source ../_utils.sh

USERNAME=$1
KERNEL=$2

if [ -z "$USERNAME" ] || [ -z "$KERNEL" ]; then
    echo 'Usage: ./getKey.sh "$(whoami)" "$(uname -s)"'
    echo "Hint: These commands reveal your username and OS type"
    exit 1
fi

REAL_USER=$(whoami)
REAL_KERNEL=$(uname -s)

if [ "$USERNAME" = "$REAL_USER" ] && [ "$KERNEL" = "$REAL_KERNEL" ]; then
    echo ""
    echo -e "${BGreen}SYSTEM INSPECTOR COMPLETE!${NO_COLOR}"
    echo -e "${BYELLOW}System identity confirmed: ${USERNAME} on ${KERNEL}${NO_COLOR}"
    echo ""
    echo -e "The password for Room 56 is: ${BYELLOW}procctrl${NO_COLOR}"
    echo ""
else
    echo -e "${BRed}Incorrect system identity.${NO_COLOR}"
    echo 'Try: ./getKey.sh "$(whoami)" "$(uname -s)"'
fi
