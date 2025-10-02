#!/bin/bash

# Alpine-compatible initialization script for Bash Escape Room
# This version handles differences between Alpine and Ubuntu/Debian

# verify we are root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Set the base folder for the escape room
BASE_FOLDER=/home/escape/escapeRooms

# Set up permissions for all rooms
chmod -R agou+rw $BASE_FOLDER/room_*

# The root password is 'escape' (also for sudo).
# Attempt to automatically re-run this script as root using sudo and the
# known password. This is intentionally convenient for the escape-room
# setup but is insecure for general use. You can override the password by
# exporting ESCAPE_PWD in the environment before running the script.

# Function to encrypt file with vim (Alpine-compatible way)
# Uses vim directly instead of vi -es which doesn't work with busybox
encrypt_file() {
    local file=$1
    local key=$2
    
    # Use full vim with proper flags
    vim -n -u NONE -i NONE \
        -c "set key=$key" \
        -c "set cm=blowfish2" \
        -c "wq!" \
        "$file" 2>/dev/null
}

# Function to decrypt a file that was encrypted with vim's blowfish2
# It opens the file with the provided key, clears the cryptmethod and
# writes the file back unencrypted.
decrypt_file() {
    local file=$1
    local key=$2

    # Use full vim with proper flags to decrypt: set the key so vim can
    # load/decrypt the buffer, then clear the cryptmethod and save.
    vim -n -u NONE -i NONE \
        -c "set key=$key" \
        -c "set cm=" \
        -c "wq!" \
        "$file" 2>/dev/null
}

# Encrypt README files for each room
encrypt_file "$BASE_FOLDER/room_02/README" "welldone"
encrypt_file "$BASE_FOLDER/room_03/README" "472"
encrypt_file "$BASE_FOLDER/room_04/README" "linuxisfun"
encrypt_file "$BASE_FOLDER/room_05/README" "crazyroom"
encrypt_file "$BASE_FOLDER/room_06/README" "linuxrocks"
encrypt_file "$BASE_FOLDER/room_07/README" "LinusTorvalds"
encrypt_file "$BASE_FOLDER/room_08/README" "linuxkernel"
encrypt_file "$BASE_FOLDER/room_09/README" "lessismore"
encrypt_file "$BASE_FOLDER/room_10/README" "linuxisfree"
encrypt_file "$BASE_FOLDER/room_11/README" "bashisfun"
encrypt_file "$BASE_FOLDER/room_12/README" "awk_is_powerful"

## -------------------------------------------------------------------
# Room 01
## -------------------------------------------------------------------
# Generate random files
cd $BASE_FOLDER/room_01

for i in {1..2500}
do
   # Generate a random number 
   length=$(( RANDOM % 1000 + 10 ))

   # Generate a random string of the determined length
   random_string=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w $length | head -n 1)

   # Generate a random file name
   file_name=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)

   # Write the random string to a .txt file
   echo "$random_string" > "room_files/$file_name.txt"
done

## -------------------------------------------------------------------
# Room 02
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_02
# Try to set specific UID (may fail on Alpine, that's ok)
deluser white_rabbit 
adduser -D -u 521 -s /bin/false white_rabbit 

## -------------------------------------------------------------------
# Room 03
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_03
# Lock the script with password
mv      ./script.sh ./creature.sh
chmod   -R agou-x   ./creature.sh
encrypt_file "$BASE_FOLDER/room_03/creature.sh" "83"
encrypt_file "$BASE_FOLDER/room_03/treasureChest" "1195723"

## -------------------------------------------------------------------
# Room 04
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_04
# Set up permissions for specific files
chmod -R agou+rw $BASE_FOLDER/room_04/crazyText
encrypt_file "$BASE_FOLDER/room_04/key" "linuxisstillfun"

## -------------------------------------------------------------------
# Room 05
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_05

# Obfuscate the file
javascript-obfuscator ./lockedDoor.js --output ./lockedDoor.js
# Remove the extension 
mv ./lockedDoor.js ./lockedDoor

# Add metadata
setfattr ./lockedDoor -n user.scriptLanguage -v "This is a NodeJs script"                        
setfattr ./lockedDoor -n user.showKey        -v "Just ask me to: showKey and ill show you the key" 

encrypt_file "./hints.txt" "hints"

## -------------------------------------------------------------------
## Room 06
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_06

# Obfuscate the script
javascript-obfuscator ./script.js --output ./script.js

## -------------------------------------------------------------------
## Room 07
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_07

# Zip the content with the given password
zip --password 374 room_07.zip puzzle/*

# Delete original files
rm -rf puzzle

## -------------------------------------------------------------------
## Room 08
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_08

# Obfuscate the bash script
shc -r -o getKey.sh -f ./script.sh 
chmod +x ./getKey.sh
rm ./script*

## -------------------------------------------------------------------
## Room 09
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_09

# Obfuscate the bash script
shc -r -o getKey.sh -f ./script.sh 
chmod +x ./getKey.sh
rm ./script*
rm ./escape

## -------------------------------------------------------------------
## Room 11
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_11
encrypt_file "$BASE_FOLDER/room_11/message.txt" "58"

## -------------------------------------------------------------------
## Room 12
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_12


## -------------------------------------------------------------------
## Room 100
## -------------------------------------------------------------------
cd $BASE_FOLDER/room_100

# Obfuscate the bash script
shc -r -o getKey.sh -f ./script.sh 
chmod +x ./getKey.sh
rm ./script*

cd $BASE_FOLDER

echo "Escape room initialization complete!"
