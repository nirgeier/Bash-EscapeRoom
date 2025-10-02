---
password: "472"
title_prefix: "🦜 "
summary: "Room 03 requires analyzing a song file to compute a numeric key that unlocks the creature's cage."
---

**FOLLOW THE CREATURE, FREE SCRIPTACORUS!**

---

# 🦜 Room 03

!!! tip "Decryption Tip"
    If the content doesn't appear after entering the password, please refresh the page (F5 or Ctrl+R).

## Welcome to Room 03!

## Objective: Analyze the `song` file to compute a numeric key, free the `creature`, and `unlock` the `treasure chest`

```markdown
To pass this room:
---------------------------------------------------------------------

- Get the key to the treasureChest!

* This room has a strange but very kindly creature: `Scriptacorus!!`.
* The creature is locked in his cage (`creature.sh`) with a key (`key`).
* To release the creature you need to find the key (password) to open the encrypted cage:

* The steps to get the `key` are the following:
  
  Perform the described action on the `song'` file and summarize the results, 
  the **sum is the key** to open the (`creature.sh`) cage:

  1. count all `do` word appearances
  2. count only LINES which `NOT` contain `home`
  3. count only `non empty` lines 
 
To open the cage:
-----------------
 
1. Open the `creature.sh` using the key you found
2. Disable encryption with `:set key=` command (setting the encrypt key to empty)
3. Save the new (unencrypted) file
4. Wake up the Scriptacorus!! (He will tell you the key to the treasureChest once you feed him)
   >> hint: Once you opened the cage you can view its content
5. Find the key to the treasure chest and use it
```

---

  1. **Compute three counts from the `song` file**
   
    !!! tip "Understanding the Key"
    
        - The key to open the encrypted `script.sh` (creature's cage) is the **sum** of three numbers
        - You must count specific patterns in the `song` file
        - Each count contributes to the final numeric key
    
  2. **Calculate the three values**
    
    !!! tip "Useful `grep` Flags for Counting the expected patterns"
    
        | Flag | Description                                                |
        | ---- | ---------------------------------------------------------- |
        | `-o` | Print only the matched parts of a matching line            |
        | `-i` | Ignore case distinctions in patterns and data              |
        | `-E` | Interpret patterns as extended regular expressions         |
        | `-v` | Invert the sense of matching, to select non-matching lines |
        | `-c` | Print a count of matching lines for each input file        |
        | `-e` | Use the following argument as a pattern                    |

  3. **Open the encrypted cage (`script.sh`)**
    
    !!! warning "Opening Encrypted Files"

          - Use `vim` to open the encrypted script
          - The file will prompt you for a password/key
          - Enter the numeric key you computed from step 2
          - Command: `vim script.sh`
           
  4. **Disable the encryption inside vim**
  
    !!! warning ""
    
        - Once the file is open, disable encryption with: `:set key=`
        - This sets the encryption key to empty, unlocking the file
        - Save and exit with `:wq`
     
  5. **Wake and feed Scriptacorus**
  
    !!! warning ""
    
        - After opening the cage, you can view the script content
        - Follow the instructions in the unlocked `script.sh` to wake the creature
        - Feed the creature using the `food` file if needed
        - Scriptacorus will reveal the key to the `treasureChest`

  6. **Use the treasure key to unlock the treasure chest**
  
    !!! warning ""
    
        - Once Scriptacorus gives you the treasure key, use it to open `treasureChest`
        - This may be another encrypted file or a final puzzle

## **Files and Directories:**

| File          | Description                                                                           |
| ------------- | ------------------------------------------------------------------------------------- |
| `song`        | Text file to analyze for counting patterns                                            |
| `creature.sh` | The encrypted cage holding Scriptacorus (may be named `creature.sh` in some versions) |
| `food`        | Feed the creature after releasing it                                                  |


## **Useful Commands:**

| Command | Man Page                                                      | Description                            |
| ------- | ------------------------------------------------------------- | -------------------------------------- |
| `grep`  | 🔗 [`grep`](https://man7.org/linux/man-pages/man1/grep.1.html) | Search for patterns in files           |
| `wc`    | 🔗 [`wc`](https://man7.org/linux/man-pages/man1/wc.1.html)     | Count lines, words, or characters      |
| `vim`   | 🔗 [`vim`](https://manpages.org/vim)                           | Text editor (supports file encryption) |
| `cat`   | 🔗 [`cat`](https://man7.org/linux/man-pages/man1/cat.1.html)   | Display file contents                  |
| `echo`  | 🔗 [`echo`](https://man7.org/linux/man-pages/man1/echo.1.html) | Print text or variables                |

## **Hints:**

- Remember to save the file after using `:set key=` in vim to permanently decrypt it
- You can use mulltiple `grep` flags together to achieve the desired counts
- Use `\b` word boundaries in `grep` to match whole words only (e.g., "do" but not "doing")
- The `-v` flag in `grep` inverts the match (shows lines that do NOT match)
- You will need to resole multiple tasks to get the final key

**GOOD LUCK!**

