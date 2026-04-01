---
password: "pipeline"
title_prefix: "🪞 "
summary: "Follow a chain of symbolic links to find the hidden treasure."
---

[![Room-13](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-13.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-13.yml)


**FOLLOW THE MIRRORS!**

---

## 🪞 The Mirror Maze

- Someone has created a labyrinth of symbolic links, each mirror pointing to the next.
- Follow the chain from start to finish to reach the treasure.

---

!!! abstract "📜 Mission Briefing"

    The directory `mirrors/` contains a chain of symbolic links.

    1. List all files in `mirrors/` including symlinks.
       > hint: `ls -la mirrors/`
    2. Start from `start.link` and follow the chain - each symlink points to the next.
       > hint: `readlink filename` shows what a symlink points to
    3. Reach the final file and read its contents to get the password.
       > hint: `cat` follows symlinks automatically

### Key Commands

| Command             | Purpose                                    |
| ------------------- | ------------------------------------------ |
| `ln -s target link` | Create a symbolic link                     |
| `ln target link`    | Create a hard link                         |
| `readlink file`     | Show what a symlink points to              |
| `readlink -f file`  | Resolve the full chain to the final target |
| `ls -la`            | List files showing symlink arrows          |

### How `ln` Works

```bash
# Create a symbolic (soft) link
ln -s /path/to/target linkname       # symlink - points to a path
ln -s ../other/file shortcut.txt     # relative symlink
ln -s /etc/hosts myhosts             # symlink to a system file

# Create a hard link (same inode, same filesystem only)
ln original.txt hardlink.txt

# Inspect links
ls -la                               # shows: linkname -> target
readlink linkname                    # print the symlink target
readlink -f linkname                 # resolve all symlinks, print absolute path
file linkname                        # shows "symbolic link to ..."

# Difference between hard and soft links
# Hard link: same data, same inode, deleting original keeps data
# Soft link: pointer to a path; broken if original is deleted

# Remove a link (does NOT delete the target)
unlink linkname
rm linkname
```

### Hints

!!! tip "Hint 1"

    `readlink -f start.link` will resolve the entire chain at once.

!!! tip "Hint 2"

    `cat` automatically follows symlink chains - try `cat start.link`.

---

!!! info "🔓 Unlock Room 14"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_14/README -out ../room_14/README.txt -pass pass:PASSWORD
    cat ../room_14/README.txt
    ```
