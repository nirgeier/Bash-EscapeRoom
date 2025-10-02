#!/bin/bash

# Clear screen
clear

# Get the pwd of the this script
SCRIPT_PATH=$(dirname -- "${BASH_SOURCE[0]}")

# Load the colors
if [ -x "${SCRIPT_PATH}/../_utils.sh" ]; 
then
   source "${SCRIPT_PATH}/../_utils.sh"
fi

echo -e "${YELLOW}"
echo -e "--------------------------------------------"
echo -e "        Linux Bash Escape Room [02]         "                   
echo -e "--------------------------------------------"
echo -e "${NO_COLOR}"

slow_typing "- Welcome to Room 02." ${PURPLE} 
slow_typing "- This place is full of secrets and only the chosen ones can escape ... " ${GREEN}
slow_typing "- The folder /home/escape/escapeRooms contain the different rooms (folders names room_xx)" ${PURPLE} 
slow_typing "- Each folder has an encrypted README file (except the first room README - This file)" ${GREEN}
slow_typing "- To reveal the next room README file, following the clues ..." ${PURPLE} 
slow_typing "- Every README file uses 'vim encryption' ... to open them you will need a password (key)..." ${GREEN}

- Congratulations! You have reached room 02!!

To pass this room:
---------------------------------------------------------------------
- Follow the white rabbit!....
1. Find out the White Rabbit's user ID. 
   >> hint: read about users in Linux.
2. Search in `users_list.csv` file for the name of the user that has the IP which starts with this ID!!. 
   >> hint: use find/grep/cat/vim and etc.
4. Search for all the appearances of the **name** you found in Logs folder
5. Sort the results(content only) by alphabetical order

If all done correctly you will get the password for the next room

