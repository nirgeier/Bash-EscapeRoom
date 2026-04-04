---
title: "(Room 35) 🌍 The Nested Worlds"
password: "heredoc5"
title_prefix: "🌍 "
summary: "Use command substitution and process substitution to combine command outputs."
---

[![Room-35](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-35.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-35.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 35</span>
  <div class="room-title">
    <span class="room-title-accent">🌍 The</span>
    <span class="room-title-main">Nested Worlds</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Use command substitution and process substitution to combine command outputs.

- Some commands can only run inside other commands.
- Master the art of nesting commands within commands.

</div>

---

### ENTER THE NESTED WORLDS!

<ol class="tasks">
  <li>Use process substitution to diff the sorted contents without creating temp files. <code>diff <(sort world_a.txt) <(sort world_b.txt)</code></li>
  <li>Count words that appear in BOTH files (the intersection). <code>comm -12 <(sort world_a.txt) <(sort world_b.txt) | wc -l</code></li>
  <li>The password is <code>nested</code> followed by the intersection count *(no space)*. Example: if 42 words are in both → <code>nested42</code></li>
</ol>

---

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


<div class="hints" markdown="1">

> `<(command)` creates a virtual file from a command's output - no temp file needed.

> `comm -12` shows only lines common to BOTH files (both must be sorted).

</div>
---

!!! info "🔓 Unlock Room 36"

    Once you solve the puzzle, run:

    ```bash
    next <PASSWORD>
    ```
