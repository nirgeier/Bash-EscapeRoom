---
password: "nested42"
title_prefix: "📡 "
summary: "Use trap to catch signals and ensure cleanup tasks always run."
---

[![Room-36](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-36.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-36.yml)


**CATCH THE SIGNAL!**

---

## 📡 The Signal Tower

- A process sends signals that must be caught and handled.
- Set up signal traps to intercept the correct signal and extract the password.

---

!!! abstract "📜 Mission Briefing"

    The script `signal_sender.sh` sends a `SIGUSR1` signal to a process you start.

    1. Write a script that sets a `trap` for `SIGUSR1` that writes `caught` to a file.
    2. Run the script in the background.
    3. Run `./signal_sender.sh <PID>` with your script's PID.
    4. Check the file your trap wrote to - it contains the password.
       > hint: your trap handler should: `echo "sigcatch" > trap_result.txt`

### Key Commands

| Syntax              | Purpose                         |
| ------------------- | ------------------------------- |
| `trap 'cmd' SIGNAL` | Run cmd when signal is received |
| `trap 'cmd' EXIT`   | Run cmd on script exit (always) |
| `trap '' SIGINT`    | Ignore a signal                 |
| `trap - SIGNAL`     | Reset signal to default handler |
| `kill -SIGUSR1 PID` | Send SIGUSR1 to a process       |

### How `trap` Works

```bash
# Trap a signal
trap 'echo "Caught SIGINT!"' SIGINT     # catch Ctrl+C
trap 'echo "Caught TERM"' SIGTERM       # catch kill

# Cleanup on exit (always runs, even on error)
cleanup() {
    echo "Cleaning up..."
    rm -f /tmp/myapp.lock
}
trap cleanup EXIT

# Trap multiple signals with same handler
trap 'echo "Signal received"' SIGINT SIGTERM SIGHUP

# Ignore a signal
trap '' SIGINT                          # Ctrl+C does nothing

# Reset to default behavior
trap - SIGINT                           # restore default Ctrl+C behavior

# Trap with function
handle_usr1() {
    echo "Got SIGUSR1 at $(date)" >> events.log
}
trap handle_usr1 SIGUSR1

# Send signals to processes
kill -SIGTERM 1234                      # graceful stop
kill -SIGKILL 1234                      # force stop
kill -SIGUSR1 1234                      # user-defined signal 1
kill -SIGUSR2 1234                      # user-defined signal 2
kill -l                                 # list all signal names

# Example: wait for signal
trap 'echo "done" > result.txt; exit 0' SIGUSR1
echo "My PID is $$"
while true; do sleep 1; done           # wait for signal
```

### Hints

!!! tip "Hint 1"

    Use `$$` to get your script's own PID and pass it to the signal sender.

!!! tip "Hint 2"

    `trap 'handler' SIGUSR1` sets up the handler before entering the wait loop.

---

!!! info "🔓 Unlock Room 37"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_37/README -out ../room_37/README.txt -pass pass:PASSWORD
    cat ../room_37/README.txt
    ```
