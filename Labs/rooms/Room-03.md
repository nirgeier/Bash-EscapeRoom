---
title: "(Room 03) ⏳ The Time Capsule"
password: "signal59"
title_prefix: "⏳ "
summary: "Use tac, rev, head, tail, and wc to decode a time capsule journal."
---

[![Room-03](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-03.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-03.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 03</span>
  <div class="room-title">
    <span class="room-title-accent">⏳ The</span>
    <span class="room-title-main">Time Capsule</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Use tac, rev, head, tail, and wc to decode a time capsule journal.

- An ancient journal was found buried underground.
- Its last entry holds a secret - but the characters are written **backwards**.
- Use line and character reversal tools to decode it.

</div>

---

### DECODE THE TIME CAPSULE!

<ol class="tasks">
  <li>Count how many lines the file has. <code>wc -l</code> counts lines</li>
  <li>Reverse the <strong>line order</strong> so the last line becomes the first. <code>tac</code> reverses line order (it is <code>cat</code> spelled backwards!)</li>
  <li>Take the first line of the reversed output. pipe <code>tac</code> output to <code>head -1</code></li>
  <li>That line has its <strong>characters</strong> reversed -unreverse it! <code>rev</code> reverses character order within each line</li>
  <li>The decoded line reveals a secret word.</li>
  <li>The password is that word followed by the total line count *(no space)*. Example: if the word is "hello" and there are 50 lines → <code>hello50</code></li>
</ol>

---

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


<div class="hints" markdown="1">

> `tac` is `cat` spelled backwards -and it reverses **line order**.

> `rev` reverses the **characters** within each line.

> The password format is: the secret word + the line count (e.g., `word50`).

</div>
---

!!! info "🔓 Unlock Room 04"

    Once you solve the puzzle, run:

    ```bash
    next <PASSWORD>
    ```
