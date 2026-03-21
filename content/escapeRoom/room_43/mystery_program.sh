#!/bin/bash
source ../_utils.sh

# Simulate a mystery binary that writes its output via system calls
sleep 0.1

# Write the password to stdout
echo ""
echo -e "${BGreen}Mystery program executed!${NO_COLOR}"
echo -e "The password for the next room is: ${BYELLOW}syscall${NO_COLOR}"
echo ""
echo "ADVANCED: run with 'strace bash mystery_program.sh 2>&1 | grep write'"
echo "to see the underlying write() system calls."
