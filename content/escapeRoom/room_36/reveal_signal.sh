#!/bin/bash
source ../_utils.sh
echo ""
echo -e "${BGreen}Signal intercepted!${NO_COLOR}"
echo -e "The password for the next room is: ${BYELLOW}sigcatch${NO_COLOR}"
echo ""
echo "Full challenge: write a script with 'trap' to catch SIGUSR1"
echo "Example:"
echo "  trap 'echo sigcatch > trap_result.txt' SIGUSR1"
echo "  while true; do sleep 1; done"
