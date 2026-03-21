---
password: "epoch6026"
title_prefix: "🖨️ "
summary: "Use printf to format a template precisely and assemble the password."
---

**FORMAT THE TRANSMISSION!**

---

## 🖨️ The Formatter's Workshop

- A broken printer is garbling messages.
- Only precisely formatted output will unlock the next door.

---

!!! abstract "📜 Mission Briefing"

    The file `template.txt` contains a format string and values to plug in.

    1. Read `template.txt` to see the required format and the values.
    2. Use `printf` to format the output exactly as specified.
       > hint: `printf "%-10s %05d\n" "word" 42`
    3. The formatted output contains the password on the last line.
    4. The password is the last word on the last output line.

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

### Hints

!!! tip "Hint 1"

    `printf` format codes: `%s` for strings, `%d` for integers, `%-10s` for left-aligned 10-wide.

!!! tip "Hint 2"

    The last line of the formatted output contains the password as the final word.

---

!!! info "🔓 Unlock Room 25"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_25/README -out ../room_25/README.txt -pass pass:PASSWORD
    cat ../room_25/README.txt
    ```
