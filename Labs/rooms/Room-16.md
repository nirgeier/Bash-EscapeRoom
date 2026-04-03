---
title: "(Room 16) 🚀 The Space Station"
password: "json64"
title_prefix: "🚀 "
summary: "Use df and du to investigate disk usage and find the heaviest directory."
---

[![Room-16](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-16.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-16.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 16</span>
  <div class="room-title">
    <span class="room-title-accent">🚀 The</span>
    <span class="room-title-main">Space Station</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Use df and du to investigate disk usage and find the heaviest directory.

- The space station's storage system is overloaded.
- Find which module is consuming the most disk space to unlock the next door.

</div>

---

### MAP THE SPACE STATION!

<ol class="tasks">
  <li>Check available disk space on the filesystem. <code>df -h</code> shows disk usage in human-readable format</li>
  <li>Find which <strong>direct subdirectory</strong> of <code>station/</code> uses the most space. <code>du -sh station/*/</code> shows sizes of each subdirectory</li>
  <li>The password is the word <code>module</code> followed by the <strong>name</strong> of the largest subdirectory *(no space)*. Example: if <code>station/reactor/</code> is largest → password is <code>modulereactor</code></li>
</ol>

---

### Key Commands

| Command               | Purpose                                           |
| --------------------- | ------------------------------------------------- |
| `df -h`               | Show filesystem disk space usage (human-readable) |
| `du -sh dir/`         | Show total size of a directory                    |
| `du -sh */`           | Show sizes of all subdirectories                  |
| `du -sh * \| sort -h` | Sort directories by size                          |

### How `df` and `du` Work

```bash
# df - disk free: filesystem-level usage
df -h                               # all filesystems, human-readable (KB/MB/GB)
df -H                               # same but uses powers of 1000 not 1024
df /home                            # specific filesystem
df -T                               # show filesystem type
df --total                          # add total row at bottom
df -i                               # show inode usage instead of blocks

# du - disk usage: directory/file-level usage
du -sh /path/to/dir                 # summarized total in human-readable form
du -h /path/to/dir                  # size of each file and subdirectory
du -sh */                           # sizes of all items in current dir
du -sh * | sort -h                  # sort by size (smallest to largest)
du -sh * | sort -rh                 # sort by size (largest to smallest)
du -sh * | sort -rh | head -5       # top 5 largest items
du --max-depth=1 -h /var            # only one level deep
du -a -h /path                      # include files (not just directories)

# Combine to find largest items
du -sh /var/* | sort -rh | head -10 # top 10 largest in /var
find . -size +10M -exec du -sh {} \; # files larger than 10MB
```


<div class="hints" markdown="1">

> `du -sh station/*/` lists sizes for each direct subdirectory.

> Pipe through `sort -rh` to sort by size (largest first) - the first line is your answer.

</div>
---

!!! info "🔓 Unlock Room 17"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_17/README -out ../room_17/README.txt -pass pass:PASSWORD
    cat ../room_17/README.txt
    ```
