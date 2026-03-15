---
password: "heredoc5"
title_prefix: "🌍 "
summary: "Use command substitution and process substitution to combine command outputs."
---

**ENTER THE NESTED WORLDS!**

---

## 🌍 The Nested Worlds

- Some commands can only run inside other commands.
- Master the art of nesting commands within commands.

---

!!! abstract "📜 Mission Briefing"

    The files `world_a.txt` and `world_b.txt` each contain a list of words.

    1. Use process substitution to diff the sorted contents without creating temp files.
       > hint: `diff <(sort world_a.txt) <(sort world_b.txt)`
    2. Count words that appear in BOTH files (the intersection).
       > hint: `comm -12 <(sort world_a.txt) <(sort world_b.txt) | wc -l`
    3. The password is `nested` followed by the intersection count *(no space)*.
       > Example: if 42 words are in both → `nested42`

### Key Commands

| Syntax          | Purpose                                      |
| --------------- | -------------------------------------------- |
| `$(command)`    | Command substitution: replace with output    |
| `` `command` `` | Old-style command substitution               |
| `<(command)`    | Process substitution: command output as file |
| `>(command)`    | Process substitution: pipe into command      |

### How Command and Process Substitution Work

```bash
# Command substitution - use output as value
today=$(date +%Y-%m-%d)             # capture date into variable
files=$(ls *.txt)                   # capture ls output
count=$(wc -l < file.txt)          # capture line count
echo "Today is $(date)"            # inline in string

# Nested command substitution
dir=$(basename $(pwd))             # basename of current directory
longest=$(sort -n file.txt | tail -1)  # get largest number

# Process substitution - treat command output as a file
diff <(sort file1.txt) <(sort file2.txt)    # diff without temp files
comm -12 <(sort a.txt) <(sort b.txt)        # intersection
wc -l <(grep "error" app.log)              # count errors without temp file

# Process substitution for output
tee >(gzip > output.gz) < input.txt        # write compressed copy
command > >(tee output.txt) 2>&1           # tee stderr+stdout

# Practical combinations
diff <(cut -d: -f1 /etc/passwd | sort) \
     <(cut -d: -f1 /etc/group | sort)     # compare user vs group names

# Arithmetic with command substitution
size=$(du -sb dir/ | cut -f1)
echo "Size in MB: $(( size / 1048576 ))"
```

### Hints

!!! tip "Hint 1"

    `<(command)` creates a virtual file from a command's output - no temp file needed.

!!! tip "Hint 2"

    `comm -12` shows only lines common to BOTH files (both must be sorted).

---

!!! info "🔓 Unlock Room 36"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_36/README -out ../room_36/README.txt -pass pass:PASSWORD
    cat ../room_36/README.txt
    ```
