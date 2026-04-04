---
title: "(Room 44) 🔄 The Mirror Sync"
password: "syscall"
title_prefix: "🔄 "
summary: "Use rsync to synchronize files between two directories and verify the transfer."
---

[![Room-44](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-44.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-44.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 44</span>
  <div class="room-title">
    <span class="room-title-accent">🔄 The</span>
    <span class="room-title-main">Mirror Sync</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Use rsync to synchronize files between two directories and verify the transfer.

- Two archives must be kept in sync, but something has drifted.
- Use `rsync` to synchronize them and then verify the result.

</div>

---

### SYNC THE MIRROR ARCHIVE!

<ol class="tasks">
  <li>Sync <code>source_archive/</code> to <code>mirror_archive/</code> using rsync. <code>rsync -av source_archive/ mirror_archive/</code></li>
  <li>After syncing, count the total number of files in <code>mirror_archive/</code>. <code>find mirror_archive/ -type f | wc -l</code></li>
  <li>The password is <code>sync</code> followed by the file count *(no space)*. Example: if there are 28 files → <code>sync28</code></li>
</ol>

---

### Key Commands

| Command | Purpose |
| --- | --- |
| `rsync -av src/ dst/` | Archive mode + verbose |
| `rsync -n src/ dst/` | Dry run (no changes) |
| `rsync --delete src/ dst/` | Delete files not in src |
| `rsync -z src/ dst/` | Compress during transfer |
| `rsync -P src/ dst/` | Progress + partial files |
| `rsync -e ssh src/ user@host:dst/` | Transfer over SSH |
| `rsync --exclude="*.log" src/ dst/` | Exclude pattern |
| `rsync --include="*.txt" --exclude="*" src/ dst/` | Include only .txt |
| `rsync -u src/ dst/` | Skip newer files in dst |
| `rsync --checksum src/ dst/` | Compare by checksum, not mtime |
| `rsync --bwlimit=1000 src/ dst/` | Throttle to 1 MB/s |
| `rsync -a --stats src/ dst/` | Show transfer statistics |
| `rsync -a --log-file=sync.log src/ dst/` | Log to file |
| `rsync --backup --backup-dir=backup/ src/ dst/` | Keep old versions |

### How `rsync` Works

```bash
# Basic local sync
rsync -av source/ destination/          # sync with verbose output
rsync -a source/ destination/           # archive mode (preserves permissions, times, etc.)
rsync -n source/ destination/           # dry run: show what WOULD happen, don't copy

# Archive mode (-a) includes:
# -r recursive   -l copy symlinks   -p preserve permissions
# -t preserve timestamps   -g preserve group   -o preserve owner

# Delete files in destination that don't exist in source
rsync -av --delete source/ destination/

# Exclude files
rsync -av --exclude='*.log' source/ destination/
rsync -av --exclude-from='exclude.txt' source/ destination/

# Remote sync via SSH
rsync -av source/ user@remote:/path/to/dest/      # push to remote
rsync -av user@remote:/path/to/src/ destination/  # pull from remote
rsync -avz source/ user@remote:/dest/             # with compression

# Progress and partial transfers
rsync -av --progress source/ dest/        # show per-file progress
rsync -av --partial source/ dest/         # keep partial transfers (resume)
rsync -avP source/ dest/                  # --partial --progress shorthand

# Verify transfer (checksum mode)
rsync -avc source/ destination/          # compare by checksum not timestamp

# Useful flags summary
# -a = archive (recursive + preserve metadata)
# -v = verbose
# -z = compress during transfer
# -n = dry-run
# -P = --partial --progress
# --delete = remove extra files in destination
```


<div class="hints" markdown="1">

> `rsync -av source_archive/ mirror_archive/` - note the trailing slash on source is important!

> `find mirror_archive/ -type f | wc -l` counts only regular files, not directories.

</div>
---

!!! info "🔓 Unlock Room 45"

    Once you solve the puzzle, run:

    ```bash
    next <PASSWORD>
    ```
