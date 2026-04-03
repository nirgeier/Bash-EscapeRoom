---
title: "(Room 38) 💣 The Time Bomb"
password: "readline"
title_prefix: "💣 "
summary: "Use timeout and watch to manage time-limited and repeated commands."
---

[![Room-38](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-38.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-38.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 38</span>
  <div class="room-title">
    <span class="room-title-accent">💣 The</span>
    <span class="room-title-main">Time Bomb</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Use timeout and watch to manage time-limited and repeated commands.

- A countdown timer is ticking.
- Use `timeout` to run a command safely and `watch` to monitor the clock.

</div>

---

### DEFUSE THE TIME BOMB!

<ol class="tasks">
  <li>Run <code>countdown.sh</code> with a <code>timeout</code> of <strong>5 seconds</strong>. <code>timeout 5 ./countdown.sh</code></li>
  <li>The script writes partial output to <code>progress.log</code> as it runs.</li>
  <li>After the timeout, read <code>progress.log</code> to find the password fragment. <code>cat progress.log</code></li>
  <li>The last non-empty line of <code>progress.log</code> contains <code>BOMB_CODE=<value></code>.</li>
  <li>Extract the value - it <strong>is</strong> the password.</li>
</ol>

---

### Key Commands

| Command                   | Purpose                                    |
| ------------------------- | ------------------------------------------ |
| `timeout N cmd`           | Kill cmd if it runs longer than N seconds  |
| `timeout -s SIGNAL N cmd` | Use specific signal to kill                |
| `watch -n N cmd`          | Run cmd every N seconds and display output |
| `watch -d cmd`            | Highlight differences between runs         |
| `sleep N`                 | Wait N seconds                             |

### How `timeout` and `watch` Work

```bash
# timeout - run a command with a time limit
timeout 10 sleep 100                    # sleep for 100s but kill after 10s
timeout 5 ./long_script.sh             # kill script after 5 seconds
timeout --preserve-status 5 cmd       # preserve cmd's exit code

# Check if timeout occurred (exit code 124 = timed out)
timeout 5 ./script.sh
if [ $? -eq 124 ]; then
    echo "Script timed out"
fi

# Use a different signal (default is SIGTERM)
timeout -s SIGKILL 5 ./stubborn.sh    # use SIGKILL instead of SIGTERM

# watch - run a command repeatedly and display output
watch ls                               # run 'ls' every 2 seconds (default)
watch -n 1 'date; ls -la'            # every 1 second
watch -d 'cat /proc/meminfo'          # highlight changes between runs
watch -t -n 5 'ps aux | head'         # no title bar, every 5 seconds

# Practical uses
watch -n 1 'tail -5 access.log'       # live tail of a log
watch -n 2 'df -h'                    # monitor disk space
watch -n 1 'ls -lt | head'            # watch for new files

# sleep - pause execution
sleep 1                                # 1 second
sleep 0.5                              # 500 milliseconds
sleep 1m                               # 1 minute
sleep 2h                               # 2 hours

# Combine with other tools
( sleep 3; echo "done" ) &            # background timer
timeout 10 bash -c 'while true; do echo tick; sleep 1; done'
```


<div class="hints" markdown="1">

> `timeout 5 ./countdown.sh` will kill the script after 5 seconds, but `progress.log` already has data.

> `grep "BOMB_CODE" progress.log | tail -1 | cut -d'=' -f2` extracts the value.

</div>
---

!!! info "🔓 Unlock Room 39"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_39/README -out ../room_39/README.txt -pass pass:PASSWORD
    cat ../room_39/README.txt
    ```
