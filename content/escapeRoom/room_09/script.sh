#!/bin/bash

source ../_utils.sh

# Find the ghost_user's process
function getPID(){
    PID=$(ps -eo pid,user,args | grep ghost_user | grep ghost_loop | grep -v grep | awk '{print $1}')
    if [ -z "$PID" ]; then
        PID=-1
    fi
}

getPID

if [ "$PID" == "-1" ]; then
    echo -e "${BRed}Cannot find ghost_user's ghost_loop process.${NO_COLOR}"
    echo "Make sure you:"
    echo " - Created user 'ghost_user'"
    echo " - Created script 'ghost_loop.sh'"
    echo " - Running it as ghost_user in the background"
    exit 1
fi

if [[ "$PID" == "$1" ]]; then
    echo -e "${BGreen}Ghost captured!${NO_COLOR}"
    echo -e "Process management mastered!"
    echo -e "The password for the next room is: ${BYELLOW}daemon77${NO_COLOR}"
    sudo kill -9 $PID 2>/dev/null
else
    echo -e "${BRed}Wrong PID. The ghost is still hiding!${NO_COLOR}"
    echo "Expected PID: $PID"
    echo "You provided: $1"
fi
