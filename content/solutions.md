# Bash Escape Room Solutions

- Open the next room instructions by running the following command:
  
  ```bash
  # Set the room number and password here
  PASSWORD=xxx
  ROOM_NUM=xxx
  FILENAME=README.md

  # Navigate to the room directory, set the password in the README file, and display its content
  cd ~/escapeRooms/room_$ROOM_NUM && \
  echo $PASSWORD                  | \
  echo $FILENAME                   | \
  
  vim -e "$FILENAME" << EOF
  set key=$PASSWORD
  set key=
  wq!
  EOF
  cat $FILENAME
  ```




<details>
<summary>Room 01 - Click to reveal the solution</summary>

---

- Navigate to the `room_files` directory
- Delete all `.txt` files
- Sort the remaining files by size
- Extract the first letter of each filename in lowercase.
  ```bash
  # Navigate to the directory
  cd ~/escapeRooms/room_01

  # Switch to the files directory
  cd room_files

  # Delete all the text files
  rm -rf *.txt

  # List all files (including hidden ones), sorted by size (descending), and show only the names:
  ls -laS
  ```
- Now read the first letter of each file in lowercase.
- Here is an advanced command that does this in one line:
  ```bash
    cd ~/escapeRooms/room_01/room_files &&  \
    rm -rf *.txt &&                         \
    ls -laS                               | \
    awk '{print $9}'                      | \
    grep -v '^$'                          | \
    grep -v '^\.{1,2}$'                   | \
    sed 's/^[^a-zA-Z]*//'                 | \
    cut -c1                               | \
    tr -d '\n'                            | \
    tr 'A-Z' 'a-z';                         \
    echo
  ```

</details>

<details>
<summary>Room 02 - Click to reveal the solution</summary>

---

**Challenge:** Follow the white rabbit!

1. Find the White Rabbit's user ID from `/etc/passwd`:
   ```bash
   cat /etc/passwd | grep white_rabbit
   
   # Output: 
   white_rabbit:x:521:1001::/home/white_rabbit:/bin/false
   ```

    > The White Rabbit's user ID is **521**.

2. Search for a user in `users_list.csv` whose IP address starts with 521:
   ```bash
   grep ",521\." users_list.csv
   
   # Output: 
   827,jackie,Ekkel,jekkelmy@china.com.cn,Male,521.155.111.106
   ```

    > The matching user is **jekkelmy@china.com.cn**.  
    > The user is **jackie** (first name).

3.  Search for all appearances of "jackie" in the Logs folder:
    ```bash
    grep -r "jackie" Logs/
    ```
    This will find all occurrences of "jackie" in all log files.

4. Get just the content and sort alphabetically:
    ```bash
    # The `-h` flag suppresses filenames, 
    # showing only the matching content.
   
    # The `sort` command arranges the results
    # in alphabetical order.

    grep -rh "jackie" Logs/ | sort

    # Output:
    jackie1: _  _ _____ ____
    jackie2:| || |___  |___ \
    jackie3:| || |_ / /  __) |
    jackie4:|__   _/ /  / __/
    jackie5:   |_|/_/  |_____|
   ```

---

-  One-liner solution:
-  Using `grep`, `cut`, and `sort`:
    ```bash
    cd ~/escapeRooms/room_02                                      && \
    USER_ID=$(grep white_rabbit /etc/passwd | cut -d: -f3)        && \
    USER_NAME=$(grep ",$USER_ID\." users_list.csv | cut -d, -f2)  
    ```

- Using `awk` for a more elegant solution:
  
  ```bash
  cd ~/escapeRooms/room_02                                                          && \
  USER_ID=$(awk -F: '/white_rabbit/{print $3}' /etc/passwd)                         && \
  USER_NAME=$(awk -F, -v id="$USER_ID" '$6 ~ "^"id"\\." {print $2}' users_list.csv) 
  ```

- Finally, search the logs and sort:
  ```bash
  echo "White Rabbit User ID: $USER_ID"                         && \
  echo "Found user: $USER_NAME"                                 && \
  echo "Searching logs for $USER_NAME..."                       && \
  grep -rh "$USER_NAME" Logs/ | sort
  ```  

- One-liner combining everything:
  
  ```bash
  cd ~/escapeRooms/room_02                                      && \
  USER_ID=$(grep white_rabbit /etc/passwd | cut -d: -f3)        && \
  USER_NAME=$(grep ",$USER_ID\." users_list.csv | cut -d, -f2)  && \
  grep -rh "$USER_NAME" Logs/ | sort
  ```

      cd ~/escapeRooms/room_02                                      && \
    USER_ID=$(grep white_rabbit /etc/passwd | cut -d: -f3)        && \
    USER_NAME=$(grep ",$USER_ID\." users_list.csv | cut -d, -f2)  
  ```

- The sorted alphabetical list of all lines containing ***jackie*** from the log files, which when completed correctly will reveal the password for the next room.

</details>

<details>
<summary>Room 03 - Feed the creature</summary>

---

**Challenge:** Feed the creature!

- Solution:
  ```bash
  # Switch to room 03, calculate password, decrypt creature.sh, make executable, and run
  cd ~/escapeRooms/room_03                                       
  PASSWORD=$(( $(grep -w 'do' song | wc -l) + $(grep -v 'home' song | wc -l) + $(grep -c '.' song) )) 
    
  # Edit the creature.sh file to set the password 
  vim -e creature.sh << EOF
  set key=$PASSWORD
  set key=
  wq!
  EOF
  
  # Make the script executable and run it
  sudo chmod +x ./creature.sh
  ./creature.sh

  # Create the food file and vegan group, change group ownership, and run the script again
  touch food
  sudo groupadd vegan
  sudo chgrp vegan food
  ./creature.sh

  # Grab the key from the output
  # Use the key to open the treasureChest file
  vim treasureChest

  # Use the password to open the next rooms
  ```

- One-liner solution:
```bash
cd ~/escapeRooms/room_03                                                                            && \
PASSWORD=$(( $(grep -w 'do' song | wc -l) + $(grep -v 'home' song | wc -l) + $(grep -c '.' song) )) && \
echo "Calculated password: $PASSWORD"                                                               && \
vim --cmd "set key=$PASSWORD" -e "creature.sh" << EOF
set key=
wq!
EOF
```
```
cat creature.sh                                                                                     && \
sudo chmod +x ./creature.sh                                                                         && \
touch food                                                                                          && \
sudo groupadd vegan 2>/dev/null                                                                     && \
sudo chgrp vegan food                                                                               && \
./creature.sh                                                                                       && \
echo "Treasure chest key should be revealed above. Use it to open treasureChest with vim."
```

 </details>

<details>
<summary>Room 04 - Decode the crazy text</summary>

---

**Challenge:** Decode the crazy guy's text!

1. The crazy guy replaced letters with words:
   - `H` → `zing`
   - `h` → `blu`
   - `i` → `bla`

2. Decode the `crazyText` file using `sed`:
   ```bash
   cd ~/escapeRooms/room_04
   
   # Decode the text by replacing the substitutions
   sed 's/zing/H/g; s/blu/h/g; s/bla/i/g' crazyText
   
   # Print the decoded text to find the password
   ```
3. The password for the `key` will appear in the decoded text.

4. Use the password to decrypt the `key` file:
   ```bash
   # Open the key file with vim and enter the password
   vim key
   
   # Inside vim, disable encryption and save
   :set key=
   :wq
   ```

5. The decrypted `key` file contains the password for the next room.

---

- One-liner solution:
  ```bash
  cd ~/escapeRooms/room_04                                            &&  \
  PASSWORD=$(sed 's/zing/H/g; s/blu/h/g; s/bla/i/g' crazyText         |   \
  grep "password for the key" | sed 's/.*password for the key is //') &&  \
  echo "Password for key file: $PASSWORD"                             && \
  echo $PASSWORD | vim -c "set key=" -c "wq" key                      && \
  cat key
  ```

</details>

<details>
<summary>Room 05 - Get past the locked door</summary>

---

**Challenge:** Get past the locked door by extracting the key from the JavaScript script.

1. Determine the script language:
   ```bash
   cd ~/escapeRooms/room_05
   file lockedDoor
   # Output: lockedDoor: a /usr/bin/env node script, ASCII text executable
   ```

2. Check extended attributes for clues:
   ```bash
   getfattr -d lockedDoor
   # This should show an attribute with instructions, e.g., "run with showKey"
   ```

3. Install Node.js if needed:
   ```bash
   # Check if installed
   node --version
   # If not, install
   sudo apk add nodejs
   ```

4. Run the script with the correct parameter:
   ```bash
   node lockedDoor showKey
   # Output:
   # The key for the next room is
   # linuxrocks
   ```

5. The password for the next room is `********` 😊.

---

- One-liner solution:
  ```bash
  cd ~/escapeRooms/room_05                    && \
  sudo apk add attr file nodejs 2>/dev/null   && \
  file lockedDoor                             && \
  getfattr -d lockedDoor                      && \
  node lockedDoor showKey
  ```

</details>
