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

<details>
<summary>Room 06 - Filter and manipulate CSV data</summary>

---

**Challenge:** Process the `table.csv fil`e to extract and manipulate data, then run a script to get the key.

1. Navigate to room 06:
   ```bash
   cd ~/escapeRooms/room_06
   ```

2. Extract the `file` column from `table.csv` (skip header):
   ```bash
   tail -n +2 table.csv | cut -d',' -f4
   ```

3. Filter only `.png` files:
   ```bash
   tail -n +2 table.csv | cut -d',' -f4 | grep '\.png$'
   ```

4. Remove `junk` from filenames:
   ```bash
   tail -n +2 table.csv | cut -d',' -f4 | grep '\.png$' | sed 's/junk//'
   ```

5. Sort alphanumerically:
   ```bash
   tail -n +2 table.csv | cut -d',' -f4 | grep '\.png$' | sed 's/junk//' | sort
   ```

6. Remove `.png` extension and numbers:
   ```bash
   tail -n +2 table.csv | cut -d',' -f4 | grep '\.png$' | sed 's/junk//' | sort | sed 's/^[0-9]*//' | sed 's/\.png$//'
   ```

7. Save each word to `message` file, one per line:
   ```bash
   tail -n +2 table.csv | cut -d',' -f4 | grep '\.png$' | sed 's/junk//' | sort | sed 's/^[0-9]*//' | sed 's/\.png$//' > message
   ```

8. Run the Node.js script:
   ```bash
   node script.js
   ```
9. The output will provide the key for the next room.

---

- One-liner solution:
  ```bash
  cd ~/escapeRooms/room_06 &&   \
  tail  -n +2 table.csv         \
        | cut -d',' -f4         \
        | grep '\.png$'         \
        | sed 's/junk//'        \
        | sort                  \
        | sed 's/^[0-9]*//'     \
        | sed 's/\.png$//' > message && \
  node script.js
  ```

</details>

<details>
<summary>Room 07 - 7 Boom game and text wrapping</summary>

---

**Challenge:** Play 7 boom, decrypt a file, and find the text wrapping command.

1. Write a bash script to count boom numbers between 1 and 1000:
   ```bash
   #!/bin/bash
   COUNTER=0
   for i in {1..1000}
   do
       if (( i % 7 == 0 )) || [[ $i == *7* ]]
       then
           let COUNTER++
       fi
   done
   echo "Total number of boom numbers between 1 to 1000 are: [$COUNTER]"
   ```

2. Unzip the `room7.zip` file using the password obtained from the script.
   ```bash
   unzip room7.zip
   ```
      

3. Decrypt the `about_linux.txt` file using the password password `***`:
   
4. Find the command to wrap the text after 80 characters without splitting words:
   ```bash
   fold -s -w 80 about_linux.txt
   ```

   This reveals the password `***` in the output.

---

- One-liner solution:
```bash
cd ~/escapeRooms/room_07              && \
PASSWORD=$(echo 'COUNTER=0; for i in {1..1000}; do if (( i % 7 == 0 )) || [[ $i == *7* ]]; then let COUNTER++; fi; done; echo $COUNTER' | bash)                     && \
echo "Calculated password: $PASSWORD" && \
unzip -P $PASSWORD room_07.zip        && \
vim --cmd "set key=$PASSWORD" -e "about_linux.txt" << EOF
set key=
wq!
EOF
fold -s -w 80 puzzle/about_linux.txt
```

</details>

<details>
<summary>Room 08 - Play with Linux users & processes</summary>

---

**Challenge:** Create a user, run a background process, and find its PID.

1. Navigate to room 08:

   ```bash
   cd ~/escapeRooms/room_08
   ```

2. Create a bash script that runs forever without output:

   ```bash
   # Create room08_proc.sh
   echo 'sleep 1d' > room08_proc.sh
   # Make it executable
   chmod +x room08_proc.sh
   ```

3. Create a new user 'testUser':

   ```bash
   sudo useradd testUser
   ```

4. Execute the script with the user 'testUser' in the background:

   ```bash
   sudo -u testUser ./room08_proc.sh &
   ```

5. Find out the process ID (PID) of the running script:

   ```bash
   ps -u testUser | grep room08_proc
   # The PID is in the first column
   ```

   On BusyBox/Alpine systems where `ps -u` isn't supported:

   ```bash
   ps -o pid,user,comm | grep testUser | grep room08_proc
   ```

6. Pass the PID to the script to get the password:

   ```bash
   ./script.sh <PID>
   # Output: Password for the next room is: lessismore
   ```

---

- solution:

  ```bash
  sudo -i
  cd /home/escape/escapeRooms/room_08/  && \
  echo 'sleep 1d' > room08_proc.sh      && \
  sudo useradd testUser 2>/dev/null     && \
  chmod +x room08_proc.sh               && \
  (sudo -u testUser ./room08_proc.sh &) && \
  sleep 1                               && \
  PID=$(ps -o pid,user,comm,args | grep testUser | grep room08 | awk '{print $1}') && \
  echo "PID: $PID" && \
  ./getKey.sh $PID
  ```

</details>

<details>
<summary>Room 09 - Optimize your bash code</summary>

---

**Challenge:** Implement an efficient sum calculation command using the mathematical formula.

1. Navigate to room 09:
   ```bash
   cd ~/escapeRooms/room_09
   ```

2. Create the `escape` command in `/usr/local/bin/`:

   ```bash
   echo "#!/bin/bash" > /usr/local/bin/escape
   echo "echo \$(( \$1 * (\$1 + 1) / 2 ))" >> /usr/local/bin/escape
   ```

3. Make the script executable:

   ```bash
   sudo chmod +x /usr/local/bin/escape
   ```

4. Test the command manually:

   ```bash
   escape 10   # Should output: 55
   escape 20   # Should output: 210
   escape 100  # Should output: 5050
   ```

5. Run the test script to get the password:

   ```bash
   ./getKey.sh
   ```

---

- One-liner solution:

  ```bash
  sudo -i
  cd /home/escape/escapeRooms/room_09                    && \
  echo "#!/bin/bash" > /usr/local/bin/escape  && \
  echo "echo \$(( \$1 * (\$1 + 1) / 2 ))" >> /usr/local/bin/escape && \
  sudo chmod +x /usr/local/bin/escape         && \
  ./getKey.sh
  ```

</details>

<details>
<summary>Room 10 - Bash loops and arrays with palindromes</summary>

---

**Challenge:** Process a treasure list to find palindromes and extract the password.

1. Navigate to room 10:
   ```bash
   cd ~/escapeRooms/room_10
   ```

2. Examine the `treasure_list.txt` file:
   ```bash
   cat treasure_list.txt
   ```

3. Key concepts:
   - A palindrome reads the same backward as forward (e.g., boob, mom, madam, level)
   - Use the `rev` command to reverse a string for comparison
   - Use array operations to build the password

4. Create a bash script `find_treasure.sh` that:
   - Reads all lines from the file into an array `while IFS= read -r item`
   - Filters out items that are **not** palindromes (keeps only palindromes) `[[ "$item" == "$(echo "$item" | rev)" ]] `
   - Takes the first letter of each palindrome in order `password+="${item:0:1}"`
   - Outputs the concatenated letters in lowercase

5. A short and optimized solution:
   ```bash
   #!/bin/bash
   
   # Set the password variable
   password=""
   
   # Read each line, check if palindrome, extract first letter
   while IFS= read -r item; do
    # Check if the item is a palindrome with rev command
    # Extract the first letter if it is a palindrome and append to password variable 
    [[ "$item" == "$(echo "$item" | rev)" ]] && password+="${item:0:1}"
   done < treasure_list.txt
   
   # Output password in lowercase
   echo "$password"
   ```


---

- One-liner solution:
  ```bash
  cd ~/escapeRooms/room_10 && \
  (password=""; while IFS= read -r item; do \
      [[ "$item" == "$(echo "$item" | rev)" ]] && password+="${item:0:1}"; \
  done < treasure_list.txt; echo "$password")
  ```
</details>

<details>
<summary>Room 11 - Advanced CSV filtering with awk</summary>

---

**Challenge:** Filter users from a CSV file and calculate the sum of their ages using efficient awk commands.

1. Navigate to room 11:
   ```bash
   cd ~/escapeRooms/room_11
   ```

2. Examine the `user_data.txt` CSV file to understand its structure:
   ```bash
   cat user_data.txt
   # Expected format: name,age,subscription_type
   ```

3. Requirements:
   - Filter users with age > 25 **AND** subscription == 'premium'
   - Calculate the sum of their ages
   - Use `awk` for efficient processing

4. Understanding the awk solution:
   - `-F','` : Set field separator to comma (for CSV parsing)
   - `NR > 1` : Skip the first line (header row)
   - `$2 > 25` : Filter where age (field 2) is greater than 25
   - `$3 == "premium"` : Filter where subscription (field 3) equals "premium"
   - `sum += $2` : Add the age to the running sum
   - `END {print sum}` : Print the total sum at the end

5. The optimized solution using awk:
   ```bash
   awk -F',' 'NR > 1 && $2 > 25 && $3 == "premium" {sum += $2} END {print sum}' user_data.txt
   ```

6. This single command efficiently:
   - Parses the CSV file
   - Filters matching users in one pass
   - Calculates the sum without intermediate files or pipes
   - Outputs the result which is the password for the next room

---

- One-liner solution:
  ```bash
  cd ~/escapeRooms/room_11 && \
  awk -F',' 'NR > 1 && $2 > 25 && $3 == "premium" {sum += $2} END {print sum}' user_data.txt

  # use the output as the password for the message file where you will find the password for the next room
  ```
</details>

<details>
<summary>Room 12 - xargs and data processing</summary>

---

**Challenge:** Master xargs for efficient data processing!

1. Navigate to room 12:
   ```bash
   cd ~/escapeRooms/room_12
   ```

2. The room focuses on using `xargs` for efficient command-line data processing. The `output.txt` file contains US state abbreviations (one per line, with duplicates).

3. Key xargs concepts:
   - `xargs` builds and executes command lines from standard input
   - `-n` specifies maximum arguments per command line
   - `-I` replaces strings in commands
   - Useful for processing large datasets efficiently

4. Common xargs patterns:
   ```bash
   # Process items 5 at a time
   cat output.txt | xargs -n5
   
   # Use placeholder for each item
   cat output.txt | xargs -I {} echo "Processing: {}"
   
   # Count unique items
   cat output.txt | sort | uniq -c | sort -nr
   ```

5. For the actual puzzle, create a script that processes numbers (if numbers.txt existed):
   ```bash
   #!/bin/bash
   # process_numbers.sh
   
   # Read numbers into array
   mapfile -t numbers < numbers.txt
   
   sum_even=0
   count_odd=0
   
   # Process each number
   for num in "${numbers[@]}"; do
       if (( num % 2 == 0 )); then
           ((sum_even += num))
       else
           ((count_odd++))
       fi
   done
   
   # Output in required format
   echo "${sum_even}_${count_odd}"
   ```

6. Using xargs for efficient processing:
   ```bash
   # Sum all numbers using xargs and bc
   cat numbers.txt | xargs | sed 's/ /+/g' | bc
   
   # Count even/odd using xargs
   cat numbers.txt | xargs -n1 bash -c 'if (( $1 % 2 == 0 )); then echo even; else echo odd; fi' -- | sort | uniq -c
   ```

7. Advanced xargs usage with the state data:
   ```bash
   # Process states in batches of 5
   cat output.txt | xargs -n5 echo "Batch:"
   
   # Count occurrences using xargs
   cat output.txt | xargs -I {} bash -c 'echo {}' | sort | uniq -c | sort -nr
   ```

---

- One-liner solution demonstrating xargs power:
  ```bash
  cd ~/escapeRooms/room_12 && \
  echo "Demonstrating xargs with state data:" && \
  cat output.txt | xargs -n5 | head -3 && \
  echo -e "\nCounting unique states:" && \
  cat output.txt | sort | uniq -c | sort -nr | head -5
  ```

  This showcases xargs for batch processing and data analysis, which is the core concept of room 12.

</details>
