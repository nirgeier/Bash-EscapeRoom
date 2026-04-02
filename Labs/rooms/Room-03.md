---
password: "signal59"
title_prefix: "⏳ "
summary: "Use tac, rev, head, tail, and wc to decode a time capsule journal."
---

[![Room-03](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-03.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-03.yml)


**DECODE THE TIME CAPSULE!**

---

## ⏳ The Time Capsule

- An ancient journal was found buried underground.
- Its last entry holds a secret - but the characters are written **backwards**.
- Use line and character reversal tools to decode it.

!!! abstract "📜 Mission Briefing"

    - The file `time_capsule.txt` contains journal entries.
    - The last entry holds a secret, but it is written **backwards**.

    1. Count how many lines the file has.
       > hint: `wc -l` counts lines
    2. Reverse the **line order** so the last line becomes the first.
       > hint: `tac` reverses line order (it is `cat` spelled backwards!)
    3. Take the first line of the reversed output.
       > hint: pipe `tac` output to `head -1`
    4. That line has its **characters** reversed -unreverse it!
       > hint: `rev` reverses character order within each line
    5. The decoded line reveals a secret word.
    6. The password is that word
       followed by the total line count *(no space)*.
       > Example: if the word is "hello" and there are 50 lines → `hello50`

### Key Commands

| Command | Purpose |
| --- | --- |
| `head file` | Show first 10 lines |
| `head -n 20 file` | Show first 20 lines |
| `head -c 100 file` | Show first 100 bytes |
| `tail file` | Show last 10 lines |
| `tail -n 20 file` | Show last 20 lines |
| `tail -f file` | Follow file as it grows (live log) |
| `tail -F file` | Follow even if file is rotated |
| `tail -c 100 file` | Show last 100 bytes |
| `tail -n +5 file` | Show from line 5 to end |
| `tac file` | Print lines in reverse order |
| `rev file` | Reverse each line character by character |
| `wc -l file` | Count lines |
| `wc -w file` | Count words |
| `wc -c file` | Count bytes |
| `nl file` | Number lines (like cat -n) |
| `head -1 file \| wc -c` | Count chars in first line |

### How Text Processing Tools Work

```bash
# tac - reverse line order (cat spelled backwards)
tac file.txt                          # print lines in reverse order
tac file1.txt file2.txt               # reverse and concatenate files
tac file.txt | head -1                # get the very last line of a file

# rev - reverse characters on each line
rev file.txt                          # reverse chars on every line
echo "hello" | rev                    # outputs: olleh
rev file.txt | tac                    # reverse chars AND line order

# head - show the beginning of a file
head file.txt                         # first 10 lines (default)
head -n 5 file.txt                    # first N lines
head -n -5 file.txt                   # all lines EXCEPT the last 5
head -c 100 file.txt                  # first 100 bytes

# tail - show the end of a file
tail file.txt                         # last 10 lines (default)
tail -n 5 file.txt                    # last N lines
tail -n +2 file.txt                   # skip first line, print the rest
tail -f file.txt                      # follow: live-stream new appended lines

# wc - count lines, words, bytes
wc file.txt                           # lines, words, bytes (all three)
wc -l file.txt                        # count lines only
wc -w file.txt                        # count words only
wc -c file.txt                        # count bytes
wc -m file.txt                        # count characters
wc -l *.txt                           # count lines across multiple files
```

---

### Hints

!!! tip "Hint 1"

    `tac` is `cat` spelled backwards -and it reverses **line order**.

!!! tip "Hint 2"

    `rev` reverses the **characters** within each line.

!!! tip "Hint 3"

    The password format is: the secret word + the line count (e.g., `word50`).

---

!!! info "🔓 Unlock Room 04"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_04/README -out ../room_04/README.txt -pass pass:PASSWORD
    cat ../room_04/README
    ```
