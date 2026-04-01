#!/bin/bash
# =============================================================================
# Bash Escape Room - Container Entrypoint
#
# 1. Creates the 'escape' user with sudo access
# 2. Copies pre-built room content into /home/escape/escapeRooms/
# 3. Scatters noise files in room_01 (random per container)
# 4. Writes helper .bashrc / .bash_profile for the user shell
# 5. Starts the Node.js web-terminal server
#
# Room setup (encryption, archive, permissions, script renames) is done
# at docker build time in the Dockerfile for faster container startup.
# =============================================================================
set -eu

BASE=/home/escape/escapeRooms
CONTENT=/app/rooms

# ── 1. Create user ────────────────────────────────────────────────────────────
adduser -D -s /bin/bash -h /home/escape escape 2>/dev/null || true
echo "escape:escape" | chpasswd

# Passwordless sudo (needed for room 09: adduser, kill)
echo "escape ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/escape
chmod 0440 /etc/sudoers.d/escape

# ── 2. Copy pre-built room content ───────────────────────────────────────────
rm -rf "$BASE"
cp -rp "$CONTENT" "$BASE"
chmod -R a+rwX "$BASE"

# ── 3. Room 01 - scatter 500 random noise files (fresh per container) ────────
cd "$BASE/room_01"
SUBDIRS=()
while IFS= read -r d; do SUBDIRS+=("$d"); done < <(find expedition/ -type d)
NSUBDIRS=${#SUBDIRS[@]}
for i in $(seq 1 500); do
    target="${SUBDIRS[RANDOM%NSUBDIRS]}"
    fname=$(dd if=/dev/urandom bs=4 count=1 2>/dev/null | od -A n -t x1 | tr -dc 'a-f0-9')
    case $((RANDOM % 3)) in
    0) ext=".rock" ;;
    1) ext=".leaf" ;;
    2) ext=".twig" ;;
    esac
    echo "noise data $i" >"${target}/${fname}${ext}"
done

# ── 4. Fix ownership ──────────────────────────────────────────────────────────
chown -R escape:escape /home/escape

# ── 5. Write .bashrc ─────────────────────────────────────────────────────────
cat >/home/escape/.bashrc <<'BASHRC'
# Load shared utilities (colors, slow_typing, encrypt/decrypt helpers)
[ -f /home/escape/escapeRooms/_utils.sh ] && source /home/escape/escapeRooms/_utils.sh

# Custom prompt: escape:/path$
export PS1='\[\033[01;32m\]escape\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

export HOME=/home/escape
export ESCAPE_ROOMS=/home/escape/escapeRooms

# Shorthand: decrypt a room's README in-place
# Usage: decrypt_room <room_dir> <password>
decrypt_room() {
    local dir="$ESCAPE_ROOMS/$1" pass="$2"
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
        -in  "$dir/README" \
        -out "$dir/README.dec" \
        -pass pass:"$pass" 2>/dev/null \
    && mv "$dir/README.dec" "$dir/README" \
    && echo "Decrypted! Run: cat $dir/README" \
    || echo "Wrong password or file already decrypted."
}

# Navigate to the next room, optionally decrypt its README
# Usage: next [password]
next() {
    local cur="$PWD"
    local num=$(echo "$cur" | grep -oE 'room_[0-9]+' | tail -1 | sed 's/room_0*//')
    if [ -z "$num" ]; then
        echo -e "\033[0;31mCannot detect current room. Navigate to a room folder first.\033[0m"
        return 1
    fi
    local next_num=$(printf "%02d" $((num + 1)))
    local next_dir="$ESCAPE_ROOMS/room_${next_num}"
    if [ ! -d "$next_dir" ]; then
        echo -e "\033[0;31mNo room_${next_num} found. You may have reached the end!\033[0m"
        return 1
    fi
    local decrypted=0
    if [ -n "${1:-}" ]; then
        local readme="$next_dir/README"
        if [ -f "$readme" ]; then
            if ! head -1 "$readme" 2>/dev/null | grep -q '^U2FsdGVk'; then
                echo -e "\033[0;33mRoom is already decrypted.\033[0m"
                decrypted=1
            else
                openssl enc -aes-256-cbc -d -a -pbkdf2 \
                    -in "$readme" \
                    -out "${readme}.dec" \
                    -pass pass:"$1" 2>/dev/null \
                && mv "${readme}.dec" "$readme" \
                && decrypted=1 \
                || { rm -f "${readme}.dec"; echo -e "\033[0;31mWrong password! Room was not decrypted.\033[0m"; return 1; }
            fi
        fi
    fi
    cd "$next_dir"
    echo -e "\033[0;32m>> Moved to Room ${next_num}\033[0m"
    if [ "$decrypted" -eq 1 ]; then
        echo -e "\033]1337;UnlockRoom=${next_num}:${1}\007"
        # Copy password to clipboard via OSC 52
        local b64pass
        b64pass=$(printf '%s' "$1" | base64)
        printf '\033]52;c;%s\007' "$b64pass"
        echo -e "\033[0;36m[Password copied to clipboard]\033[0m"
        clear
    fi
}

# Jump directly to any room by number, optionally decrypt its README
# Usage: room <number> [password]
room() {
    local target_num
    target_num=$(printf "%02d" "${1:-0}" 2>/dev/null) || { echo -e "\033[0;31mUsage: room <number> [password]\033[0m"; return 1; }
    local target_dir="$ESCAPE_ROOMS/room_${target_num}"
    if [ ! -d "$target_dir" ]; then
        echo -e "\033[0;31mNo room_${target_num} found.\033[0m"
        return 1
    fi
    local decrypted=0
    if [ -n "${2:-}" ]; then
        local readme="$target_dir/README"
        if [ -f "$readme" ]; then
            if ! head -1 "$readme" 2>/dev/null | grep -q '^U2FsdGVk'; then
                echo -e "\033[0;33mRoom is already decrypted.\033[0m"
                decrypted=1
            else
                openssl enc -aes-256-cbc -d -a -pbkdf2 \
                    -in "$readme" \
                    -out "${readme}.dec" \
                    -pass pass:"$2" 2>/dev/null \
                && mv "${readme}.dec" "$readme" \
                && decrypted=1 \
                || { rm -f "${readme}.dec"; echo -e "\033[0;31mWrong password! Room was not decrypted.\033[0m"; return 1; }
            fi
        fi
    fi
    cd "$target_dir"
    echo -e "\033[0;32m>> Moved to Room ${target_num}\033[0m"
    if [ "$decrypted" -eq 1 ]; then
        echo -e "\033]1337;UnlockRoom=${target_num}:${2}\007"
        local b64pass
        b64pass=$(printf '%s' "$2" | base64)
        printf '\033]52;c;%s\007' "$b64pass"
        echo -e "\033[0;36m[Password copied to clipboard]\033[0m"
        clear
    fi
}

# Show welcome + room 01 instructions on first interactive login
if [ -z "${ESCAPE_ROOM_WELCOMED:-}" ]; then
    export ESCAPE_ROOM_WELCOMED=1
    bash /home/escape/escapeRooms/welcome.sh
fi
BASHRC

# .bash_profile sources .bashrc so login shells (su -) work correctly
cat >/home/escape/.bash_profile <<'PROFILE'
[ -f ~/.bashrc ] && source ~/.bashrc
cd /home/escape/escapeRooms/room_01
PROFILE

chown escape:escape /home/escape/.bashrc /home/escape/.bash_profile

# ── 6. Start room 14 web server (port 3456) ───────────────────────────────────
su -s /bin/sh escape -c "python3 $BASE/room_14/server.py" &

# ── 7. Start web-terminal server ─────────────────────────────────────────────
exec node /app/server.js
