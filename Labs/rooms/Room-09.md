---
password: "export99"
title_prefix: "👻 "
summary: "Create users, manage background processes, and find PIDs."
---

**SUMMON AND CAPTURE THE GHOST!**

---

## 👻 The Ghost Process

- A ghost process haunts this room.
- Create it, send it to the background, find its PID, and capture it!

!!! abstract "📜 Mission Briefing"

    A ghost process must be summoned and captured!

    1. Create a new user named `ghost_user`.
       > hint: `sudo adduser -D ghost_user` (Alpine) or `sudo useradd ghost_user`
    2. Create a bash script `ghost_loop.sh` that runs an infinite loop silently.
       > Example: `while true; do sleep 1; done`
    3. Run the script as `ghost_user` in the **background**.
       > hint: `sudo -u ghost_user bash ./ghost_loop.sh &`
    4. Find the process ID (PID) of the running ghost script.
       > hint: `ps aux | grep ghost` or `ps -eo pid,user,comm | grep ghost`
    5. Pass the PID to `./getKey.sh <PID>` to capture the ghost.

### Key Commands

| Command               | Purpose                        |
| --------------------- | ------------------------------ |
| `ps`                  | Show current shell's processes |
| `ps aux`              | Show all processes (all users) |
| `ps -ef`              | Full-format listing            |
| `ps aux --sort=-%cpu` | Sort by CPU usage              |
| `ps aux --sort=-%mem` | Sort by memory usage           |
| `ps -u username`      | Processes for a specific user  |
| `ps -p PID`           | Show specific PID info         |
| `ps --forest`         | Show process tree              |
| `kill PID`            | Send SIGTERM to process        |
| `kill -9 PID`         | Force kill (SIGKILL)           |
| `kill -l`             | List all signal names          |
| `kill -SIGSTOP PID`   | Pause a process                |
| `kill -SIGCONT PID`   | Resume a paused process        |
| `jobs`                | List background jobs           |
| `jobs -l`             | List with PIDs                 |
| `bg %1`               | Resume job 1 in background     |
| `fg %1`               | Bring job 1 to foreground      |
| `Ctrl+Z`              | Suspend foreground process     |
| `Ctrl+C`              | Interrupt foreground process   |
| `nohup cmd &`         | Run immune to hangup           |

### How Background Processes Work

```bash
# Run a command in the background
./script.sh &                         # append & to any command
nohup ./script.sh &                   # keep running after logout
nohup ./script.sh > output.log 2>&1 & # redirect output + background

# Job control
jobs                                  # list background jobs in current shell
jobs -l                               # include PIDs
fg %1                                 # bring job 1 to foreground
bg %1                                 # resume suspended job in background
Ctrl+Z                                # suspend the current foreground process

# View running processes
ps aux                                # all processes, full detail (BSD style)
ps -ef                                # all processes, full format (Unix style)
ps -eo pid,user,comm                  # custom columns: PID, user, command name
ps -eo pid,user,args --sort=user      # sort output by user
ps -u username                        # processes owned by a specific user

# Find a process by name
pgrep nginx                           # print PIDs matching name
pgrep -u root nginx                   # match by name AND user
ps aux | grep processname             # manual grep approach
ps aux | grep processname | grep -v grep  # exclude the grep itself

# Signals and kill
kill PID                              # send SIGTERM (graceful stop)
kill -15 PID                          # same as above (explicit)
kill -9 PID                           # send SIGKILL (force stop, no cleanup)
kill -l                               # list all available signals
killall processname                   # kill all processes by name
pkill -u username                     # kill all processes by user
```

### Hints

!!! tip "Hint 1"

    Create a simple infinite loop script: `while true; do sleep 1; done`

!!! tip "Hint 2"

    `grep -v grep` filters out the grep process itself from `ps` output.

!!! tip "Hint 3"

    Pass the PID as argument to `getKey.sh`: `./getKey.sh 12345`

---

!!! info "🔓 Unlock Room 10"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_10/README -out ../room_10/README.txt -pass pass:PASSWORD
    cat ../room_10/README
    ```
