---
title: "(Room 46) 📝 The Vi Vortex"
password: "cipher99"
title_prefix: "📝 "
summary: "Navigate vim to find and decode a password hidden in a large text file."
---

[![Room-46](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-46.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-46.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 46</span>
  <div class="room-title">
    <span class="room-title-accent">📝 The</span>
    <span class="room-title-main">Vi Vortex</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Navigate vim to find and decode a password hidden in a large text file.

- A critical document is locked inside a file that can only be navigated with `vim`.
- The password is hidden on a specific line - find it without scrolling forever.

</div>

---

### ENTER THE VI VORTEX!

<ol class="tasks">
  <li>Open the file in vim. <code>vim ancient_tome.txt</code></li>
  <li>Jump directly to line 777. In vim, type <code>777G</code> or <code>:777</code></li>
  <li>The line reads <code>SECRET: <password></code> - note the password word.</li>
  <li>Exit vim without saving. <code>:q!</code></li>
  <li>The word after <code>SECRET:</code> <strong>is</strong> the password.</li>
</ol>

---

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


<div class="hints" markdown="1">

> Once in vim, type `777G` (capital G) to jump directly to line 777.

> Alternatively, avoid vim entirely: `sed -n '777p' ancient_tome.txt` prints just line 777.

</div>
---

!!! info "🔓 Unlock Room 47"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_47/README -out ../room_47/README.txt -pass pass:PASSWORD
    cat ../room_47/README.txt
    ```
