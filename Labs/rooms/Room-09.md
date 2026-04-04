---
title: "(Room 09) 👻 The Ghost Process"
password: "export99"
title_prefix: "👻 "
summary: "Create users, manage background processes, and find PIDs."
---

[![Room-09](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-09.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-09.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 09</span>
  <div class="room-title">
    <span class="room-title-accent">👻 The</span>
    <span class="room-title-main">Ghost Process</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Create users, manage background processes, and find PIDs.

- A ghost process haunts this room.
- Create it, send it to the background, find its PID, and capture it!

</div>

---

### SUMMON AND CAPTURE THE GHOST!

<ol class="tasks">
  <li>Create a new user named <code>ghost_user</code>. <code>sudo adduser -D ghost_user</code> (Alpine) or <code>sudo useradd ghost_user</code></li>
  <li>Create a bash script <code>ghost_loop.sh</code> that runs an infinite loop silently. Example: <code>while true; do sleep 1; done</code></li>
  <li>Run the script as <code>ghost_user</code> in the <strong>background</strong>. <code>sudo -u ghost_user bash ./ghost_loop.sh &</code></li>
  <li>Find the process ID (PID) of the running ghost script. <code>ps aux | grep ghost</code> or <code>ps -eo pid,user,comm | grep ghost</code></li>
  <li>Pass the PID to <code>./getKey.sh <PID></code> to capture the ghost.</li>
</ol>

---

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


<div class="hints" markdown="1">

> Create a simple infinite loop script: `while true; do sleep 1; done`

> `grep -v grep` filters out the grep process itself from `ps` output.

> Pass the PID as argument to `getKey.sh`: `./getKey.sh 12345`

</div>
---

!!! info "🔓 Unlock Room 10"

    Once you solve the puzzle, run:

    ```bash
    next <PASSWORD>
    ```
