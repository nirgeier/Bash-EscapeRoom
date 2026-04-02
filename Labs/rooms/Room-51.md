---
password: "masterkey"
title_prefix: "🔧 "
summary: "Use xargs to build and execute commands from standard input, processing files in bulk."
---

[![Room-51](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-51.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-51.yml)


**ASSEMBLE THE COMMANDS!**

---

## 🔧 The Command Assembler

- The Command Assembler's workshop is full of orphaned parts scattered across directories.
- Each part file contains a numeric VALUE. You must assemble them all using xargs to find the total.

---

!!! abstract "📜 Mission Briefing"

    The `parts/` directory contains multiple `.part` files, each holding a line like `VALUE=N`.

    1. Find all `.part` files recursively using `find`.
    2. Use `xargs` to pass each file to `grep` and extract the `VALUE=` lines.
    3. Use `cut` to extract just the number after the `=` sign.
    4. Sum all numbers using `paste` to build an expression and `bc` to evaluate it.
    5. Pass the total to `./getKey.sh` to retrieve the password.

### Key Commands

| Command                                  | Purpose                                                   |
| ---------------------------------------- | --------------------------------------------------------- |
| `xargs cmd`                              | Build and run `cmd` with arguments read from stdin        |
| `xargs -I{} cmd {}`                      | Replace `{}` with each input item individually            |
| `xargs -n N cmd`                         | Pass at most N arguments per command execution            |
| `xargs -P N cmd`                         | Run up to N processes in parallel                         |
| `xargs -0 cmd`                           | Use null-separated input (safe for filenames with spaces) |
| `find . -print0 \| xargs -0 cmd`         | Null-safe combined find and xargs pattern                 |
| `xargs -t cmd`                           | Print each command to stderr before executing it          |
| `xargs -r cmd`                           | Do not run command if input is empty                      |
| `xargs --max-args=N cmd`                 | Long form of `-n N`                                       |
| `xargs --max-procs=N cmd`                | Long form of `-P N`                                       |
| `echo "a b c" \| xargs`                  | Strip and normalize whitespace from input                 |
| `cat files.txt \| xargs rm`              | Delete every file listed in `files.txt`                   |
| `xargs -I{} sh -c 'cmd {}'`              | Use a subshell for complex per-item logic                 |
| `ls *.log \| xargs wc -l`                | Count lines across many files at once                     |
| `find . -name "*.tmp" \| xargs -r rm -f` | Safely delete temp files (skip if none found)             |

### How `xargs` Works

```bash
# Basic usage - append all stdin items as arguments
echo "file1.txt file2.txt file3.txt" | xargs cat

# -I{} - substitute each item individually
ls *.txt | xargs -I{} cp {} /backup/{}

# -n N - limit arguments per invocation
echo "a b c d e f" | xargs -n 2 echo
# Output:
# a b
# c d
# e f

# -P N - parallel execution (run 4 jobs at once)
find images/ -name "*.png" | xargs -P 4 -I{} convert {} {}.jpg

# -0 with find -print0 - safe for filenames containing spaces
find . -name "* *" -print0 | xargs -0 -I{} mv {} "$(echo {} | tr ' ' '_')"

# -t - debug: print each command before running
find logs/ -name "*.log" | xargs -t grep -l "ERROR"

# -r - skip execution if stdin is empty
find /tmp -name "*.sock" | xargs -r -0 rm -f

# Complex per-file logic using a subshell
find data/ -name "*.enc" | xargs -I{} sh -c 'base64 -d < {} | gzip -d > ${1%.enc}.txt' _ {}

# Sum values from multiple files
find dir/ -name "*.ext" | xargs grep -h "KEY=" | cut -d= -f2 | paste -sd+ | bc
```

### Hints

!!! tip "Hint 1"

    For complex per-file processing, use `xargs -I{} sh -c '...'` to invoke a subshell.
    Example: `find . -name "*.b64" | xargs -I{} sh -c 'base64 -d < {} | grep KEY'`

!!! tip "Hint 2"

    Add the `-t` flag to debug your pipeline - it prints every command to stderr before running it so you can see exactly what `xargs` is doing.

---

!!! info "🔓 Unlock Room 52"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_52/README -out ../room_52/README.txt -pass pass:PASSWORD
    cat ../room_52/README.txt
    ```
