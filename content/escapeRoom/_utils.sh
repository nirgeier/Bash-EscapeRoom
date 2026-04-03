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

# ── Escape Room navigation commands ─────────────────────────────────────────

# Move to the next room. In the VS Code extension rooms are not encrypted,
# so the password is only used to verify and navigate; no decryption needed.
# Usage: next [password]
next() {
    local cur="$PWD"
    local num
    num=$(echo "$cur" | grep -oE 'room_[0-9]+' | tail -1 | sed 's/room_0*//')
    if [ -z "$num" ]; then
        echo -e "\033[0;31mCannot detect current room. Navigate to a room folder first.\033[0m"
        return 1
    fi
    local next_num
    next_num=$(printf "%02d" $((num + 1)))
    local next_dir="${ESCAPE_ROOMS:-$(dirname "$PWD")}/room_${next_num}"
    if [ ! -d "$next_dir" ]; then
        echo -e "\033[0;31mNo room_${next_num} found. You may have reached the end!\033[0m"
        return 1
    fi
    cd "$next_dir"
    echo -e "\033[0;32m>> Moved to Room ${next_num}\033[0m"
    # Save progress
    local save_file="${HOME}/.escape_progress"
    echo "LAST_ROOM=${next_num}" > "$save_file"
    [ -n "${1:-}" ] && echo "LAST_PASSWORD=$1" >> "$save_file"
    echo "SAVED_AT=$(date '+%Y-%m-%d %H:%M:%S')" >> "$save_file"
    echo -e "\033[0;35m[Progress saved — run 'progress' to view]\033[0m"
    # Notify VS Code sidebar via state file
    echo "$((10#${next_num}))" > "${HOME}/.escape_room_state" 2>/dev/null || true
}

# Jump directly to any room by number.
# Usage: room <number>
room() {
    local target_num
    target_num=$(printf "%02d" "${1:-0}" 2>/dev/null) || {
        echo -e "\033[0;31mUsage: room <number>\033[0m"; return 1
    }
    local target_dir="${ESCAPE_ROOMS:-$(dirname "$PWD")}/room_${target_num}"
    if [ ! -d "$target_dir" ]; then
        echo -e "\033[0;31mNo room_${target_num} found.\033[0m"
        return 1
    fi
    cd "$target_dir"
    echo -e "\033[0;32m>> Moved to Room ${target_num}\033[0m"
    # Notify VS Code sidebar via state file
    echo "$((10#${target_num}))" > "${HOME}/.escape_room_state" 2>/dev/null || true
}

# Show saved progress.
progress() {
    local save_file="${HOME}/.escape_progress"
    if [ ! -f "$save_file" ]; then
        echo -e "\033[0;33mNo progress saved yet. Complete a room with: next\033[0m"
        return 0
    fi
    source "$save_file"
    echo -e "\033[0;36m╔══════════════════════════════════╗\033[0m"
    echo -e "\033[0;36m║       Escape Room Progress       ║\033[0m"
    echo -e "\033[0;36m╚══════════════════════════════════╝\033[0m"
    echo -e "  Last room : \033[0;32mRoom ${LAST_ROOM}\033[0m"
    echo -e "  Saved at  : ${SAVED_AT}"
    echo -e "\n  Run \033[0;32mresume\033[0m to jump back to room ${LAST_ROOM}"
}

# Resume from last saved room.
resume() {
    local save_file="${HOME}/.escape_progress"
    if [ ! -f "$save_file" ]; then
        echo -e "\033[0;31mNo saved progress found. Start from room 01!\033[0m"
        return 1
    fi
    source "$save_file"
    echo -e "\033[0;32mResuming from Room ${LAST_ROOM}...\033[0m"
    room "$((10#${LAST_ROOM}))"
}
