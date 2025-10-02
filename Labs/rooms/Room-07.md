---
password: "LinusTorvalds"
title_prefix: "🤪 "
summary: "Room 07 requires playing the 7 boom game, decrypting a file, and finding the text wrapping command."
---

**PLAY 7 BOOM, DECRYPT A FILE, AND FIND THE TEXT WRAPPING COMMAND!**

---

# 🤪 Room 07

!!! danger "sudo Access"
    - You might need `sudo` access for some commands.
    - The sudo password is required for elevated privileges.
    - The sudo password is: `escape`.
    - Write it down, you will need it later.

---

## Objective: Play 7 boom game, decrypt a file, and find the text wrapping command

```markdown
To pass this room:
---------------------------------------------------------------------

- In room #7 we shell play the `7 boom` game.
- The original 7 boom game is played in the range of 1-100.
- We will change the rules and calculate the 7 boom numbers between 1 to 1000 
- The rules are very simple:
  - If a number is divided by 7 (without leftover), or has the digit 7 in it (for example: 7,778 etc)
    the number is counted as `boom` number  

Tasks: 
------

1. Since we want to learn bash scripting write a `bash script` which prints out how many boom numbers are between 1 to 1000. 
  You can still do it manually if you wish :-)
2. With the password that you got unzip the `room7.zip` file
3. Once you unzipped the content find a bash function which print out the contents of the .txt file 
   with lines wrapped after `80` characters, **without** splitting any words!!!. 
4. The password will popup in the file.

Good Luck !!!
```

  1. Write a bash script to count boom numbers between 1 and 1000.
   
    !!! tip "7 Boom Rules"
    
        - A number is a `boom` if it's divisible by 7 or contains the digit 7.
        - Count such numbers from `1` to `1000`.
        - The count is xxx.
    
  2. Use the count (xxx) as the key to decrypt the file.
            
  3. Find the command to wrap text after 80 characters without splitting words.
               
    !!! tip "Text Wrapping"
    
        - Use the `fold` command with appropriate options (flags).
        - This will reveal the password in the file.

  4. Use the revealed password to proceed to the next room.
     
---

## **Useful Commands:**

| Command | Man Page                                                        | Description                                     |
| ------- | --------------------------------------------------------------- | ----------------------------------------------- |
| `bash`  | 🔗 [`bash`](https://man7.org/linux/man-pages/man1/bash.1.html)   | GNU Bourne-Again SHell                          |
| `vim`   | 🔗 [`vim`](https://manpages.org/vim)                             | Text editor                                     |
| `fold`  | 🔗 [`fold`](https://man7.org/linux/man-pages/man1/fold.1.html)   | Wrap each input line to fit in specified width  |
| `sleep` | 🔗 [`sleep`](https://man7.org/linux/man-pages/man1/sleep.1.html) | Delay for a specified amount of time            |
| `wait`  | 🔗 [`wait`](https://man7.org/linux/man-pages/man1/wait.1.html)   | Wait for job completion                         |
| `while` | 🔗 [`bash`](https://man7.org/linux/man-pages/man1/bash.1.html)   | Execute commands in a loop (for infinite loops) |


**GOOD LUCK!**
