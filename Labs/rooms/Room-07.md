---
password: "unique37"
title_prefix: "🔐 "
summary: "Fix file permissions using chmod to unlock the gates."
---

[![Room-07](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-07.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-07.yml)


**FIX THE PERMISSIONS!**

---

## 🔐 The Permission Maze

- Seven gates block your path, each with wrong permissions.
- Set them correctly to proceed.

!!! abstract "📜 Mission Briefing"

    Seven locked gates block your path. Each gate is a file with **wrong**
    permissions. Fix them all to proceed!

    | File   | Required Permission | Numeric |
    |--------|---------------------|---------|
    | gate_1 | rwxr-xr-x           | 755     |
    | gate_2 | rw-r--r--           | 644     |
    | gate_3 | rwx------           | 700     |
    | gate_4 | r--r--r--           | 444     |
    | gate_5 | rwxrwxr-x           | 775     |
    | gate_6 | rw-rw----           | 660     |
    | gate_7 | r-x--x--x           | 511     |

    1. Check current permissions: `ls -l gate_*`
    2. Fix each gate using `chmod`.
    3. Once **all** gates are correct, run `./getKey.sh` to get the password.

---

### Key Commands

| Command | Purpose |
| --- | --- |
| `chmod 755 file` | Set rwxr-xr-x (octal) |
| `chmod 644 file` | Set rw-r--r-- (octal) |
| `chmod u+x file` | Add execute for owner |
| `chmod go-w file` | Remove write for group and others |
| `chmod a+r file` | Add read for all |
| `chmod -R 755 dir/` | Recursive chmod |
| `chmod u=rwx,go=rx file` | Explicit symbolic notation |
| `stat file` | Detailed file metadata |
| `stat -c "%a" file` | Show octal permissions only |
| `stat -c "%U %G" file` | Show owner and group |
| `stat -c "%s" file` | Show file size in bytes |
| `ls -l file` | Long listing with permissions |
| `ls -la` | Include hidden files |
| `ls -lh` | Human-readable sizes |
| `ls -lt` | Sort by modification time |
| `ls -lS` | Sort by file size |
| `ls -ld dir/` | Show dir itself, not contents |
| `umask` | Show default permission mask |

---

### How `chmod` Works

```bash
# Numeric (octal) mode
chmod 755 file       # rwxr-xr-x  (owner: all, group+others: read+execute)
chmod 644 file       # rw-r--r--  (owner: read+write, others: read)
chmod 700 file       # rwx------  (owner only, no access for others)
chmod 777 file       # rwxrwxrwx  (full access for everyone)
chmod 000 file       # ---------  (no permissions for anyone)
chmod 600 file       # rw-------  (owner read+write only)
chmod 444 file       # r--r--r--  (read-only for everyone)

# Symbolic mode - add, remove, or set permissions
chmod u+x file       # add execute for user (owner)
chmod g-w file       # remove write from group
chmod o=r file       # set others to read only (exact)
chmod a+r file       # add read for all (user, group, others)
chmod u=rwx,g=rx,o=r file   # set all three at once

# Apply recursively to a directory
chmod -R 755 mydir/

# Check current permissions
ls -l file           # shows symbolic: -rwxr-xr-x
stat -c "%a %n" file # shows numeric:  755 file
stat -c "%A %n" file # shows symbolic: -rwxr-xr-x file
```

---

### Linux Permission System

```
rwxrwxrwx = User, Group, Others
r = read (4), w = write (2), x = execute (1)

Examples:
  755 = rwxr-xr-x (owner: full, others: read+execute)
  644 = rw-r--r-- (owner: read+write, others: read only)
  700 = rwx------ (owner only)
```

### Required Permissions

| File   | Permission | Numeric |
| ------ | ---------- | ------- |
| gate_1 | rwxr-xr-x  | 755     |
| gate_2 | rw-r--r--  | 644     |
| gate_3 | rwx------  | 700     |
| gate_4 | r--r--r--  | 444     |
| gate_5 | rwxrwxr-x  | 775     |
| gate_6 | rw-rw----  | 660     |
| gate_7 | r-x--x--x  | 511     |

---

!!! info "🔓 Unlock Room 08"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_08/README -out ../room_08/README.txt -pass pass:PASSWORD
    cat ../room_08/README
    ```
