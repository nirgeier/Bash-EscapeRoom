---
title: "(Room 18) 🏗️ The Twin Blueprints"
password: "cron5min"
title_prefix: "🏗️ "
summary: "Use diff and patch to identify changes between blueprint versions."
---

[![Room-18](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-18.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-18.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 18</span>
  <div class="room-title">
    <span class="room-title-accent">🏗️ The</span>
    <span class="room-title-main">Twin Blueprints</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Use diff and patch to identify changes between blueprint versions.

- Two versions of a building blueprint exist.
- A saboteur changed something between version 1 and version 2.
- Find exactly what changed and read the altered line.

</div>

---

### SPOT THE SABOTAGE!

<ol class="tasks">
  <li>Compare the two files to see what changed. <code>diff blueprint_v1.txt blueprint_v2.txt</code></li>
  <li>Lines starting with <code><</code> are in v1 only; lines starting with <code>></code> are in v2 only.</li>
  <li>The saboteur inserted a line containing the password in v2. Find the <strong>added line</strong> (starts with <code>></code>).</li>
  <li>The value on that line <strong>is</strong> the password.</li>
</ol>

---

### Key Commands

| Command | Purpose |
| ------- | ------- |
| `diff file1 file2` | Show differences between two files |
| `diff -u file1 file2` | Unified diff format (more readable) |
| `diff -y file1 file2` | Side-by-side comparison |
| `patch file < changes.patch` | Apply a patch to a file |

### How `diff` and `patch` Work

```bash
# diff - compare files line by line
diff file1.txt file2.txt                # default output
diff -u file1.txt file2.txt             # unified format (easier to read)
diff -U 3 file1.txt file2.txt           # unified with 3 lines of context
diff -y file1.txt file2.txt             # side-by-side
diff -y --width=80 file1.txt file2.txt  # side-by-side with width limit
diff -q file1.txt file2.txt             # just say if files differ (quiet)
diff -r dir1/ dir2/                     # recursive directory diff

# Understanding default diff output:
# 5c5       = change: line 5 in file1 changed to line 5 in file2
# 3a4       = add: after line 3 in file1, add line 4 from file2
# 7d6       = delete: line 7 in file1 was deleted
# < line    = line from file1
# > line    = line from file2

# patch - apply a diff to a file
diff -u original.txt modified.txt > changes.patch   # create a patch file
patch original.txt < changes.patch                  # apply patch (in place)
patch -p1 < changes.patch                           # strip 1 path component
patch --dry-run < changes.patch                     # test without applying
patch -R file.txt < changes.patch                   # reverse: undo a patch
```


<div class="hints" markdown="1">

> Lines prefixed with `>` in `diff` output are lines that exist in file2 (v2) but not file1.

> Use `diff blueprint_v1.txt blueprint_v2.txt | grep '^>'` to see only added lines.

</div>
---

!!! info "🔓 Unlock Room 19"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_19/README -out ../room_19/README.txt -pass pass:PASSWORD
    cat ../room_19/README.txt
    ```
