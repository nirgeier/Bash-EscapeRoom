---
password: "linuxistallfun"
title_prefix: "🤪 "
summary: "Room 04 requires deciphering crazy text by replacing substituted letters to find the password."
---

**DECODE THE CRAZY TEXT!**

---

# 🤪 Room 04

!!! tip "Decryption Tip"
    If the content doesn't appear after entering the password, please refresh the page (F5 or Ctrl+R).

## Welcome to Room 04

## Objective: Decode the `crazyText` file by replacing substituted letters to find the password for the `key`

```markdown
To pass this room:
---------------------------------------------------------------------

- The room keeper of this place is a crazy guy who `speaks` very odd.
- To be able to read the message you will need to do the following:

  1. The room keeper doesn't like the letter `H` so he replaced it with `zing` (dont ask me why...)
  2. He is not into `h` as well, so he replace it with `blu`.
  3. He despise the letter `i`, so he prefer to say it as `bla`.
  4. The keeper **love** to use `sed` command....

- What is the password to the next room?
  >>> Hint: keep looking around the folder....
- The password is in the `key` file, but it is encrypted with `vim` encryption.
```

---

  1. **Understand the substitutions**
   
    !!! tip "Letter Substitutions"
    
        - The crazy guy replaced certain letters with words:
          - `H` (capital H) → `zing`
          - `h` (lowercase h) → `blu`
          - `i` (lowercase i) → `bla`
        - You need to reverse these substitutions to read the real message
    
  2. **Read the `crazyText` file**
    
    !!! warning ""
    
        - Use commands like `cat`, `less`, or `vim` to view the file content
        - Look for the hidden message by replacing the substituted words back to letters

  3. **Use `sed` to decode the text**
    
    !!! tip "Using sed for Decoding"

          - The room keeper loves `sed` command - use it to perform the replacements
          - You can chain multiple `sed` commands to replace all substitutions at once
          - Example: `sed 's/zing/H/g; s/blu/h/g; s/bla/i/g' crazyText`
           
  4. **Find the password**
  
    !!! warning ""
    
        - The decoded text will reveal the password for the `key` file
        - The password is a single word that describes something fun related to Linux
     
  5. **Use the password to unlock the key**
  
    !!! warning ""
    
        - The `key` file is encrypted with `vim` encryption
        - Use `vim key` and enter the password when prompted
        - Inside vim, disable encryption with `:set key=` and save with `:wq`
        - The unlocked key will contain the password for the next room

## **Files and Directories:**

| File        | Description                                                      |
| ----------- | ---------------------------------------------------------------- |
| `crazyText` | File containing the crazy guy's message with substituted letters |
| `key`       | Encrypted file containing the password for the next room         |
| `README`    | Instructions for the room (this file)                            |

## **Useful Commands:**

| Command | Man Page                                                      | Description                            |
| ------- | ------------------------------------------------------------- | -------------------------------------- |
| `sed`   | 🔗 [`sed`](https://man7.org/linux/man-pages/man1/sed.1.html)   | Stream editor for text transformations |
| `cat`   | 🔗 [`cat`](https://man7.org/linux/man-pages/man1/cat.1.html)   | Display file contents                  |
| `vim`   | 🔗 [`vim`](https://manpages.org/vim)                           | Text editor (supports file encryption) |
| `grep`  | 🔗 [`grep`](https://man7.org/linux/man-pages/man1/grep.1.html) | Search for patterns in files           |

## **Hints:**

- Use `sed` with multiple substitution commands separated by semicolons
- The substitutions are `case-sensitive` 
- After decoding, look for the line that mentions "password for the key"
- Remember to save the decrypted key file with `:wq` in vim

**GOOD LUCK!**

