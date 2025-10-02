#!/bin/bash

setfattr /home/escape/escapeRooms/room_05/lockedDoor -n user.scriptLanguage -v "This is a NodeJs script" 
setfattr /home/escape/escapeRooms/room_05/lockedDoor -n user.showKey -v "Just ask me to: showKey and ill show you the key"

# Source utility functions
source /home/escape/escapeRooms/_utils.sh

# Print the welcome message
./escapeRooms/welcome.sh

# Room selection menu using whiptail
ROOM=$(whiptail --menu "Select a Room to Enter" 20 60 12 \
1 "Room 01" \
2 "Room 02" \
3 "Room 03" \
4 "Room 04" \
5 "Room 05" \
6 "Room 06" \
7 "Room 07" \
8 "Room 08" \
9 "Room 09" \
10 "Room 10" \
11 "Room 11" \
12 "Room 12" \
3>&1 1>&2 2>&3)

# Exit if cancelled
if [ $? -ne 0 ]; then
    echo "Exiting..."
    exit 0
fi

# Format room number with leading zero for 1-9
if [ "$ROOM" -lt 10 ]; then
    ROOM_DIR="room_0$ROOM"
else
    ROOM_DIR="room_$ROOM"
fi

# Switch to the selected room
cd /home/escape/escapeRooms/$ROOM_DIR

# Open bash
bash

