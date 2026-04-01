---
password: "syscall"
title_prefix: "🔄 "
summary: "Use rsync to synchronize files between two directories and verify the transfer."
---

[![Room-44](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-44.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-44.yml)


**SYNC THE MIRROR ARCHIVE!**

---

## 🔄 The Mirror Sync

- Two archives must be kept in sync, but something has drifted.
- Use `rsync` to synchronize them and then verify the result.

---

!!! abstract "📜 Mission Briefing"

    The directory `source_archive/` is the master copy.
    The directory `mirror_archive/` is supposed to be identical but has drifted.

    1. Sync `source_archive/` to `mirror_archive/` using rsync.
       > hint: `rsync -av source_archive/ mirror_archive/`
    2. After syncing, count the total number of files in `mirror_archive/`.
       > hint: `find mirror_archive/ -type f | wc -l`
    3. The password is `sync` followed by the file count *(no space)*.
       > Example: if there are 28 files → `sync28`

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

### Hints

!!! tip "Hint 1"

    `rsync -av source_archive/ mirror_archive/` - note the trailing slash on source is important!

!!! tip "Hint 2"

    `find mirror_archive/ -type f | wc -l` counts only regular files, not directories.

---

!!! info "🔓 Unlock Room 45"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_45/README -out ../room_45/README.txt -pass pass:PASSWORD
    cat ../room_45/README.txt
    ```
