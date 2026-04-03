---
title: "(Room 42) 🗂️ The Open Files Archive"
password: "ncat7"
title_prefix: "🗂️ "
summary: "Use lsof to list open files and identify which process holds the secret."
---

[![Room-42](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-42.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-42.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 42</span>
  <div class="room-title">
    <span class="room-title-accent">🗂️ The</span>
    <span class="room-title-main">Open Files Archive</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Use lsof to list open files and identify which process holds the secret.

- A process has opened a secret file but hasn't released it.
- Use `lsof` to find which process is holding the key.

</div>

---

### OPEN THE FILE ARCHIVE!

<ol class="tasks">
  <li>Find which process has <code>secret_key.txt</code> open. <code>lsof | grep secret_key.txt</code></li>
  <li>Note the PID of that process.</li>
  <li>See what other files that process has open. <code>lsof -p <PID></code></li>
  <li>Among those files, find one named <code>password.txt</code> - read it. use the path from <code>lsof</code> output, then <code>cat</code> it</li>
</ol>

---

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


<div class="hints" markdown="1">

> `lsof | grep secret_key` finds the process; note the PID in the second column.

> `lsof -p <PID> | grep REG` shows all regular files open by that process.

</div>
---

!!! info "🔓 Unlock Room 43"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_43/README -out ../room_43/README.txt -pass pass:PASSWORD
    cat ../room_43/README.txt
    ```
