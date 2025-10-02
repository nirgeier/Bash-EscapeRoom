#!/bin/bash

source ../_utils.sh

# Get the PID of the testUser
function getPID(){
    PID=$(ps -o pid,user,comm,args | grep testUser | grep room08 | awk '{print $1}')
    # If no PID is found, return -1
    if [ -z "$PID" ]; then
        PID=-1
    fi
}

getPID
# Check if an error occurred
if [ "$PID" != "$1" ]; 
then
    echo -e "${BRed}--------------------------------------------------${NO_COLOR}"
    echo -e "${BRed}   An error occurred. Try again${NO_COLOR}"
    echo -e "${BRed}   Verify that you done it correctly and Try again${NO_COLOR}"
    echo -e "${BRed}--------------------------------------------------${NO_COLOR}"
    exit 1
fi

# Check if we have passed the correct PID
if [[ $PID -eq $1 ]]
then
    echo -e "${GREEN}--------------------------------------------------${NO_COLOR}"
    echo -e "${GREEN}Good work.${NO_COLOR}"
    echo -e "${RED}- Im killing the process for you :-)${NO_COLOR}"
    echo -e "${GREEN}- In Linux ${CYAN}less${NO_COLOR} is ${CYAN}more${NO_COLOR} ...${NO_COLOR}"
    echo -e "${GREEN}- Password for the next room is: ${BYELLOW}less${BGreen}is${BYELLOW}more${NO_COLOR}"
    echo -e "${GREEN}--------------------------------------------------${NO_COLOR}"
    sudo kill -9 $PID
else
    echo -e "${YELLOW}Please make sure that you have done the following:${NO_COLOR}"
    echo -e "${YELLOW} - Script named:        'room08_proc'${NO_COLOR}"
    echo -e "${YELLOW} - Script is invoked as 'testUser'${NO_COLOR}"
fi

