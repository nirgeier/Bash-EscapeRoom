
* Welcome to the first Room of the Bash Escape Room!


!!! danger "sudo Access"
    - You might need `sudo` access for some commands.
    - The sudo password is required for elevated privileges.
    - The sudo password is: `escape`.
    - Write it down, you will need it later.

---

## Objective: Find the hidden password by manipulating files in the `room_files` folder.

```markdown
This is what you need to do in the First room:
---------------------------------------------------------

1. Go to `room_files/room_01` folder
2. delete/move/filter-out all the files with `txt` extension.
   >> Hint: highly recommended to backup the folder before you make changes
3. Sort the remaining files by size 
   - Descending Order, including the `hidden files!!` 
4. View the file names on the screen, then take the `first letter` of each filename top-to-bottom.
5. Once you discover the hidden message, move to the next room.
6. Open next room README file using the hidden message in `lowercase` without spaces...
```



  1. Go to `room_files` folder
   
    !!! tip 
    
        - The folder is in the same directory as this README file.
        - You can navigate to it using the command: 
        ```sh
        cd room_files
        ```
    
  2. `Delete/move/filter-out` all the files with `.txt` extension.
    
    !!! danger
    
        - highly recommended to **backup** the folder before you make changes

    !!! tip "" 
    
        Figure out how to use `*` wildcard to select all `.txt` files at once.
        
  3. Sort the remaining files by `size` 
    
    !!! info ""

          - Sort in `Ascending Order`, including the **hidden files!!**
          - Use `ls` command with appropriate flags to achieve this.
          - You might want to check `man ls` for more details.
          - Hint: `-a` flag shows hidden files, `-S` sorts by size, and `-r` reverses the order.
           
  4. The password for the next room is the `first letter` of each filename top-to-bottom **(Lower Case)**.
  5. Once you discover the password, move to the next room.
  6. Move to [Room 02](Room-02.md) and use the password for decryption.
     
     Or: 
  
  7. Open the `README` file using the password in [lowercase] without spaces...
      - The file is encrypted using `vim` encryption.
      - The password is the one you found in step 4.
      - Use the command: `vim README` to open the file.
      - Make sure to open it in `vim` (not `nano` or any other editor).
      - If you are not familiar with `vim`, here is a quick guide:
        
        - To open the file: `vim README`
        - To enter the password, just type it when prompted.
        - To exit `vim`, type `:q!` to quit without saving or `:wq` to save and quit.
  
  
    !!! success ""

         - Once you open the encrypted file, use the command: `:set key=<password>` to set the decryption key.
         - Don't forget to save `:wq` in order to keep the file unlocked (also relevant for other rooms).

## **Useful Commands:**

| Command | Man Page                                                   | Description                         |
| ------- | ---------------------------------------------------------- | ----------------------------------- |
| `rm`    | 🔗 [`rm`](https://man7.org/linux/man-pages/man1/rm.1.html)  | Remove files or directories         |
| `mv`    | 🔗 [`mv`](https://man7.org/linux/man-pages/man1/mv.1.html)  | Move or rename files or directories |
| `ls`    | 🔗 [`ls`](https://man7.org/linux/man-pages/man1/ls.1.html)  | List directory contents             |
| `cd`    | 🔗 [`cd`](https://man7.org/linux/man-pages/man1/cd.1p.html) | Change directory                    |
| `vim`   | 🔗 [`vim`](https://manpages.org/vim)                        | Text editor                         |


**GOOD LUCK!**
