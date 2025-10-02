#!/bin/bash

# Clear screen
clear

# Get the pwd of the this script
SCRIPT_PATH=$(dirname -- "${BASH_SOURCE[0]}")

# Load the colors
if [ -x "${SCRIPT_PATH}/_utils.sh" ]; 
then
   source "${SCRIPT_PATH}/_utils.sh"
fi

echo -e "${YELLOW}"
echo -e "--------------------------------------------"
echo -e "           Linux Bash Escape Room           "                     
echo -e "--------------------------------------------"
echo -e ""

slow_typing "- Welcome to the Linux Bash Escape Room." ${PURPLE} 
slow_typing "- This place is full of secrets and only the chosen ones can escape ... " ${GREEN}
slow_typing "- The folder /home/escape/escapeRooms contain the different rooms (folders names room_xx)" ${PURPLE} 
slow_typing "- Each folder has an encrypted room_XX.sh file (except the first room README - This file)" ${GREEN}
slow_typing "- To reveal the next room room_XX.sh file, following the clues ..." ${PURPLE} 
echo -e "- Every room_XX.sh file uses ${GREEN}'vim encryption' ${NO_COLOR} ... " ${GREEN}
slow_typing "- To run (decrypt) them you will need a password (key), which you will get at the end of each room... " ${PURPLE} 

slow_typing ""
slow_typing ">> Tip 01: " ${CYAN} 
slow_typing "   Once you open the encrypted file, the command: " ${CYAN} 
echo -e     "   ${GREEN}:set key=${NO_COLOR}." 
slow_typing "   will unlock the file for you to read it." ${CYAN}
slow_typing "   Don't forget to save the changes with (ESC + :wq) in order to keep the file unlocked (keep it in mind for other rooms)." ${CYAN} 
  
slow_typing "" ${CYAN}
slow_typing ">> Tip 02: " ${CYAN} 
slow_typing "   To make the magic happen (delete, rename, change ownership, create files and etc.) " ${CYAN}  
slow_typing "   you will need your secret sudo password: " ${CYAN}
echo -e     "   ${YELLOW}escape${NO_COLOR}." 

echo -e ""
echo -e "${RED}>>> Press any key to continue to room #01${NO_COLOR}"

# Wait for user input to continue (max timeout 600 seconds)
read -t 600 -n 1

# Clear the screen
clear

echo -e     ""
slow_typing "This is what you need to do in the First room (room_01):" ${BYELLOW} 
echo -e      "---------------------------------------------------------"

slow_typing "Welcome to your first room." ${GREEN} 
slow_typing "1. Go to 'room_files' folder" ${GREEN} 

slow_typing "2. Delete/move/filter-out all the files with '.txt' extension." ${YELLOW}
slow_typing "   - highly recommended to backup the folder before you make changes" ${YELLOW} 

slow_typing "3. Sort the remaining files by 'size' " ${GREEN} 
slow_typing "   - Ascending Order, including the hidden files!! " ${GREEN} 
  
slow_typing "4. View the file names on the screen, then take the [first letter] of each filename top-to-bottom." ${YELLOW} 
 
slow_typing "5. Once you discover the hidden message, move to the next room." ${GREEN} 

slow_typing "6. Open the README file using the hidden message in [lowercase] without spaces..." ${YELLOW} 

echo -e "${CYAN}>> Reminder: ${NO_COLOR}" 
echo -e "${CYAN}      Once you open the encrypted file, the command: ${YELLOW}:set key=${NO_COLOR}. "
echo -e "${CYAN}      Don't forget to save ${YELLOW}(:wq)${CYAN} in order to keep the file unlocked (keep it in mind for other rooms).${NO_COLOR}"  
      
echo -e ""
echo -e ""
