---
password: "linuxisfree"
title_prefix: "🔢 "
summary: "Room 10 involves bash loops and arrays to process treasure items and find the password."
---

**LOOPING THROUGH ARRAYS**

---

# 🔢 Room 10

!!! danger "sudo Access"
    - You might need `sudo` access for some commands.
    - The sudo password is required for elevated privileges.
    - The sudo password is: `escape`.
    - Write it down, you will need it later.

---

## Objective: Write a bash script using loops and arrays to process treasure items and find the password.

```markdown

T- Congratulations! You have reached room 10!!

To pass this room:
---------------------------------------------------------------------

- In this room, we focus on bash loops and arrays.
- You need to write a bash script that processes a list of palindrome items.

Palindrome: 
      a word, phrase, or sequence that reads the same backward as forward   
      (e.g., mom, madam, racecar, level).

Tasks:
------

1. Examine the 'treasure_list.txt' file in this folder.
2. Write a bash script named 'find_treasure.sh' that:
   - Reads all the lines (items) into an array.
   - Filters out (remove) items that are not palindromes.
   - Takes the first letter of each item in the **exact order** its in the array.
   - Outputs the concatenated letters as the password (lowercase).

3. Recommended steps to complete the task:
   - Use a loop to read lines from 'treasure_list.txt' into an array.
     - Hint: You can read a file line by line using (IFS= read -r line)
   - Use a function to check if a word is a palindrome.
     - Hint: You can reverse a string using 'rev' command.
   - Filter the array and build the password.
   - Print the final password.
4. Run your script to get the password for the next room.

Good Luck!!!
```

---

## Steps to Solve:

1. **Examine the data file**
   
    !!! warning ""
        Use `cat treasure_list.txt` to view the items.

2. **Write the script**
   
    !!! warning ""
        - Read lines one by one using `while IFS= read -r item`
        - Check if each item is a palindrome using `rev` command
        - For palindromes, extract the first letter: `${item:0:1}`
        - Concatenate letters to build the password
        - Output the password in lowercase

3. **Example script structure**

    !!! example ""
        ```bash
        #!/bin/bash
        password=""
        while IFS= read -r item; do
            # Check if palindrome using rev
            [[ "$item" == "$(echo "$item" | rev)" ]] && password+="${item:0:1}"
        done < treasure_list.txt
        echo "$password"
        ```

4. **Run and get password**
   
    !!! success ""
        - Execute `./find_treasure.sh`
        - The output is the password for the next room.

## **Useful Commands:**

| Command   | Man Page                                                                                         | Description           |
| --------- | ------------------------------------------------------------------------------------------------ | --------------------- |
| `for`     | 🔗 [Bash Loops](https://www.gnu.org/software/bash/manual/bash.html#Looping-Constructs)            | Loop over items       |
| `if`      | 🔗 [Bash Conditionals](https://www.gnu.org/software/bash/manual/bash.html#Conditional-Constructs) | Conditional execution |
| `mapfile` | 🔗 [mapfile](https://man7.org/linux/man-pages/man1/mapfile.1p.html)                               | Read lines into array |
| `sort`    | 🔗 [sort](https://man7.org/linux/man-pages/man1/sort.1.html)                                      | Sort lines            |

**GOOD LUCK!**
