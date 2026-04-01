---
password: "northstar"
title_prefix: "📻 "
summary: "Count SOS signals in intercepted radio transmissions using grep."
---

[![Room-02](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-02.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-02.yml)


**COUNT THE DISTRESS SIGNALS!**

---

## 📻 The Broken Radio

- You intercepted **200 enemy radio transmissions**.
- Each message has a status tag - `OK`, `SOS`, `LOST`, or `NOISE`.
- Count the `SOS` signals to crack the code.

---

!!! abstract "📜 Mission Briefing"

    * The file `radio_intercepts.txt` contains **200** intercepted messages tagged with: `OK`, `SOS`, `LOST`, or `NOISE`.

    1. Count the number of lines containing `"SOS"` in `radio_intercepts.txt`.
       > hint: `grep -c` counts matching lines
    2. The password is the word `signal` followed by that count *(no space)*.
       > Example: if there are 23 SOS lines → password is `signal23`

### Key Commands

| Command | Purpose |
| --- | --- |
| `grep pattern file` | Search for pattern in file |
| `grep -i pattern file` | Case-insensitive search |
| `grep -v pattern file` | Invert match (lines NOT matching) |
| `grep -c pattern file` | Count matching lines |
| `grep -n pattern file` | Show line numbers |
| `grep -l pattern dir/` | List files containing pattern |
| `grep -r pattern dir/` | Recursive search |
| `grep -w word file` | Match whole word only |
| `grep -E "pat1\|pat2" file` | Extended regex (OR) |
| `grep -o pattern file` | Print only matched part |
| `grep -A 2 pattern file` | Show 2 lines after match |
| `grep -B 2 pattern file` | Show 2 lines before match |
| `grep -C 2 pattern file` | Show 2 lines around match |
| `grep --include="*.sh" -r pattern .` | Grep only .sh files |
| `wc file` | Count lines, words, bytes |
| `wc -l file` | Count lines only |
| `wc -w file` | Count words only |
| `wc -c file` | Count bytes |
| `wc -m file` | Count characters |

---

### How `grep` Works

```bash
# Basic usage
grep "pattern" file.txt               # search for pattern in a file
grep "pattern" *.txt                  # search across multiple files
grep "pattern" file1.txt file2.txt    # search in listed files

# Common flags
grep -c "pattern" file.txt            # count matching lines (not the lines themselves)
grep -i "pattern" file.txt            # case-insensitive search
grep -v "pattern" file.txt            # invert: show lines that do NOT match
grep -w "word" file.txt               # whole-word match only
grep -n "pattern" file.txt            # show line numbers alongside matches
grep -l "pattern" *.txt               # list filenames that match (not the lines)
grep -r "pattern" dir/                # recursive search through a directory

# Context around matches
grep -A 2 "pattern" file.txt          # 2 lines after each match
grep -B 2 "pattern" file.txt          # 2 lines before each match
grep -C 2 "pattern" file.txt          # 2 lines before AND after

# Regex patterns
grep "^start" file.txt                # lines starting with "start"
grep "end$" file.txt                  # lines ending with "end"
grep -E "cat|dog" file.txt            # extended regex: match either word
grep -E "^[0-9]+" file.txt            # lines starting with digits

# Combine with other commands
grep "ERROR" app.log | wc -l          # count error lines
grep -v "^#" config.txt               # skip comment lines
grep "pattern" file.txt | sort | uniq # unique matching lines
```

---

### Hints

!!! tip "Hint: Counting with `grep`"

    To count lines containing "SOS", use:
    ```bash
    grep -c "<text>" <file>
    ```

    * This will return a single number - the count of lines that contain "S<text>".
    * `grep -c` gives you a single number -the count of matching lines.

---

!!! info "🔓 Unlock Room 03"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
    -in ../room_03/README -out ../room_03/README.txt -pass pass:PASSWORD
    cat ../room_03/README.txt
    ```
