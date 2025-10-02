---
password: "bashisfun"
title_prefix: "🔢 "
summary: "Room 11 involves bash conditionals and awk to process user data and find the password."
---

**AWK SCRIPTING - Filtering User Data**

!!! danger "sudo Access"
    - You might need `sudo` access for some commands.
    - The sudo password is required for elevated privileges.
    - The sudo password is: `escape`.
    - Write it down, you will need it later.

---

## Objective: Write a bash script using conditionals to filter user data and find the password.

```markdown

To pass this room:
---------------------------------------------------------------------

- In this room, we dive into bash conditionals and decision-making.
- You need to write a bash script that processes user data and filters based on conditions.
- In this room we wish to learn and use `awk` and learn some of its capabilities. 
- awk is most commonly used for `pattern matching` or `text processing`
  
Tasks
------

1. Examine the 'user_data.txt' file in this folder.
2. Write a bash script named 'filter_users.sh' that:
   - The file contains a header and each line contains user information in the format: 
         name,age,subscription
   - Reads each line from 'user_data.txt' 
   - Using `bash` and `awk`, filter users based on the following criteria:
     - Skip the header line (First line - Find out how to do this using `awk`)
     - Age greater than 25  (Hint: This is the second field in each line)
     - Subscription type is 'premium' (Hint: This is the third field in each line)
   - Sums the ages of the matching users, and this sum will be the password for the next room.

3. Run your script to get the password for the next room.

Good Luck!!!

```

---

## Steps to Solve

1. **Examine the data file**
   
    !!! warning ""
        Use `cat user_data.txt` to view the CSV structure: name,age,subscription.

2. **Write the script**
   
    !!! warning ""
        - Use `awk` to process the CSV file
        - Set field separator to comma with `-F','`
        - Skip header with `NR > 1`
        - Filter `age > 25` and `subscription == "premium"`
        - Sum the ages with `sum += $2`
        - Print sum in END block

3. **Example script structure**

    !!! example ""
        ```bash
        #!/bin/bash
        awk -F',' 'NR > 1 && $2 > 25 && $3 == "premium" {sum += $2} END {print sum}' user_data.txt
        ```

4. **Run and get password**
   
    !!! warning ""
        - Execute `./filter_users.sh`
        - The output is the password to open the message file and find the password for the next room.

## **Useful Commands:**

| Command | Man Page                                                  | Description                     |
| ------- | --------------------------------------------------------- | ------------------------------- |
| `awk`   | 🔗 [awk](https://man7.org/linux/man-pages/man1/awk.1.html) | Pattern scanning and processing |
| `-F`    |                                                           | Field separator in awk          |
| `NR`    |                                                           | Number of input records (lines) |
| `END`   |                                                           | Block executed after all input  |
| `$x`    |                                                           | X field in awk                  |

**GOOD LUCK!**

