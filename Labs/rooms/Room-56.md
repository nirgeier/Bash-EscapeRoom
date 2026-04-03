---
title: "(Room 56) ⚙️ The Process Controller"
password: "procctrl"
title_prefix: "⚙️ "
summary: "Control processes with pgrep, pkill, nohup, nice, and renice - advanced process management."
---

<div class="room-hero">
  <span class="room-badge">ROOM 56</span>
  <div class="room-title">
    <span class="room-title-accent">⚙️ The</span>
    <span class="room-title-main">Process Controller</span>
  </div>
</div>

[![Room-56](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-56.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-56.yml)


**CONTROL THE CHAOS!**

---


- Rogue processes are multiplying in the background, consuming resources and hiding secrets.
- The Process Controller must find them, read their secrets, and terminate them in the correct order.

---

<div class="tasks" markdown="1">

Rogue agent processes have been launched and are writing to log files in `/tmp/`.
Hunt them down, extract the key, and shut them all down.

1. Launch the background agents.
   > `./launch_agents.sh`
2. Find all running agent processes with their full command lines.
3. The agents write output to log files - find and read the key log.
4. Stop the main keeper process to begin the shutdown sequence.
5. Run `./getKey.sh` after all agents are stopped to retrieve the final code.

</div>

### Key Commands

| Command                      | Purpose                                               |
| ---------------------------- | ----------------------------------------------------- |
| `pgrep name`                 | Find PIDs of processes matching the name              |
| `pgrep -l name`              | Show PID and process name                             |
| `pgrep -a name`              | Show PID and full command line                        |
| `pgrep -u user`              | Find all processes belonging to a user                |
| `pgrep -f pattern`           | Match against the full command line string            |
| `pgrep -c name`              | Print only the count of matching processes            |
| `pkill name`                 | Send SIGTERM to all processes matching name           |
| `pkill -9 name`              | Force kill with SIGKILL (cannot be caught)            |
| `pkill -f pattern`           | Kill by matching full command line                    |
| `pkill -u user`              | Kill all processes belonging to a user                |
| `pkill -SIGNAL name`         | Send any named signal (e.g. `-HUP`, `-USR1`)          |
| `nohup cmd &`                | Run command immune to terminal hangup (SIGHUP)        |
| `nohup cmd > out.log 2>&1 &` | nohup with explicit output capture                    |
| `disown %1`                  | Remove job from shell's job table after backgrounding |
| `nice -n 10 cmd`             | Run command with lower CPU priority (niceness 10)     |
| `nice -n -5 cmd`             | Higher priority (requires root; negative value)       |
| `renice -n 5 -p PID`         | Adjust priority of an already-running process         |
| `renice -n 10 -u user`       | Lower priority of all processes for a user            |
| `killall name`               | Kill all processes with the exact given name          |
| `wait PID`                   | Pause the shell until the specified PID finishes      |

### How `pgrep`, `pkill`, `nohup`, and `nice` Work

```bash
# --- pgrep ---
pgrep bash                         # list PIDs of all bash processes
pgrep -l python3                   # PID + name: "12345 python3"
pgrep -a gunicorn                  # PID + full argv: "12345 gunicorn app:create_app"
pgrep -u www-data                  # all PIDs owned by www-data
pgrep -f "python.*worker"          # match full command line with regex
pgrep -c nginx                     # just the count (e.g. "4")

# --- pkill ---
pkill nginx                        # graceful stop (SIGTERM) of nginx workers
pkill -HUP nginx                   # reload config (SIGHUP)
pkill -9 zombie_proc               # force kill unresponsive process
pkill -f "python manage.py"        # kill by matching command string
pkill -u testuser                  # kill all processes owned by testuser

# --- nohup ---
nohup ./long_job.sh &              # run in background, immune to logout
nohup ./server.sh > server.log 2>&1 &  # capture all output explicitly
echo $!                            # PID of the last backgrounded process
disown %1                          # detach from shell without nohup

# --- nice / renice ---
nice -n 10 make -j8                # compile with low CPU priority
nice -n 19 rsync -a /src /dst      # lowest possible priority for backup
sudo nice -n -10 ./latency_sensitive_task   # elevate (root required)
renice -n 15 -p $(pgrep ffmpeg)    # lower a running encode job
renice -n 10 -u batch_user         # throttle all processes of a user
ps -o pid,ni,comm -p $(pgrep ffmpeg)       # verify the new nice value

# --- killall / wait ---
killall -q firefox                 # quiet kill (no error if not found)
./launch_agents.sh &
BGPID=$!
wait $BGPID                        # block until background job finishes
echo "exit code: $?"
```


<div class="hints" markdown="1">

> `pgrep -af "agent"` shows full command lines alongside PIDs, making it easy to distinguish between multiple agent processes. Use the output to identify which PID belongs to `agent_keeper` before running `pkill`.

> `nohup` redirects stdout and stderr to `nohup.out` in the current directory by default if you don't redirect them yourself. Always redirect explicitly with `> logfile 2>&1 &` to know exactly where the output goes.

</div>
---

!!! success "🎉 Bonus Track Complete!"

    You've conquered all 6 bonus rooms and mastered the complete set of 100 bash commands.

    **You are now truly a Bash Master.**

    Use `masterkey` to take the **Exit Exam** if you haven't already:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_99/README -out ../room_99/README.txt -pass pass:masterkey
    cat ../room_99/README.txt
    ```
