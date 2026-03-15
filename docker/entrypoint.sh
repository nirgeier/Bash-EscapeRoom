#!/bin/bash
# =============================================================================
# Bash Escape Room – Container Entrypoint
#
# 1. Creates the 'escape' user with sudo access
# 2. Copies room content fresh into /home/escape/escapeRooms/
# 3. Runs all room setup: encrypts READMEs, generates noise, sets permissions,
#    wraps archives, and locks validation scripts behind getKey.sh
# 4. Writes helper .bashrc / .bash_profile for the user shell
# 5. Starts the Node.js web-terminal server
# =============================================================================
set -eu

BASE=/home/escape/escapeRooms
CONTENT=/app/rooms          # mounted/copied from content/escapeRoom/

# ── 1. Create user ────────────────────────────────────────────────────────────
adduser  -D -s /bin/bash -h /home/escape escape 2>/dev/null || true
echo "escape:escape" | chpasswd

# Passwordless sudo (needed for room 09: adduser, kill)
echo "escape ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/escape
chmod 0440 /etc/sudoers.d/escape

# ── 2. Copy fresh room content ────────────────────────────────────────────────
rm -rf  "$BASE"
cp -rp  "$CONTENT" "$BASE"
chmod -R a+rwX "$BASE"

# ── 3a. Room 01 – The Lost Expedition: scatter 500 noise files ───────────────
cd "$BASE/room_01"
# Read subdirs into an indexed array (mapfile requires bash 4, use read loop instead)
SUBDIRS=()
while IFS= read -r d; do SUBDIRS+=("$d"); done < <(find expedition/ -type d)
NSUBDIRS=${#SUBDIRS[@]}
for i in $(seq 1 500); do
    target="${SUBDIRS[RANDOM % NSUBDIRS]}"
    # Use dd + od to generate a random 8-char hex name without SIGPIPE
    fname=$(dd if=/dev/urandom bs=4 count=1 2>/dev/null | od -A n -t x1 | tr -dc 'a-f0-9')
    ext_choice=$((RANDOM % 3))
    case $ext_choice in
        0) ext=".rock" ;;
        1) ext=".leaf" ;;
        2) ext=".twig" ;;
    esac
    echo "noise data $i" > "${target}/${fname}${ext}"
done

# ── 3b. Encrypt READMEs for rooms 02–12 and 100 ─────────────────────────────
encrypt_readme() {
    local room=$1 password=$2
    local readme="$BASE/$room/README"
    openssl enc -aes-256-cbc -a -salt -pbkdf2 \
        -in  "$readme" \
        -out "${readme}.enc" \
        -pass pass:"$password" 2>/dev/null
    mv "${readme}.enc" "$readme"
    echo "  [OK] $room encrypted"
}

echo "Encrypting room READMEs..."
encrypt_readme room_02  "northstar"
encrypt_readme room_03  "signal59"
encrypt_readme room_04  "rewind99"
encrypt_readme room_05  "sedmaster"
encrypt_readme room_06  "translate"
encrypt_readme room_07  "unique37"
encrypt_readme room_08  "access42"
encrypt_readme room_09  "export99"
encrypt_readme room_10  "daemon77"
encrypt_readme room_11  "awk2025"
encrypt_readme room_12  "layered7"
encrypt_readme room_99 "pipeline"

# ── 3c. Room 07 – Permission Maze: set deliberately wrong permissions ─────────
cd "$BASE/room_07"
chmod 000 gate_1     # student must set 755
chmod 777 gate_2     # student must set 644
chmod 644 gate_3     # student must set 700
chmod 755 gate_4     # student must set 444
chmod 000 gate_5     # student must set 775
chmod 777 gate_6     # student must set 660
chmod 644 gate_7     # student must set 511
mv  script.sh  getKey.sh
chmod +x getKey.sh

# ── 3d. Room 08 – Environment Lab: hide validation script ────────────────────
cd "$BASE/room_08"
mv  script.sh  getKey.sh
chmod +x getKey.sh

# ── 3e. Room 09 – Ghost Process: hide validation script ──────────────────────
cd "$BASE/room_09"
mv  script.sh  getKey.sh
chmod +x getKey.sh

# ── 3f. Room 11 – Nested Archive: wrap secret_scroll.txt in tar→gzip→base64 ──
cd "$BASE/room_11"
tar   cf  secret.tar      secret_scroll.txt
gzip      secret.tar                            # → secret.tar.gz
base64    secret.tar.gz > artifact.b64
rm -f     secret_scroll.txt  secret.tar.gz

# ── 3g. Room 99 – Exit Exam: hide validation script ─────────────────────────
cd "$BASE/room_99"
mv  script.sh  getKey.sh
chmod +x getKey.sh

# ── 4. Fix final ownership ────────────────────────────────────────────────────
chown -R escape:escape /home/escape

# ── 5. Write .bashrc ─────────────────────────────────────────────────────────
cat > /home/escape/.bashrc << 'BASHRC'
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

# Show welcome + room 01 instructions on first interactive login
if [ -z "${ESCAPE_ROOM_WELCOMED:-}" ]; then
    export ESCAPE_ROOM_WELCOMED=1
    bash /home/escape/escapeRooms/welcome.sh
fi
BASHRC

# .bash_profile sources .bashrc so login shells (su -) work correctly
cat > /home/escape/.bash_profile << 'PROFILE'
[ -f ~/.bashrc ] && source ~/.bashrc
cd /home/escape/escapeRooms/room_01
PROFILE

chown escape:escape /home/escape/.bashrc /home/escape/.bash_profile

# ── 6. Start web server ───────────────────────────────────────────────────────
echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║   🐚 Bash Escape Room – Container Ready          ║"
echo "║                                                  ║"
echo "║   All rooms initialized and encrypted.           ║"
echo "║   Open:  http://localhost:3000                   ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""

exec node /app/server.js
