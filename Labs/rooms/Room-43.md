---
title: "(Room 43) 🔭 The System Call Observatory"
password: "openfd"
title_prefix: "🔭 "
summary: "Use strace to trace system calls and discover what a mystery program is doing."
---

[![Room-43](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-43.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-43.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 43</span>
  <div class="room-title">
    <span class="room-title-accent">🔭 The</span>
    <span class="room-title-main">System Call Observatory</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Use strace to trace system calls and discover what a mystery program is doing.

- A mystery program is doing something secret.
- Use `strace` to observe its every system call and intercept the secret.

</div>

---

### OBSERVE THE SYSTEM CALLS!

<ol class="tasks">
  <li>Run <code>mystery_program</code> under <code>strace</code> and capture the output. <code>strace ./mystery_program 2>&1</code></li>
  <li>Search the strace output for <code>write</code> system calls to find the password. <code>strace ./mystery_program 2>&1 | grep 'write'</code></li>
  <li>The content of the write call contains the password.</li>
  <li>Alternatively, just run <code>./mystery_program</code> and check the output file it creates.</li>
</ol>

---

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


<div class="hints" markdown="1">

> `strace -e trace=write ./mystery_program 2>&1` shows only write system calls.

> Look for `write(1, "...", N)` or `write(fd, "PASSWORD", N)` in the output.

</div>
---

!!! info "🔓 Unlock Room 44"

    Once you solve the puzzle, run:

    ```bash
    next <PASSWORD>
    ```
