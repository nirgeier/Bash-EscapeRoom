#!/bin/bash

########################################
### Colors
########################################
# Reset
NO_COLOR='\033[0m' # Text Reset

# Regular Colors
Black='\033[0;30m'  # Black
RED='\033[0;31m'    # Red
GREEN='\033[0;32m'  # Green
YELLOW='\033[0;33m' # Yellow
Blue='\033[0;34m'   # Blue
PURPLE='\033[0;35m' # PURPLE
CYAN='\033[0;36m'   # Cyan
White='\033[0;37m'  # White

# Bold
BBlack='\033[1;30m'  # Black
BRed='\033[1;31m'    # Red
BGreen='\033[1;32m'  # Green
BYELLOW='\033[1;33m' # Yellow
BBlue='\033[1;34m'   # Blue
BPURPLE='\033[1;35m' # PURPLE
BCyan='\033[1;36m'   # Cyan
BWhite='\033[1;37m'  # White

# Function to encrypt file with OpenSSL AES-256-CBC
encrypt_file() {
    local file=$1
    local key=$2
    openssl enc -aes-256-cbc -a -salt -pbkdf2 \
        -in "$file" -out "${file}.enc" \
        -pass pass:"$key" 2>/dev/null
    mv "${file}.enc" "$file"
}

# Function to decrypt file with OpenSSL AES-256-CBC
# Usage: decrypt_file <file> <password>
decrypt_file() {
    local file=$1
    local key=$2
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
        -in "$file" -out "${file}.dec" \
        -pass pass:"$key" 2>/dev/null
    mv "${file}.dec" "$file"
}

#
###   a bash script that echoes its argument 2 character
###   per second.
###

# Get the desired string to print
function slow_typing() {
    text=$1
    color="${2:-'\033[0;33m'}"
    # Loop over the text
    for ((i = 0; i < ${#text}; i += 1)); do
        # Print out the next letter
        echo -n -e "${color}${text:$i:1}${NO_COLOR}"
        # Adjust the sleep time to control the speed of typing
        # 0.005 seconds = 200 characters per minute
        #sleep 0.005
        sleep 0
    done
    echo
}

# Print a markdown file with formatting
# Usage: print_readme [file]  (defaults to README)
print_readme() {
    local file="${1:-README}"
    if command -v glow &>/dev/null; then
        glow "$file"
    else
        cat "$file"
    fi
}

# Check script for error during execution
# usage: trap 'handle_error' ERR
handle_error() {
    local exit_code=$?
    echo "An error occurred with exit code $exit_code"
    exit $exit_code
}
