---
password: "cipher99"
title_prefix: "📝 "
summary: "Navigate vim to find and decode a password hidden in a large text file."
---

[![Room-46](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-46.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-46.yml)


**ENTER THE VI VORTEX!**

---

## 📝 The Vi Vortex

- A critical document is locked inside a file that can only be navigated with `vim`.
- The password is hidden on a specific line - find it without scrolling forever.

---

!!! abstract "📜 Mission Briefing"

    The file `ancient_tome.txt` has 1000 lines. The password is on **line 777**.

    1. Open the file in vim.
       > hint: `vim ancient_tome.txt`
    2. Jump directly to line 777.
       > hint: In vim, type `777G` or `:777`
    3. The line reads `SECRET: <password>` - note the password word.
    4. Exit vim without saving.
       > hint: `:q!`
    5. The word after `SECRET:` **is** the password.

### Key Commands

| Vim Command | Purpose                    |
| ----------- | -------------------------- |
| `i`         | Enter insert mode          |
| `Esc`       | Return to normal mode      |
| `:q!`       | Quit without saving        |
| `:wq`       | Save and quit              |
| `NG`        | Jump to line N             |
| `:N`        | Jump to line N             |
| `/pattern`  | Search forward for pattern |
| `n`         | Next search match          |

### How `vim` Works

```bash
# Open a file
vim filename.txt
vim +100 filename.txt                  # open at line 100
vim +/pattern filename.txt             # open at first match of pattern

# Normal mode navigation
gg                                     # go to first line
G                                      # go to last line
50G                                    # go to line 50
:50                                    # go to line 50 (command mode)
Ctrl+f                                 # page forward
Ctrl+b                                 # page backward
0                                      # beginning of line
$                                      # end of line
w                                      # next word
b                                      # previous word

# Searching
/pattern                               # search forward
?pattern                               # search backward
n                                      # next match
N                                      # previous match
:%s/old/new/g                         # replace all occurrences

# Insert mode
i                                      # insert before cursor
a                                      # append after cursor
o                                      # open new line below
O                                      # open new line above

# Saving and exiting
:w                                     # write (save) file
:q                                     # quit (fails if unsaved changes)
:wq                                    # write and quit
:q!                                    # quit without saving (discard changes)
ZZ                                     # save and quit (normal mode shortcut)

# Other useful commands
u                                      # undo
Ctrl+r                                 # redo
dd                                     # delete current line
yy                                     # yank (copy) current line
p                                      # paste after cursor
```

### Hints

!!! tip "Hint 1"

    Once in vim, type `777G` (capital G) to jump directly to line 777.

!!! tip "Hint 2"

    Alternatively, avoid vim entirely: `sed -n '777p' ancient_tome.txt` prints just line 777.

---

!!! info "🔓 Unlock Room 47"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_47/README -out ../room_47/README.txt -pass pass:PASSWORD
    cat ../room_47/README.txt
    ```
