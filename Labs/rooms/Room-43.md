---
password: "openfd"
title_prefix: "🔭 "
summary: "Use strace to trace system calls and discover what a mystery program is doing."
---

[![Room-43](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-43.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-43.yml)


**OBSERVE THE SYSTEM CALLS!**

---

## 🔭 The System Call Observatory

- A mystery program is doing something secret.
- Use `strace` to observe its every system call and intercept the secret.

---

!!! abstract "📜 Mission Briefing"

    The program `mystery_program` writes the password to a file using system calls.

    1. Run `mystery_program` under `strace` and capture the output.
       > hint: `strace ./mystery_program 2>&1`
    2. Search the strace output for `write` system calls to find the password.
       > hint: `strace ./mystery_program 2>&1 | grep 'write'`
    3. The content of the write call contains the password.
    4. Alternatively, just run `./mystery_program` and check the output file it creates.

### Key Commands

| Command | Purpose |
| ------- | ------- |
| `strace cmd` | Trace system calls of a command |
| `strace -e trace=open,read,write cmd` | Trace only specific calls |
| `strace -o file.log cmd` | Write trace to a file |
| `strace -p PID` | Attach to a running process |
| `ltrace cmd` | Trace library calls |

### How `strace` Works

```bash
# Basic tracing
strace ls                               # trace all system calls of ls
strace -o trace.log ls                 # save trace to file
strace ./myprog arg1 arg2             # trace a program with arguments

# Filter specific system calls
strace -e trace=open,read,write ls    # only open, read, write calls
strace -e trace=network ls            # only network-related calls
strace -e trace=file ls               # only file-related calls
strace -e trace=process ls            # only process-related calls

# Attach to running process
strace -p 1234                         # attach to PID 1234
strace -p $(pgrep nginx)              # attach to nginx by name

# Useful options
strace -t cmd                          # add timestamps
strace -T cmd                          # show time spent in each call
strace -c cmd                          # count/statistics summary only
strace -f cmd                          # follow forks (trace child processes)
strace -s 200 cmd                      # increase string length displayed (default 32)

# Find file access
strace -e trace=openat ls 2>&1 | grep "\.txt"   # see which .txt files are opened

# Find writes
strace -e trace=write ./program 2>&1 | grep '"'  # see what's written to files

# ltrace - trace library function calls
ltrace ./program                        # show libc and other library calls
ltrace -e malloc,free ./program        # only malloc and free calls
```

### Hints

!!! tip "Hint 1"

    `strace -e trace=write ./mystery_program 2>&1` shows only write system calls.

!!! tip "Hint 2"

    Look for `write(1, "...", N)` or `write(fd, "PASSWORD", N)` in the output.

---

!!! info "🔓 Unlock Room 44"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_44/README -out ../room_44/README.txt -pass pass:PASSWORD
    cat ../room_44/README.txt
    ```
