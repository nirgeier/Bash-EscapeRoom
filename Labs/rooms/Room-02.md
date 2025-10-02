---
password: "welldone"
title_prefix: "🔐 "
summary: "Room 02 requires a password to unlock."
---

**GOOD LUCK FOLLOWING THE WHITE RABBIT!**

---


# 🐇 Room 02

!!! tip "Decryption Tip"
    If the content doesn't appear after entering the password, please refresh the page (F5 or Ctrl+R).


## Objective: Follow the White Rabbit and find the hidden password by analyzing user data and log files

```markdown
To pass this room:
---------------------------------------------------------------------

- Follow the white rabbit!....

1. Find out the White Rabbit's user ID. 
   >> hint: read about users in Linux.
2. Search in `users_list.csv` file for the name of the user that has the IP which starts with this ID!!. 
   >> hint: use find/grep/cat/vim and etc.
3. Search for all the appearances of the **name** you found in Logs folder
4. Sort the results(content only) by alphabetical order
5. If all done correctly you will get the password for the next room
```
---

  1. **Find the White Rabbit's user ID**
   
    !!! tip "Linux Users Hint"
    
        - Learn about users in Linux systems
        - The White Rabbit has a specific user ID that you need to identify
        - Use commands like `whoami`, `id`, or check system files for user information
    
  2. **Search in the `users_list.csv` file**
    
    !!! warning ""
    
        - Look for the name of the user that has an IP address which **starts** with the White Rabbit's user ID
        - Use commands like `grep`, `cat`, `find`, or `vim` to search through the CSV file
        - The CSV file contains user information including IDs, names, and IP addresses

  3. **Search the Logs folder for appearances of the name**
    
    !!! warning ""

          - Search for **all appearances** of the name you found in step 2 within the `Logs` folder
          - Use commands like `grep -r`, `find`, or similar tools to search recursively
          - Look through all log files in the directory
           
  4. **Sort the results by alphabetical order**
  
    !!! warning ""
    
        - Sort the **content only** (not the filenames)
        - Use alphabetical ordering
        - You might want to combine commands using pipes (`|`)
     
  5. **Get the password for the next room**
  
    !!! warning ""
    
        If all steps are done correctly, you will get the password for the next room from the sorted results.

**Files and Directories:**

- `users_list.csv` - Contains user information with IDs, names, and IP addresses
- `Logs/` folder - Contains various system log files to search through

## **Useful Commands:**

| Command | Man Page                                                      | Description                       |
| ------- | ------------------------------------------------------------- | --------------------------------- |
| `grep`  | 🔗 [`grep`](https://man7.org/linux/man-pages/man1/grep.1.html) | Search for patterns in files      |
| `sort`  | 🔗 [`sort`](https://man7.org/linux/man-pages/man1/sort.1.html) | Sort lines of text                |
| `cat`   | 🔗 [`cat`](https://man7.org/linux/man-pages/man1/cat.1.html)   | Display file contents             |
| `find`  | 🔗 [`find`](https://man7.org/linux/man-pages/man1/find.1.html) | Search for files and directories  |
| `cut`   | 🔗 [`cut`](https://man7.org/linux/man-pages/man1/cut.1.html)   | Extract specific columns from CSV |
| `awk`   | 🔗 [`awk`](https://man7.org/linux/man-pages/man1/awk.1.html)   | Text processing tool              |

## **Hints:**
- Use `grep` to search for the White Rabbit's user ID in system files
- Find where user are stored in Linux systems


