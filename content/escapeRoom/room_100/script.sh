#!/bin/bash

#source /home/escape/escapeRooms/_utils.sh
source  ../_utils.sh

QUESTIONS=()
ANSWERS=()

# Define the questions, choices and answers

### Commands
QUESTIONS+=("Which command is used to list files and directories in Linux? (2 chars)")
ANSWERS+=("ls")
QUESTIONS+=("Which command is used to change the current working directory in Linux? (2 chars)")
ANSWERS+=("cd")
QUESTIONS+=("Which command is used to change the permissions of files or directories in Linux? (5 chars)")
ANSWERS+=("chmod")
QUESTIONS+=("Which command is used to display the contents of a file in Linux? (3 chars)")
ANSWERS+=("cat")
QUESTIONS+=("Which command is used to extarct value from columns input? (3 chars)")
ANSWERS+=("awk")
QUESTIONS+=("Which command is used to execute a command with superuser privileges in Linux? (4 chars)")
ANSWERS+=("sudo")
QUESTIONS+=("Which command is used to create a new directory in Linux? (5 chars)")
ANSWERS+=("mkdir")
QUESTIONS+=("Which command is used to remove files or directories in Linux? (2 chars)")
ANSWERS+=("rm")
QUESTIONS+=("Which command is used to concatenate and display file content in Linux? (3 chars)")
ANSWERS+=("cat")
QUESTIONS+=("Which command is used to display the current directory in Linux? (3 chars)")
ANSWERS+=("pwd")
QUESTIONS+=("Which command is used to copy files or directories in Linux? (2 chars)")
ANSWERS+=("cp")
QUESTIONS+=("Which command is used to move or rename files or directories in Linux? (2 chars)")
ANSWERS+=("mv")
QUESTIONS+=("Which command is used to display the manual pages in Linux? (3 chars)")
ANSWERS+=("man")
QUESTIONS+=("Which command is used to search for files or directories based on different criteria in Linux? (4 chars)")
ANSWERS+=("find")
QUESTIONS+=("Which command is used to archive files in Linux (beside zip)? (3 chars)")
ANSWERS+=("tar")
QUESTIONS+=("Which command is used to show actual command behind the alias? (3 chars)");
ANSWERS+=("type");
QUESTIONS+=("Which command is an alias of 'ls -alF'? (** On most linux) (2 chars)");
ANSWERS+=("ll");
QUESTIONS+=("Which command is used to display running processes, sorted by cpu usage? (3 chars)");
ANSWERS+=("top");
QUESTIONS+=("Which command is used to print only first N lines of a file? (4 chars)");
ANSWERS+=("head");
QUESTIONS+=("Which command is used to print only last N lines of a file? (4 chars)");
ANSWERS+=("tail");
QUESTIONS+=("Which command is used to display disk space usage? (2 chars)");
ANSWERS+=("df");
QUESTIONS+=("Which file stores registered user? (5 chars)");
ANSWERS+=("passwd");
QUESTIONS+=("Which command is used to read files, which doesn’t need to load the full file while opening and allow to scroll up and down on the content? (4 chars)");
ANSWERS+=("less");
QUESTIONS+=("Which command is used to edit the sudoers file? (6 chars)");
ANSWERS+=("visudo");

# Folders
QUESTIONS+=("Under which folder add-on application software packages are located?");
ANSWERS+=("opt");

# Symbols / Operators
QUESTIONS+=("Which symbol is used as comment in script file? (1 char)")
ANSWERS+=("#");
QUESTIONS+=("Which flag can be passed to 'cd' command which takes you to the previous working directory? (1 char)");
ANSWERS+=("-");
QUESTIONS+=("Which operator is used for appendding content to file? (2 chars)");
ANSWERS+=(">>");
QUESTIONS+=("Which symbol represent home directory? (1 char)");
ANSWERS+=("~");
QUESTIONS+=("Which symbol is used for executing multiple commands in the order they are written? (2 chars)");
ANSWERS+=("&&");
QUESTIONS+=("Which symbol is used for executing previous command again? (2 chars)");
ANSWERS+=("!!");
QUESTIONS+=("What is the permission sequence (rwxrwxrwx) fo '546'? (9 chars)");
ANSWERS+=("r-xr--rw-");

# Randomly select 5 questions
echo -e ""
echo -e "${GREEN}To pass this room you will need to answer 5 question correctly.${NO_COLOR}"
echo -e "${GREEN}-----------------------------------------------------------------${NO_COLOR}"
echo -e ""

for ((i=0; i<5; i++)); do
  index=$((RANDOM % ${#QUESTIONS[@]}))
  
  # Print out the questions
  echo -e "${YELLOW}- ${QUESTIONS[$index]}${NO_COLOR}"
  
  # Wait for user answer
  read -p "Answer: " answer
  
  # Check to see if answer is empty
  if [[ -z "$answer" ]]; 
    then
        echo -e "${BRed}You did not enter an answer. Try again";
        exit 1;
    fi

  # Check answer
  if [[ "$answer" == "${ANSWERS[$index]}" ]]; 
  then
    echo -e "${BGreen}Correct!${NO_COLOR}"
    echo -e ""
  else
    echo -e "${BRed}Sorry, that's a wrong answer!${NO_COLOR}"
    echo -e "${BRed}Try again.${NO_COLOR}"
    exit 1
  fi
done

echo -e "${BYELLOW}Password for the solution file is: ${BGreen}exit${NO_COLOR}"
echo -e ""
echo -e ""
echo -e " ████████  ████████ ██████████████ ██████  ██████    ██████  ██████ ██████████████ ██████  ██████ ██████████████ "
echo -e " ██░░░░██  ██░░░░██ ██░░░░░░░░░░██ ██░░██  ██░░██    ██░░██  ██░░██ ██░░░░░░░░░░██ ██░░██  ██░░██ ██░░░░░░░░░░██ "
echo -e " ████░░██  ██░░████ ██░░██████░░██ ██░░██  ██░░██    ██░░██  ██░░██ ██░░██████░░██ ██░░██  ██░░██ ██░░██████████ "
echo -e "   ██░░░░██░░░░██   ██░░██  ██░░██ ██░░██  ██░░██    ██░░██  ██░░██ ██░░██  ██░░██ ██░░██  ██░░██ ██░░██         "
echo -e "   ████░░░░░░████   ██░░██  ██░░██ ██░░██  ██░░██    ██░░██████░░██ ██░░██████░░██ ██░░██  ██░░██ ██░░██████████ "
echo -e "     ████░░████     ██░░██  ██░░██ ██░░██  ██░░██    ██░░░░░░░░░░██ ██░░░░░░░░░░██ ██░░██  ██░░██ ██░░░░░░░░░░██ "
echo -e "       ██░░██       ██░░██  ██░░██ ██░░██  ██░░██    ██░░██████░░██ ██░░██████░░██ ██░░██  ██░░██ ██░░██████████ "
echo -e "       ██░░██       ██░░██  ██░░██ ██░░██  ██░░██    ██░░██  ██░░██ ██░░██  ██░░██ ██░░░░██░░░░██ ██░░██         "
echo -e "       ██░░██       ██░░██████░░██ ██░░██████░░██    ██░░██  ██░░██ ██░░██  ██░░██ ████░░░░░░████ ██░░██████████ "
echo -e "       ██░░██       ██░░░░░░░░░░██ ██░░░░░░░░░░██    ██░░██  ██░░██ ██░░██  ██░░██   ████░░████   ██░░░░░░░░░░██ "
echo -e "       ██████       ██████████████ ██████████████    ██████  ██████ ██████  ██████     ██████     ██████████████ "
echo -e "                                                                                                                 "
echo -e "                                                                                                                                      "
echo -e " ██████████████ ██████████████ ██████████████ ██████████████ ██████████████ ██████████████ ████████████                               "
echo -e " ██░░░░░░░░░░██ ██░░░░░░░░░░██ ██░░░░░░░░░░██ ██░░░░░░░░░░██ ██░░░░░░░░░░██ ██░░░░░░░░░░██ ██░░░░░░░░████                             "
echo -e " ██░░██████████ ██░░██████████ ██░░██████████ ██░░██████░░██ ██░░██████░░██ ██░░██████████ ██░░████░░░░██                             "
echo -e " ██░░██         ██░░██         ██░░██         ██░░██  ██░░██ ██░░██  ██░░██ ██░░██         ██░░██  ██░░██                             "
echo -e " ██░░██████████ ██░░██████████ ██░░██         ██░░██████░░██ ██░░██████░░██ ██░░██████████ ██░░██  ██░░██                             "
echo -e " ██░░░░░░░░░░██ ██░░░░░░░░░░██ ██░░██         ██░░░░░░░░░░██ ██░░░░░░░░░░██ ██░░░░░░░░░░██ ██░░██  ██░░██                             "
echo -e " ██░░██████████ ██████████░░██ ██░░██         ██░░██████░░██ ██░░██████████ ██░░██████████ ██░░██  ██░░██                             "
echo -e " ██░░██                 ██░░██ ██░░██         ██░░██  ██░░██ ██░░██         ██░░██         ██░░██  ██░░██                             "
echo -e " ██░░██████████ ██████████░░██ ██░░██████████ ██░░██  ██░░██ ██░░██         ██░░██████████ ██░░████░░░░██ ██████ ██████ ██████ ██████ "
echo -e " ██░░░░░░░░░░██ ██░░░░░░░░░░██ ██░░░░░░░░░░██ ██░░██  ██░░██ ██░░██         ██░░░░░░░░░░██ ██░░░░░░░░████ ██░░██ ██░░██ ██░░██ ██░░██ "
echo -e " ██████████████ ██████████████ ██████████████ ██████  ██████ ██████         ██████████████ ████████████   ██████ ██████ ██████ ██████ "
echo -e ""                                                                                                                                
echo -e ""                                                                                                                                

