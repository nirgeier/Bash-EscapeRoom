#!/bin/bash

# Alpine-compatible initialization script for Bash Escape Room
# Uses OpenSSL AES-256-CBC encryption

# verify we are root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Set the base folder for the escape room
BASE_FOLDER=/home/escape/escapeRooms

# Set up permissions for all rooms
chmod -R agou+rw $BASE_FOLDER/room_*

# Function to encrypt file with OpenSSL AES-256-CBC
encrypt_file() {
    local file=$1
    local key=$2
    openssl enc -aes-256-cbc -a -salt -pbkdf2 \
        -in "$file" -out "${file}.enc" \
        -pass pass:"$key" 2>/dev/null
    mv "${file}.enc" "$file"
}

## -------------------------------------------------------------------
# Encrypt README files for each room with OpenSSL
## -------------------------------------------------------------------
encrypt_file "$BASE_FOLDER/room_02/README" "northstar"
encrypt_file "$BASE_FOLDER/room_03/README" "signal59"
encrypt_file "$BASE_FOLDER/room_04/README" "rewind99"
encrypt_file "$BASE_FOLDER/room_05/README" "sedmaster"
encrypt_file "$BASE_FOLDER/room_06/README" "translate"
encrypt_file "$BASE_FOLDER/room_07/README" "unique37"
encrypt_file "$BASE_FOLDER/room_08/README" "access42"
encrypt_file "$BASE_FOLDER/room_09/README" "export99"
encrypt_file "$BASE_FOLDER/room_10/README" "daemon77"
encrypt_file "$BASE_FOLDER/room_11/README" "awk2025"
encrypt_file "$BASE_FOLDER/room_12/README" "layered7"
encrypt_file "$BASE_FOLDER/room_13/README" "pipeline"
encrypt_file "$BASE_FOLDER/room_14/README" "link42"
encrypt_file "$BASE_FOLDER/room_15/README" "webfetch"
encrypt_file "$BASE_FOLDER/room_16/README" "json64"
encrypt_file "$BASE_FOLDER/room_17/README" "modulereactor"
encrypt_file "$BASE_FOLDER/room_18/README" "cron5min"
encrypt_file "$BASE_FOLDER/room_19/README" "patch13"
encrypt_file "$BASE_FOLDER/room_20/README" "hash256"
encrypt_file "$BASE_FOLDER/room_21/README" "deadbeef"
encrypt_file "$BASE_FOLDER/room_22/README" "hidden42"
encrypt_file "$BASE_FOLDER/room_23/README" "calc1337"
encrypt_file "$BASE_FOLDER/room_24/README" "epoch6026"
encrypt_file "$BASE_FOLDER/room_25/README" "format77"
encrypt_file "$BASE_FOLDER/room_26/README" "teeoff"
encrypt_file "$BASE_FOLDER/room_27/README" "expand99"
encrypt_file "$BASE_FOLDER/room_28/README" "array10"
encrypt_file "$BASE_FOLDER/room_29/README" "loop50"
encrypt_file "$BASE_FOLDER/room_30/README" "while100"
encrypt_file "$BASE_FOLDER/room_31/README" "branch3"
encrypt_file "$BASE_FOLDER/room_32/README" "matched7"
encrypt_file "$BASE_FOLDER/room_33/README" "funcret"
encrypt_file "$BASE_FOLDER/room_34/README" "optparse"
encrypt_file "$BASE_FOLDER/room_35/README" "heredoc5"
encrypt_file "$BASE_FOLDER/room_36/README" "nested42"
encrypt_file "$BASE_FOLDER/room_37/README" "sigcatch"
encrypt_file "$BASE_FOLDER/room_38/README" "readline"
encrypt_file "$BASE_FOLDER/room_39/README" "timeout3"
encrypt_file "$BASE_FOLDER/room_40/README" "port80"
encrypt_file "$BASE_FOLDER/room_41/README" "resolve9"
encrypt_file "$BASE_FOLDER/room_42/README" "ncat7"
encrypt_file "$BASE_FOLDER/room_43/README" "openfd"
encrypt_file "$BASE_FOLDER/room_44/README" "syscall"
encrypt_file "$BASE_FOLDER/room_45/README" "synced"
encrypt_file "$BASE_FOLDER/room_46/README" "cipher99"
encrypt_file "$BASE_FOLDER/room_47/README" "vimmode"
encrypt_file "$BASE_FOLDER/room_48/README" "sshkey"
encrypt_file "$BASE_FOLDER/room_49/README" "commit42"
encrypt_file "$BASE_FOLDER/room_50/README" "pipeline9"
encrypt_file "$BASE_FOLDER/room_99/README" "masterkey"
encrypt_file "$BASE_FOLDER/room_51/README" "masterkey"
encrypt_file "$BASE_FOLDER/room_52/README" "chownit"
encrypt_file "$BASE_FOLDER/room_53/README" "netprobe"
encrypt_file "$BASE_FOLDER/room_54/README" "monitor5"
encrypt_file "$BASE_FOLDER/room_55/README" "sysinfo9"
encrypt_file "$BASE_FOLDER/room_56/README" "procctrl"

## -------------------------------------------------------------------
# Room 01 - The Lost Expedition (find, cat, sort)
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_01

# Generate 500+ decoy noise files scattered across expedition/ subdirs
SUBDIRS=$(find expedition/ -type d)
for i in $(seq 1 500); do
    target_dir=$(echo "$SUBDIRS" | shuf -n 1)
    fname=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
    ext=$(echo ".rock .leaf .twig" | tr ' ' '\n' | shuf -n 1)
    echo "noise data $i" > "$target_dir/${fname}${ext}"
done

## -------------------------------------------------------------------
# Room 07 - The Permission Maze (chmod, stat)
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_07

# Set WRONG permissions on gate files (students must fix them)
chmod 000 gate_1  # needs 755
chmod 777 gate_2  # needs 644
chmod 644 gate_3  # needs 700
chmod 755 gate_4  # needs 444
chmod 000 gate_5  # needs 775
chmod 777 gate_6  # needs 660
chmod 644 gate_7  # needs 511

# Obfuscate the validation script
if command -v shc &>/dev/null; then
    shc -r -o getKey.sh -f ./script.sh
    chmod +x ./getKey.sh
    rm -f ./script.sh ./script.sh.x.c
else
    mv ./script.sh ./getKey.sh
    chmod +x ./getKey.sh
fi

## -------------------------------------------------------------------
# Room 08 - The Environment Lab (export, env, source, alias)
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_08

# Obfuscate the validation script
if command -v shc &>/dev/null; then
    shc -r -o getKey.sh -f ./script.sh
    chmod +x ./getKey.sh
    rm -f ./script.sh ./script.sh.x.c
else
    mv ./script.sh ./getKey.sh
    chmod +x ./getKey.sh
fi

## -------------------------------------------------------------------
# Room 09 - The Ghost Process (ps, kill, bg)
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_09

# Obfuscate the validation script
if command -v shc &>/dev/null; then
    shc -r -o getKey.sh -f ./script.sh
    chmod +x ./getKey.sh
    rm -f ./script.sh ./script.sh.x.c
else
    mv ./script.sh ./getKey.sh
    chmod +x ./getKey.sh
fi

## -------------------------------------------------------------------
# Room 11 - The Nested Archive (tar, gzip, base64)
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_11

# Create the nested archive: secret_scroll.txt -> tar -> gzip -> base64
tar cf secret.tar secret_scroll.txt
gzip secret.tar
base64 secret.tar.gz > artifact.b64

# Remove the source files (students must unwrap the archive)
rm -f secret_scroll.txt secret.tar.gz

## -------------------------------------------------------------------
# Room 13 - Symbolic Links (ln, readlink)
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_13
bash setup.sh
rm -f setup.sh

## -------------------------------------------------------------------
# Room 14 - curl (backup_password.txt is static)
## -------------------------------------------------------------------
# No dynamic setup needed

## -------------------------------------------------------------------
# Room 15 - jq (database.json is static)
## -------------------------------------------------------------------
# No dynamic setup needed

## -------------------------------------------------------------------
# Room 16 - df/du
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_16
bash setup.sh
rm -f setup.sh

## -------------------------------------------------------------------
# Room 17 - crontab (schedule.cron is static)
## -------------------------------------------------------------------
# No dynamic setup needed

## -------------------------------------------------------------------
# Room 18 - diff/patch (blueprint files are static)
## -------------------------------------------------------------------
# No dynamic setup needed

## -------------------------------------------------------------------
# Room 19 - sha256sum
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_19
bash setup.sh
rm -f setup.sh

## -------------------------------------------------------------------
# Room 20 - xxd
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_20
bash setup.sh
rm -f setup.sh

## -------------------------------------------------------------------
# Room 21 - strings
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_21
bash setup.sh
rm -f setup.sh

## -------------------------------------------------------------------
# Room 22 - bc (equations.txt is static)
## -------------------------------------------------------------------
# No dynamic setup needed

## -------------------------------------------------------------------
# Room 23 - date (timestamps.txt is static)
## -------------------------------------------------------------------
# No dynamic setup needed

## -------------------------------------------------------------------
# Room 24 - printf (template.txt is static)
## -------------------------------------------------------------------
# No dynamic setup needed

## -------------------------------------------------------------------
# Room 25 - tee
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_25
chmod +x generate_signal.sh

## -------------------------------------------------------------------
# Room 26 - parameter expansion (vault_env.sh is static)
## -------------------------------------------------------------------
# No dynamic setup needed

## -------------------------------------------------------------------
# Room 27 - bash arrays (weapons.txt is static)
## -------------------------------------------------------------------
# No dynamic setup needed

## -------------------------------------------------------------------
# Room 28 - for loops
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_28
bash setup.sh
rm -f setup.sh

## -------------------------------------------------------------------
# Room 29 - while loops
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_29
bash setup.sh
rm -f setup.sh

## -------------------------------------------------------------------
# Room 30 - if/else
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_30
chmod +x decision_tree.sh

## -------------------------------------------------------------------
# Room 31 - case (symbols.txt is static)
## -------------------------------------------------------------------
# No dynamic setup needed

## -------------------------------------------------------------------
# Room 32 - Bash Functions (getopts)
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_32

# Obfuscate the validation script
if command -v shc &>/dev/null; then
    shc -r -o getKey.sh -f ./script.sh
    chmod +x ./getKey.sh
    rm -f ./script.sh ./script.sh.x.c
else
    mv ./script.sh ./getKey.sh
    chmod +x ./getKey.sh
fi

## -------------------------------------------------------------------
# Room 33 - getopts
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_33
chmod +x locked_program.sh

## -------------------------------------------------------------------
# Room 34 - heredoc
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_34
chmod +x verify_config.sh

## -------------------------------------------------------------------
# Room 35 - process substitution
## -------------------------------------------------------------------
# No setup needed - world_a.txt and world_b.txt are static files

## -------------------------------------------------------------------
# Room 36 - trap/signals
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_36
chmod +x reveal_signal.sh

## -------------------------------------------------------------------
# Room 37 - read
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_37
chmod +x guardian.sh

## -------------------------------------------------------------------
# Room 38 - timeout
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_38
chmod +x countdown.sh
# Remove any stale progress.log
rm -f progress.log

## -------------------------------------------------------------------
# Room 39 - ss/netstat
## -------------------------------------------------------------------
# No setup needed - network_secret.txt is static

## -------------------------------------------------------------------
# Room 40 - dig/host
## -------------------------------------------------------------------
# No setup needed - dns_fallback.txt is static

## -------------------------------------------------------------------
# Room 41 - nc/netcat
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_41
chmod +x start_server.sh

## -------------------------------------------------------------------
# Room 42 - lsof
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_42
chmod +x start_keeper.sh

## -------------------------------------------------------------------
# Room 43 - strace
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_43
chmod +x mystery_program.sh

## -------------------------------------------------------------------
# Room 44 - rsync
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_44
bash setup.sh

# Obfuscate the validation script
if command -v shc &>/dev/null; then
    shc -r -o getKey.sh -f ./script.sh
    chmod +x ./getKey.sh
    rm -f ./script.sh ./script.sh.x.c
else
    mv ./script.sh ./getKey.sh
    chmod +x ./getKey.sh
fi

## -------------------------------------------------------------------
# Room 45 - openssl decrypt
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_45
bash setup.sh
rm -f setup.sh

## -------------------------------------------------------------------
# Room 46 - vim
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_46
bash setup.sh
rm -f setup.sh

## -------------------------------------------------------------------
# Room 47 - ssh
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_47
chmod +x setup_ssh_access.sh

## -------------------------------------------------------------------
# Room 48 - git history
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_48
bash setup.sh
rm -f setup.sh

## -------------------------------------------------------------------
# Room 49 - advanced pipeline
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_49
bash setup.sh
rm -f setup.sh

## -------------------------------------------------------------------
# Room 50 - Final Challenge
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_50
bash setup.sh
rm -f setup.sh

# Obfuscate the validation script
if command -v shc &>/dev/null; then
    shc -r -o getKey.sh -f ./script.sh
    chmod +x ./getKey.sh
    rm -f ./script.sh ./script.sh.x.c
else
    mv ./script.sh ./getKey.sh
    chmod +x ./getKey.sh
fi

## -------------------------------------------------------------------
# Room 51 - xargs
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_51
bash setup.sh
rm -f setup.sh

# Obfuscate the validation script
if command -v shc &>/dev/null; then
    shc -r -o getKey.sh -f ./script.sh
    chmod +x ./getKey.sh
    rm -f ./script.sh ./script.sh.x.c
else
    mv ./script.sh ./getKey.sh
    chmod +x ./getKey.sh
fi

## -------------------------------------------------------------------
# Room 52 - chown/chgrp/umask
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_52
bash setup.sh
rm -f setup.sh

# Obfuscate the validation script
if command -v shc &>/dev/null; then
    shc -r -o getKey.sh -f ./script.sh
    chmod +x ./getKey.sh
    rm -f ./script.sh ./script.sh.x.c
else
    mv ./script.sh ./getKey.sh
    chmod +x ./getKey.sh
fi

## -------------------------------------------------------------------
# Room 53 - ping/traceroute/wget
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_53
chmod +x start_server.sh

## -------------------------------------------------------------------
# Room 54 - top/free/uptime/vmstat
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_54
bash setup.sh
rm -f setup.sh

# Obfuscate the validation script
if command -v shc &>/dev/null; then
    shc -r -o getKey.sh -f ./script.sh
    chmod +x ./getKey.sh
    rm -f ./script.sh ./script.sh.x.c
else
    mv ./script.sh ./getKey.sh
    chmod +x ./getKey.sh
fi

## -------------------------------------------------------------------
# Room 55 - uname/hostname/id/who
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_55

# Obfuscate the validation script
if command -v shc &>/dev/null; then
    shc -r -o getKey.sh -f ./script.sh
    chmod +x ./getKey.sh
    rm -f ./script.sh ./script.sh.x.c
else
    mv ./script.sh ./getKey.sh
    chmod +x ./getKey.sh
fi

## -------------------------------------------------------------------
# Room 56 - pgrep/pkill/nohup/nice
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_56
chmod +x launch_agents.sh

# Obfuscate the validation script
if command -v shc &>/dev/null; then
    shc -r -o getKey.sh -f ./script.sh
    chmod +x ./getKey.sh
    rm -f ./script.sh ./script.sh.x.c
else
    mv ./script.sh ./getKey.sh
    chmod +x ./getKey.sh
fi

## -------------------------------------------------------------------
# Room 99 - Exit Exam
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_99

# Obfuscate the bash script
if command -v shc &>/dev/null; then
    shc -r -o getKey.sh -f ./script.sh
    chmod +x ./getKey.sh
    rm -f ./script.sh ./script.sh.x.c
else
    mv ./script.sh ./getKey.sh
    chmod +x ./getKey.sh
fi

cd $BASE_FOLDER

# Clean up generator script if present
rm -f generate_rooms.py

echo "Escape room initialization complete!"
echo "All README files encrypted with OpenSSL AES-256-CBC"
echo ""
echo "To decrypt a room README:"
echo "  openssl enc -aes-256-cbc -d -a -pbkdf2 -in README -out README.txt -pass pass:PASSWORD"
echo "  mv README.txt README"
