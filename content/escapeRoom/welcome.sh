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
slow_typing "- The folder /home/escape/escapeRooms contains the different rooms (folders named room_xx)" ${PURPLE} 
slow_typing "- Each folder has an encrypted README file (except the first room)" ${GREEN}
slow_typing "- To reveal the next room README, follow the clues ..." ${PURPLE} 
echo -e "- Every README uses ${GREEN}'OpenSSL AES-256-CBC encryption' ${NO_COLOR} ... " ${GREEN}
slow_typing "- To decrypt them you will need a password (key), which you get at the end of each room... " ${PURPLE} 

slow_typing ""
slow_typing ">> Tip 01: " ${CYAN} 
slow_typing "   To decrypt a room README, use:" ${CYAN} 
echo -e     "   ${GREEN}openssl enc -aes-256-cbc -d -a -pbkdf2 -in README -out README.txt -pass pass:YOUR_PASSWORD${NO_COLOR}" 
echo -e     "   ${GREEN}mv README.txt README${NO_COLOR}" 
slow_typing "   Then you can read the decrypted file with: cat README" ${CYAN}
  
slow_typing "" ${CYAN}
slow_typing ">> Tip 02: " ${CYAN} 
slow_typing "   To make the magic happen (delete, rename, change ownership, create files etc.) " ${CYAN}  
slow_typing "   you will need your secret sudo password: " ${CYAN}
echo -e     "   ${YELLOW}escape${NO_COLOR}." 

slow_typing "" ${CYAN}
slow_typing ">> Sections: " ${CYAN} 
slow_typing "   🧭 Navigation & Discovery  (Rooms 01-03)" ${GREEN}
slow_typing "   ✏️  Text Mastery            (Rooms 04-06)" ${YELLOW}
slow_typing "   ⚙️  System Mastery          (Rooms 07-09)" ${PURPLE}
slow_typing "   🔗 Advanced Pipeline       (Rooms 10-12)" ${CYAN}
slow_typing "   🏆 The Exit Exam           (Room 99)" ${BRed}

echo -e ""
echo -e "${RED}>>> Press any key to continue to room #01${NO_COLOR}"

# Wait for user input to continue (max timeout 600 seconds)
read -t 600 -n 1

# Clear the screen
clear

echo -e     ""
slow_typing "This is what you need to do in the First room (room_01):" ${BYELLOW} 
echo -e      "---------------------------------------------------------"

slow_typing "Welcome to your first room: The Lost Expedition" ${GREEN} 
slow_typing "1. Go to the 'expedition/' directory" ${GREEN} 

slow_typing "2. The camp is littered with noise files (.rock, .leaf, .twig)" ${YELLOW}
slow_typing "   - You need to FIND the real map fragments hidden in subdirectories" ${YELLOW} 

slow_typing "3. Locate all files ending in '.map' " ${GREEN} 
slow_typing "   - hint: the 'find' command searches recursively!" ${GREEN} 
  
slow_typing "4. Sort the found paths alphabetically and cat their contents." ${YELLOW} 
 
slow_typing "5. The concatenated letters spell the password for the next room." ${GREEN} 

slow_typing "6. Decrypt the next room README with that password:" ${YELLOW} 

echo -e "${CYAN}>> Reminder: ${NO_COLOR}" 
echo -e "${CYAN}      To decrypt: ${YELLOW}openssl enc -aes-256-cbc -d -a -pbkdf2 -in README -out README.txt -pass pass:PASSWORD${NO_COLOR}"
echo -e "${CYAN}      Then: ${YELLOW}mv README.txt README${NO_COLOR}"
      
echo -e ""
echo -e ""
