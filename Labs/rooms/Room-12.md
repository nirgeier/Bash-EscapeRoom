---
password: "layered7"
title_prefix: "🎼 "
summary: "Build a multi-stage pipeline using cut, tr, and pipes."
---

[![Room-12](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-12.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-12.yml)


**CONDUCT THE PIPELINE!**

---

## 🎼 The Grand Pipeline

Master the art of chaining commands with pipes. Extract data from a structured
file, transform it step by step, and reveal the password.

!!! abstract "📜 Mission Briefing"

    The file `stations.txt` contains 8 city records.
    Format: `CityName|Population|Area|Code`

    Build a **single pipeline** to derive the password:

    1. Extract city names (first field, `|` delimiter).
       > hint: `cut -d'|' -f1 stations.txt`
    2. Take the **first letter** of each city name.
       > hint: `cut -c1`
    3. Combine all letters into one line (remove newlines).
       > hint: `tr -d '\n'`
    4. Convert to **lowercase**.
       > hint: `tr 'A-Z' 'a-z'`
    5. The result is the password!

### Key Commands

| Command | Purpose |
|---------|---------|
| `cut -d'\|' -f1` | Extract field 1 using `\|` delimiter |
| `cut -c1` | Extract the first character |
| `tr -d '\n'` | Remove newline characters |
| `tr 'A-Z' 'a-z'` | Convert to lowercase |
| `\|` (pipe) | Send output of one command to the next |

### The Data Format

```
CityName|Population|Area|Code
Portland|653115|145|PDX
Indianapolis|887642|368|IND
...
```

### How Pipeline Tools Work

```bash
# cut - extract specific fields or characters
cut -d',' -f1 file.csv              # field 1 from comma-delimited file
cut -d':' -f1,3 /etc/passwd         # fields 1 and 3, colon-delimited
cut -d'|' -f2- file.txt             # from field 2 to end of line
cut -c1 file.txt                    # first character of each line
cut -c1-5 file.txt                  # characters 1 through 5
cut -c1,5,10 file.txt               # characters 1, 5, and 10

# tr - translate or delete characters
tr 'a-z' 'A-Z' < file.txt          # lowercase to uppercase
tr 'A-Z' 'a-z' < file.txt          # uppercase to lowercase
tr -d '\n' < file.txt              # remove all newlines (join lines)
tr -d ' ' < file.txt               # remove all spaces
tr -s ' ' < file.txt               # squeeze repeated spaces into one
tr -d '[:punct:]' < file.txt       # remove all punctuation
tr '[:upper:]' '[:lower:]' < file.txt  # using character class names

# Pipes - chain commands together
cmd1 | cmd2 | cmd3                  # output of each feeds the next
cmd1 | tee file.txt | cmd2          # save mid-pipeline to file AND continue
cmd1 | head -5                      # take only first 5 lines
cmd1 | tail -5                      # take only last 5 lines
cmd1 | wc -l                        # count lines of output
cmd1 | sort | uniq -c | sort -rn    # frequency count pattern
```

### Hints

!!! tip "Hint"

    The first letters of the city names spell the password!

---

!!! info "🔓 Unlock Room 13"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_13/README -out ../room_13/README.txt -pass pass:PASSWORD
    cat ../room_13/README.txt
    ```
