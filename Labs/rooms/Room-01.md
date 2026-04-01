---
title_prefix: "🧭 "
summary: "Use `find` to locate hidden map fragments in a deep directory tree."
---

[![Room-01](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-01.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-01.yml)


FIND THE MAP FRAGMENTS!

---

!!! danger "⚠️ sudo Access"

    * You might need sudo access for some commands.
    * The sudo password is required for elevated privileges.
    * The sudo password is: `escape`.
    * Write it down, you will need it later.

---

## The Lost Expedition

- A famous explorer vanished deep in the jungle, leaving **9 map fragments** scattered across a maze of directories, mixed in with thousands of noise files, only the `.map` files contain the clues.

---

!!! abstract "📜 Your mission"

    1. Navigate into the `expedition/` directory.
    2. The `expedition/` camp is littered with noise files (`.rock`, `.leaf`, `.twig`) everywhere.
       **Ignore them all.**
    3. The explorer left exactly **`9 map fragments`** (files ending in `.map`) hidden across the sub-directories.
       **Find them all.**
       > hint: the `find` command can search recursively for files by name pattern
    5. Once you locate all `.map` files, **sort** their full paths alphabetically and **read** (`cat`) their contents in that order.
    6. Concatenate the letters -they spell the **password for the next room**.

---

### Key Commands

| Command | Purpose |
| --- | --- |
| `find . -name "*.txt"` | Find files by name pattern |
| `find . -type f` | Find only files (not dirs) |
| `find . -type d` | Find only directories |
| `find . -mtime -7` | Files modified in last 7 days |
| `find . -size +1M` | Files larger than 1 MB |
| `find . -perm 644` | Files with exact permissions |
| `find . -name "*.log" -delete` | Find and delete matching files |
| `find . -maxdepth 2` | Limit search depth |
| `find . -not -name "*.txt"` | Exclude pattern |
| `cat file` | Print file to stdout |
| `cat -n file` | Show with line numbers |
| `cat -A file` | Show non-printing chars (tabs, EOL) |
| `cat file1 file2` | Concatenate files |
| `sort file` | Sort lines alphabetically |
| `sort -n file` | Numeric sort |
| `sort -r file` | Reverse sort |
| `sort -k2 file` | Sort by 2nd field |
| `sort -u file` | Sort and deduplicate |
| `xargs cmd` | Build cmd args from stdin |
| `xargs -I{} cmd {}` | Replace {} with each item |

---

### How `find` Works

```bash
# Find by name pattern
find . -name "*.txt"                      # files ending in .txt
find . -name "report.txt"                 # exact name match
find . -iname "*.TXT"                     # case-insensitive match

# Find by type
find . -type f                            # regular files only
find . -type d                            # directories only
find . -type l                            # symbolic links only

# Find by depth
find . -maxdepth 2 -name "*.txt"          # search at most 2 levels deep
find . -mindepth 2 -name "*.txt"          # skip the top level

# Find by size
find . -size +1k                          # larger than 1KB
find . -size -100c                        # smaller than 100 bytes
find . -size +1M -size -10M               # between 1MB and 10MB

# Find by modification time
find . -mtime -1                          # modified in the last 24 hours
find . -mtime +7                          # modified more than 7 days ago
find . -newer reference.txt               # newer than a reference file

# Find by permissions
find . -perm 755                          # exact permission match
find . -perm /u+x                         # executable by owner

# Execute a command on each result
find . -name "*.log" -exec rm {} \;       # delete each found file
find . -name "*.txt" -exec cat {} +       # cat all found files at once
```

### Piping Commands Together

```bash
# Pipe basics: stdout of cmd1 becomes stdin of cmd2
cmd1 | cmd2 | cmd3

# xargs: build and run commands from stdin input
echo "file.txt" | xargs cat               # cat file.txt
find . -name "*.txt" | xargs wc -l        # count lines in all .txt files
find . -name "*.map" | sort | xargs cat   # sort paths then read all in order

# xargs options
find . -name "*.txt" | xargs -I{} cp {} /backup/  # use {} as placeholder
find . -name "*.txt" | xargs -n1 cat              # process one file at a time
find . -print0 | xargs -0 ls -l                   # handle filenames with spaces
```

---

### Hints

!!! tip "Hint 1"

    The `find` command searches through ALL subdirectories by default.

!!! tip "Hint 2"

    `sort` without flags sorts alphabetically -perfect for getting the right order.

!!! tip "Hint 3"

    `xargs cat` reads each file found by `find` and displays its content.

---

!!! info "🔓 Unlock Room 02"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2  \
            -in ../room_02/README           \
            -out ../room_02/README.txt      \
            -pass pass:PASSWORD

    cat ../room_02/README.txt
    ```
