---
title: "(Room 24) 🖨️ The Formatter's Workshop"
password: "epoch6026"
title_prefix: "🖨️ "
summary: "Use printf to format a template precisely and assemble the password."
---

[![Room-24](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-24.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-24.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 24</span>
  <div class="room-title">
    <span class="room-title-accent">🖨️ The</span>
    <span class="room-title-main">Formatter's Workshop</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Use printf to format a template precisely and assemble the password.

- A broken printer is garbling messages.
- Only precisely formatted output will unlock the next door.

</div>

---

### FORMAT THE TRANSMISSION!

<ol class="tasks">
  <li>Read <code>template.txt</code> to see the required format and the values.</li>
  <li>Use <code>printf</code> to format the output exactly as specified. <code>printf "%-10s %05d
" "word" 42</code></li>
  <li>The formatted output contains the password on the last line.</li>
  <li>The password is the last word on the last output line.</li>
</ol>

---

### Key Commands

| Command | Purpose |
| ------- | ------- |
| `printf "FORMAT" ARGS` | Formatted output (like C printf) |
| `printf "%s\n" "text"` | Print string with newline |
| `printf "%d" 42` | Print integer |
| `printf "%05d" 42` | Print integer padded to 5 digits |
| `echo -n "text"` | Print without newline |
| `echo -e "a\tb"` | Print with escape sequences |

### How `printf` Works

```bash
# Basic printf
printf "Hello, World!\n"                # print with explicit newline
printf "%s\n" "hello"                   # %s = string
printf "%d\n" 42                        # %d = integer
printf "%f\n" 3.14                      # %f = float
printf "%.2f\n" 3.14159                 # 2 decimal places: 3.14

# Width and padding
printf "%10s\n" "right"                 # right-align in 10-wide field: "     right"
printf "%-10s\n" "left"                 # left-align in 10-wide field:  "left      "
printf "%05d\n" 42                      # zero-pad to 5 digits: "00042"
printf "%+d\n" 42                       # always show sign: "+42"

# Multiple arguments
printf "%s: %d\n" "count" 42           # "count: 42"
printf "%-8s %4d %6.2f\n" "item" 3 9.5  # formatted table row

# Escape sequences in printf
printf "line1\nline2\n"                 # newline
printf "col1\tcol2\n"                   # tab
printf "bell\a\n"                       # bell
printf "Name: %s\tAge: %d\n" "Bob" 25  # tab-separated

# printf vs echo
echo "Hello"                            # adds newline automatically
echo -n "Hello"                         # no newline
echo -e "a\tb"                         # process escape sequences
printf "Hello\n"                        # explicit newline needed
printf "%s %s\n" "Hello" "World"       # formatted with args
```


<div class="hints" markdown="1">

> `printf` format codes: `%s` for strings, `%d` for integers, `%-10s` for left-aligned 10-wide.

> The last line of the formatted output contains the password as the final word.

</div>
---

!!! info "🔓 Unlock Room 25"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_25/README -out ../room_25/README.txt -pass pass:PASSWORD
    cat ../room_25/README.txt
    ```
