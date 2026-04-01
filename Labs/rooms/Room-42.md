---
password: "ncat7"
title_prefix: "🗂️ "
summary: "Use lsof to list open files and identify which process holds the secret."
---

[![Room-42](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-42.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-42.yml)


**OPEN THE FILE ARCHIVE!**

---

## 🗂️ The Open Files Archive

- A process has opened a secret file but hasn't released it.
- Use `lsof` to find which process is holding the key.

---

!!! abstract "📜 Mission Briefing"

    A process is keeping a file named `secret_key.txt` open.

    1. Find which process has `secret_key.txt` open.
       > hint: `lsof | grep secret_key.txt`
    2. Note the PID of that process.
    3. See what other files that process has open.
       > hint: `lsof -p <PID>`
    4. Among those files, find one named `password.txt` - read it.
       > hint: use the path from `lsof` output, then `cat` it

### Key Commands

| Command              | Purpose                            |
| -------------------- | ---------------------------------- |
| `lsof`               | List all open files                |
| `lsof -p PID`        | Files opened by a specific process |
| `lsof -u username`   | Files opened by a user             |
| `lsof -i :PORT`      | Process using a specific port      |
| `lsof /path/to/file` | Processes that have this file open |

### How `lsof` Works

```bash
# List all open files (can be huge output)
lsof                                    # all open files, all processes
lsof | head -20                         # first 20 results

# Filter by process
lsof -p 1234                           # all files opened by PID 1234
lsof -p 1234,5678                      # multiple PIDs

# Filter by user
lsof -u alice                          # files opened by user alice
lsof -u ^root                          # files NOT opened by root

# Filter by file/path
lsof /var/log/syslog                   # who has syslog open
lsof +D /var/log/                      # all files open in directory
lsof /dev/null                         # processes with /dev/null open

# Network connections
lsof -i                                # all network connections
lsof -i :80                            # processes on port 80
lsof -i TCP                            # TCP connections only
lsof -i TCP:8080-9090                  # TCP in port range

# Combine filters
lsof -u alice -i TCP                   # alice's TCP connections
lsof -u alice +D /home/alice           # alice's open files in her home

# Find deleted files still held open (disk space issue)
lsof | grep deleted                    # files deleted but still open

# Output fields
# COMMAND PID USER FD TYPE DEVICE SIZE/OFF NODE NAME
# FD: cwd=current dir, txt=executable, mem=memory mapped, 0=stdin, 1=stdout, 2=stderr
```

### Hints

!!! tip "Hint 1"

    `lsof | grep secret_key` finds the process; note the PID in the second column.

!!! tip "Hint 2"

    `lsof -p <PID> | grep REG` shows all regular files open by that process.

---

!!! info "🔓 Unlock Room 43"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_43/README -out ../room_43/README.txt -pass pass:PASSWORD
    cat ../room_43/README.txt
    ```
