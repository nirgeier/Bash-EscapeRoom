#!/bin/bash

source ../_utils.sh

QUESTIONS=()
ANSWERS=()

### File & Directory Commands
QUESTIONS+=("Which command searches recursively for files by name, size, type, etc? (4 chars)")
ANSWERS+=("find")
QUESTIONS+=("Which command counts lines, words, and characters in a file? (2 chars)")
ANSWERS+=("wc")
QUESTIONS+=("Which command reverses the order of lines in a file? (3 chars)")
ANSWERS+=("tac")
QUESTIONS+=("Which command reverses characters within each line? (3 chars)")
ANSWERS+=("rev")
QUESTIONS+=("Which command performs find-and-replace on text streams? (3 chars)")
ANSWERS+=("sed")
QUESTIONS+=("Which command translates or deletes characters? (2 chars)")
ANSWERS+=("tr")
QUESTIONS+=("Which command decodes base64-encoded data? (6 chars)")
ANSWERS+=("base64")
QUESTIONS+=("Which command compares two sorted files line by line? (4 chars)")
ANSWERS+=("comm")
QUESTIONS+=("Which command compares two files and shows differences? (4 chars)")
ANSWERS+=("diff")
QUESTIONS+=("Which command changes file permissions? (5 chars)")
ANSWERS+=("chmod")
QUESTIONS+=("Which command changes file ownership? (5 chars)")
ANSWERS+=("chown")
QUESTIONS+=("Which command displays file or filesystem status? (4 chars)")
ANSWERS+=("stat")
QUESTIONS+=("Which command sets or displays environment variables? (6 chars)")
ANSWERS+=("export")
QUESTIONS+=("Which command creates a shortcut for a long command? (5 chars)")
ANSWERS+=("alias")
QUESTIONS+=("Which command runs another file's commands in current shell? (6 chars)")
ANSWERS+=("source")
QUESTIONS+=("Which command shows running processes? (2 chars)")
ANSWERS+=("ps")
QUESTIONS+=("Which command sends a signal to a process? (4 chars)")
ANSWERS+=("kill")
QUESTIONS+=("Which command displays process activity in real-time? (3 chars)")
ANSWERS+=("top")
QUESTIONS+=("Which command processes text with pattern-action rules? (3 chars)")
ANSWERS+=("awk")
QUESTIONS+=("Which command creates compressed tar archives? (3 chars)")
ANSWERS+=("tar")
QUESTIONS+=("Which command compresses files using the gzip algorithm? (4 chars)")
ANSWERS+=("gzip")
QUESTIONS+=("Which command builds and runs commands from stdin? (5 chars)")
ANSWERS+=("xargs")
QUESTIONS+=("Which command extracts sections from each line? (3 chars)")
ANSWERS+=("cut")
QUESTIONS+=("Which command merges lines of files side by side? (5 chars)")
ANSWERS+=("paste")
QUESTIONS+=("Which command sorts lines of text? (4 chars)")
ANSWERS+=("sort")
QUESTIONS+=("Which command filters out adjacent duplicate lines? (4 chars)")
ANSWERS+=("uniq")
QUESTIONS+=("Which command displays first N lines of a file? (4 chars)")
ANSWERS+=("head")
QUESTIONS+=("Which command displays last N lines of a file? (4 chars)")
ANSWERS+=("tail")
QUESTIONS+=("Which command searches for text patterns in files? (4 chars)")
ANSWERS+=("grep")
QUESTIONS+=("Which command displays the contents of a file? (3 chars)")
ANSWERS+=("cat")
QUESTIONS+=("Which command lists files and directories? (2 chars)")
ANSWERS+=("ls")
QUESTIONS+=("Which command creates new directories? (5 chars)")
ANSWERS+=("mkdir")
QUESTIONS+=("Which command removes files or directories? (2 chars)")
ANSWERS+=("rm")
QUESTIONS+=("Which command copies files and directories? (2 chars)")
ANSWERS+=("cp")
QUESTIONS+=("Which command moves or renames files? (2 chars)")
ANSWERS+=("mv")
QUESTIONS+=("Which command creates empty files or updates timestamps? (5 chars)")
ANSWERS+=("touch")
QUESTIONS+=("Which command identifies a file's type? (4 chars)")
ANSWERS+=("file")
QUESTIONS+=("Which command shows disk space usage of files? (2 chars)")
ANSWERS+=("du")
QUESTIONS+=("Which command shows free disk space on filesystems? (2 chars)")
ANSWERS+=("df")
QUESTIONS+=("Which command wraps text at a specified width? (4 chars)")
ANSWERS+=("fold")
QUESTIONS+=("Which command creates a new system user? (7 chars)")
ANSWERS+=("useradd")
QUESTIONS+=("Which command prints or sets the system date and time? (4 chars)")
ANSWERS+=("date")
QUESTIONS+=("Which command decrypts AES-256-CBC encrypted files? (7 chars)")
ANSWERS+=("openssl")
QUESTIONS+=("Which command displays the current working directory? (3 chars)")
ANSWERS+=("pwd")
QUESTIONS+=("Which command downloads files from the web? (4 chars)")
ANSWERS+=("curl")
QUESTIONS+=("Which command reads extended file attributes? (8 chars)")
ANSWERS+=("getfattr")
QUESTIONS+=("Which command creates symbolic and hard links? (2 chars)")
ANSWERS+=("ln")
QUESTIONS+=("Which command shows command history? (7 chars)")
ANSWERS+=("history")
QUESTIONS+=("Which command shows manual pages for commands? (3 chars)")
ANSWERS+=("man")
QUESTIONS+=("Which command runs a command with superuser privileges? (4 chars)")
ANSWERS+=("sudo")
QUESTIONS+=("Which command generates sequences of numbers? (3 chars)")
ANSWERS+=("seq")

### Symbols / Operators
QUESTIONS+=("Which symbol is used for comments in bash? (1 char)")
ANSWERS+=("#")
QUESTIONS+=("Which flag sends cd to the previous directory? (1 char)")
ANSWERS+=("-")
QUESTIONS+=("Which operator appends output to a file? (2 chars)")
ANSWERS+=(">>")
QUESTIONS+=("Which symbol represents the home directory? (1 char)")
ANSWERS+=("~")
QUESTIONS+=("Which operator runs the next command only if the previous succeeded? (2 chars)")
ANSWERS+=("&&")
QUESTIONS+=("Which symbol repeats the last command? (2 chars)")
ANSWERS+=("!!")
QUESTIONS+=("What is the permission string (rwxrwxrwx) for numeric mode 654? (9 chars)")
ANSWERS+=("rw-r-xr--")

# Randomly select 5 questions
echo -e ""
echo -e "${GREEN}To pass this room you need to answer 5 questions correctly.${NO_COLOR}"
echo -e "${GREEN}-----------------------------------------------------------------${NO_COLOR}"
echo -e ""

for ((i=0; i<5; i++)); do
  index=$((RANDOM % ${#QUESTIONS[@]}))

  echo -e "${YELLOW}- ${QUESTIONS[$index]}${NO_COLOR}"

  read -p "Answer: " answer

  if [[ -z "$answer" ]]; then
    echo -e "${BRed}You did not enter an answer. Try again.${NO_COLOR}"
    exit 1
  fi

  if [[ "$answer" == "${ANSWERS[$index]}" ]]; then
    echo -e "${BGreen}Correct!${NO_COLOR}"
    echo -e ""
  else
    echo -e "${BRed}Wrong answer! Try again.${NO_COLOR}"
    exit 1
  fi
done

echo -e "${BYELLOW}Password for the solution file is: ${BGreen}escaped${NO_COLOR}"
echo -e ""
echo -e " ██████████████ ██████████████ ██████████████ ██████████████ ██████████████ ██████████████ ████████████ "
echo -e " ██░░░░░░░░░░██ ██░░░░░░░░░░██ ██░░░░░░░░░░██ ██░░░░░░░░░░██ ██░░░░░░░░░░██ ██░░░░░░░░░░██ ██░░░░░░░░████ "
echo -e " ██░░██████████ ██░░██████████ ██░░██████████ ██░░██████░░██ ██░░██████░░██ ██░░██████████ ██░░████░░░░██ "
echo -e " ██░░██         ██░░██         ██░░██         ██░░██  ██░░██ ██░░██  ██░░██ ██░░██         ██░░██  ██░░██ "
echo -e " ██░░██████████ ██░░██████████ ██░░██         ██░░██████░░██ ██░░██████░░██ ██░░██████████ ██░░██  ██░░██ "
echo -e " ██░░░░░░░░░░██ ██░░░░░░░░░░██ ██░░██         ██░░░░░░░░░░██ ██░░░░░░░░░░██ ██░░░░░░░░░░██ ██░░██  ██░░██ "
echo -e " ██░░██████████ ██████████░░██ ██░░██         ██░░██████░░██ ██░░██████████ ██░░██████████ ██░░██  ██░░██ "
echo -e " ██░░██                 ██░░██ ██░░██         ██░░██  ██░░██ ██░░██         ██░░██         ██░░██  ██░░██ "
echo -e " ██░░██████████ ██████████░░██ ██░░██████████ ██░░██  ██░░██ ██░░██         ██░░██████████ ██░░████░░░░██ ██████ ██████ ██████ "
echo -e " ██░░░░░░░░░░██ ██░░░░░░░░░░██ ██░░░░░░░░░░██ ██░░██  ██░░██ ██░░██         ██░░░░░░░░░░██ ██░░░░░░░░████ ██░░██ ██░░██ ██░░██ "
echo -e " ██████████████ ██████████████ ██████████████ ██████  ██████ ██████         ██████████████ ████████████   ██████ ██████ ██████ "
echo -e ""
echo -e ""
