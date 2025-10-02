---
password: "linuxrocks"
title_prefix: "🤪 "
summary: "Room 06 requires filtering and manipulating data from a CSV file."
---

**FILTER AND MANIPULATE DATA FROM A CSV FILE**

---

# 🤪 Room 06

!!! danger "sudo Access"
    - You might need `sudo` access for some commands.
    - The sudo password is required for elevated privileges.
    - The sudo password is: `escape`.
    - Write it down, you will need it later.

---

## Objective: Filter and manipulate data from a CSV file to unlock the next room

```markdown
To pass this room:
---------------------------------------------------------------------

- This room is about filtering and text manipulation (hint: cat, awk, grep, sed, cut).
- To proceed you need to do the following on the 'table.csv':

1. Filter the `files` column content.
2. Filter only `png` extensions files
3. Remove the `junk` from the file names
4. Sort by alphanumeric order
5. Remove the `.png` extension and the numbers
6. Save the output lines in a file named 'message', each word in separate line 
7. Execute the node script to get the key

Good Luck!!
```

1. Examine the `table.csv` file to understand its structure.
   
    !!! tip "CSV Structure"
    
        - The file contains columns: first_name, last_name, email, file, employee.
        - Focus on the `file` column for filenames.
    
2. Extract the `file` column from the CSV.
    
    !!! tip "Extract Column"
    
        - Use `cut` or `awk` to extract the 4th column (file column).
        - Skip the header row.
        
3. Filter only files with `.png` extension.
               
    !!! tip "Filter PNG Files"
    
        - Use `grep` to find lines ending with `.png`.
        
4. Remove the `junk` prefix and numbers from filenames.
     
    !!! tip "Remove Junk"
    
        - Use `sed` to remove `junk` and digits before `.png`.
        - For example, `junk4good.png` becomes `good.png`.
        
5. Sort the filenames alphanumerically.
     
    !!! tip "Sort Filenames"
    
        - Use `sort` command to arrange in alphabetical order.
        
6. Remove the `.png` extension.
     
    !!! tip "Remove Extension"
    
        - Use `sed` or `cut` to remove `.png` from each filename.
        
7. Save each word on a separate line in a file named `message`.
     
    !!! tip "Create Message File"
    
        - Use output redirection to save to `message` file.
        - Each filename should be on its own line.
        
8. Execute the Node.js script to get the key.
     
    !!! tip "Run Script"
    
        - Use `node script.js` to run the JavaScript file.
        - If Node.js is not installed, you may need to install it.
        - The script checks the `message` file and reveals the key if correct.

9. Use the key to proceed to the next room.
     

---

## **Useful Commands:**

| Command | Man Page                                                      | Description                                       |
| ------- | ------------------------------------------------------------- | ------------------------------------------------- |
| `cat`   | 🔗 [`cat`](https://man7.org/linux/man-pages/man1/cat.1.html)   | Concatenate and display files                     |
| `awk`   | 🔗 [`awk`](https://man7.org/linux/man-pages/man1/awk.1.html)   | Pattern scanning and processing language          |
| `grep`  | 🔗 [`grep`](https://man7.org/linux/man-pages/man1/grep.1.html) | Print lines matching a pattern                    |
| `sed`   | 🔗 [`sed`](https://man7.org/linux/man-pages/man1/sed.1.html)   | Stream editor for filtering and transforming text |
| `cut`   | 🔗 [`cut`](https://man7.org/linux/man-pages/man1/cut.1.html)   | Remove sections from each line of files           |
| `sort`  | 🔗 [`sort`](https://man7.org/linux/man-pages/man1/sort.1.html) | Sort lines of text files                          |
| `node`  | 🔗 [`node`](https://manpages.org/node)                         | Run JavaScript files                              |


**GOOD LUCK!**
