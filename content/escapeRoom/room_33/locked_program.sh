#!/bin/bash

source ../_utils.sh

username=""
pin=""
verbose=false

while getopts "u:p:vh" opt; do
    case $opt in
        u) username="$OPTARG" ;;
        p) pin="$OPTARG" ;;
        v) verbose=true ;;
        h) echo "Usage: $0 -u <username> -p <pin> [-v]"; exit 0 ;;
        ?) echo "Unknown option: $opt"; exit 1 ;;
    esac
done

if $verbose; then
    echo "Checking credentials..."
    echo "Username: $username"
fi

if [ "$username" = "agent" ] && [ "$pin" = "1337" ]; then
    echo ""
    echo -e "${BGreen}Access granted!${NO_COLOR}"
    echo -e "The password for the next room is: ${BYELLOW}optparse${NO_COLOR}"
    echo ""
else
    echo -e "${BRed}Access denied. Invalid username or PIN.${NO_COLOR}"
    echo "Hint: username is 'agent', PIN is a famous hacker number"
fi
