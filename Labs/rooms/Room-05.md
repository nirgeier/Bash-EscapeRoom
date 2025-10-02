---
password: "crazyroom"
title_prefix: "🤪 "
summary: "Room 05 requires extracting a key from a JavaScript script using extended attributes."
---

**GET PAST THE LOCKED DOOR!**

---

!!! danger "sudo Access"
    - You might need `sudo` access for some commands.
    - The sudo password is required for elevated privileges.
    - The sudo password is: `escape`.
    - Write it down, you will need it later.

---

## Objective: Get past the locked door by extracting the key from the JavaScript script

```markdown
To pass this room:
---------------------------------------------------------------------
- To proceed you need to figure out a way to get past the locked door. 
- In order to open the door you will need to do the following:
  1. Extract the key that is hidden inside the script in this folder.

Hints:
  * Find out the type of the script - in which language the script is written?
  * The information on how to lock the door is hidden as `Extended Attribute`
  * Once you figure out what need to be done - just execute the `lockedDoor` script 

In case you are really lost - unlock the hint script in this folder (key=hints)
```

  1. Determine the programming language of the script.
   
    !!! tip "Identify File Type"
    
        - Use the `file` command to identify the file type.
        - You will need to install `file` it if not already available.
    
  2. Check for extended attributes on the script file.
    
    !!! tip "Extended Attributes"
    
        - Extended attributes store additional metadata.
        - The attribute should provide clues on how to run the script.
        - Find out the required flags for the `getfattr` command.
        - If `getfattr` is not available, you may need to install it.
        
  3. Install the required tool you found in the previous step.
               
  4. Execute the script with the correct parameter.
     
    !!! warning ""

        - Based on the extended attribute, run the script with the specified argument.
        - This should reveal the key for the next room.

  5. Use the key to proceed to the next room.
     
    !!! warning ""

        The password for the next room is `********` 😊.

## **Useful Commands:**

| Command    | Man Page                                                              | Description             |
| ---------- | --------------------------------------------------------------------- | ----------------------- |
| `file`     | 🔗 [`file`](https://man7.org/linux/man-pages/man1/file.1.html)         | Determine file type     |
| `getfattr` | 🔗 [`getfattr`](https://man7.org/linux/man-pages/man1/getfattr.1.html) | Get extended attributes |
| `node`     | 🔗 [`node`](https://manpages.org/node)                                 | Run JavaScript files    |
| `python3`  | 🔗 [`python3`](https://manpages.org/python3)                           | Run Python scripts      |
| `ruby`     | 🔗 [`ruby`](https://manpages.org/ruby)                                 | Run Ruby scripts        |
| `perl`     | 🔗 [`perl`](https://manpages.org/perl)                                 | Run Perl scripts        |
| `php`      | 🔗 [`php`](https://manpages.org/php)                                   | Run PHP scripts         |
| `lua`      | 🔗 [`lua`](https://manpages.org/lua)                                   | Run Lua scripts         |
| `vim`      | 🔗 [`vim`](https://manpages.org/vim)                                   | Text editor             |


**GOOD LUCK!**
