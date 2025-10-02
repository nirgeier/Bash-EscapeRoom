---
password: "linuxkernel"
title_prefix: "👤 "
summary: "Room 08 involves creating users, running background processes, and finding process IDs."
---

**PLAY WITH LINUX USERS & PROCESSES!**

---

# 👤 Room 08

!!! danger "sudo Access"
    - You might need `sudo` access for some commands.
    - The sudo password is required for elevated privileges.
    - The sudo password is: `escape`.
    - Write it down, you will need it later.

---

## Objective: Create and manage Linux users and processes

```markdown
To pass this room:
---------------------------------------------------------------------

- In this room we will play with Linux users & processes.

***********************************************
** Read all the instruction before you start **
***********************************************

Tasks: 
------

1. Create a bash script named `room08_proc.sh`
2. The script should keep running forever without any output.
3. Create a new user: `testUser`
4. Execute the script with the user `testUser` in the background!
   >> Yes in the background! means that your shell wont get affected.
      So if you don't know how its a good time to learn it....
5. Find out the process ID (PID) of the running script.
6. Pass the PID to the script and you should get the password to the next room.

Good Luck !!!
```

  1. Create a bash script named `room08_proc.sh` that runs forever without output.
   
    !!! warning ""
    
        "Infinite Loop Script": Use a `while` or `sleep` 
    
  2. Create a new user named `testUser`.
    
    !!! warning ""
    
        You will need sudo privileges to create a new user.
    
  3. Run the script in the background as `testUser`.
               
    !!! warning ""
    
        "Background Execution": Find how to run scripts in background.

  4. Find the PID of the running script.
     
    !!! warning ""
    
        - Try `ps` to list processes for the user. (find out the right flags)
        - Grep for the script name.
        - The command `ps -u` might not work on alpine... find out another way.
        - On BusyBox/Alpine, use: `ps -o pid,user,comm | grep ...` to find the PID.'`

  5. Pass the PID to `script.sh` to get the password.
     
---

## **Useful Commands:**

| Command   | Man Page                                                            | Description                                |
| --------- | ------------------------------------------------------------------- | ------------------------------------------ |
| `sudo`    | 🔗 [`sudo`](https://man7.org/linux/man-pages/man8/sudo.8.html)       | Execute a command as another user          |
| `useradd` | 🔗 [`useradd`](https://man7.org/linux/man-pages/man8/useradd.8.html) | Create a new user account                  |
| `ps`      | 🔗 [`ps`](https://man7.org/linux/man-pages/man1/ps.1.html)           | Report a snapshot of the current processes |
| `grep`    | 🔗 [`grep`](https://man7.org/linux/man-pages/man1/grep.1.html)       | Print lines matching a pattern             |
| `bash`    | 🔗 [`bash`](https://man7.org/linux/man-pages/man1/bash.1.html)       | GNU Bourne-Again SHell                     |

## **Useful ps Command flags:**

| Flag     | Description                        |
| -------- | ---------------------------------- |
| `-u`     | Show processes for a specific user |
| `-e`     | Show all processes                 |
| `-f`     | Show full format listing           |
| `--user` | Show processes for a specific user |
| `-p`     | Select by PID                      |
| `-a`     | Show processes for all users       |
| `-C`     | Select by command name             |
| `-o`     | User-defined format                |

**GOOD LUCK!**
