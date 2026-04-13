---
title: "(Room 08) 🧪 The Environment Lab"
password: "access42"
title_prefix: "🧪 "
summary: "Configure environment variables, aliases, and source config files."
---

[![Room-08](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-08.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-08.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 08</span>
  <div class="room-title">
    <span class="room-title-accent">🧪 The</span>
    <span class="room-title-main">Environment Lab</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Configure environment variables, aliases, and source config files.

Your shell environment must be configured precisely to unlock the lab door.

</div>

---

### CONFIGURE THE ENVIRONMENT!

<ol class="tasks">
  <li>Find the hidden configuration file in this room. hidden files start with <code>.</code> -use <code>ls -a</code></li>
  <li>Source the hidden config file to load its settings. <code>source .filename</code> or <code>. .filename</code></li>
  <li>The config tells you what environment variables to set. Set them with <code>export</code>.</li>
  <li>Create an alias named <code>labstatus</code> that prints <code>ready</code>. <code>alias labstatus='echo ready'</code></li>
  <li>Once everything is set, run <code>source ./getKey.sh</code> to verify and get the password.</li>
</ol>

---

### Key Commands

| Command        | Purpose                                                  |
| -------------- | -------------------------------------------------------- |
| `export`       | Set an environment variable                              |
| `env`          | Display all environment variables                        |
| `source` / `.` | Execute commands from a file in the current shell        |
| `alias`        | Create a command shortcut                                |
| `ls -a`        | List all files including hidden ones (starting with `.`) |

### How Environment Variables Work

```bash
# Set and export a variable (available to child processes)
export MY_VAR=hello
export PATH="$PATH:/new/dir"      # append to existing variable

# Access and inspect variables
echo $MY_VAR                      # print one variable
echo ${MY_VAR:-default}           # print value or default if unset
env                               # list all environment variables
env | grep MY_VAR                 # search for a specific one
printenv MY_VAR                   # print a single variable

# Unset a variable
unset MY_VAR

# Source a file (run it in the current shell, not a subshell)
source config.sh                  # bash syntax
. config.sh                       # POSIX syntax (same effect)

# Aliases
alias ll='ls -la'                 # define a shortcut
alias grep='grep --color=auto'    # alias with flags
alias                             # list all defined aliases
unalias ll                        # remove an alias

# Run a command with a temporary variable (doesn't persist)
MY_VAR=hello ./script.sh
```

---


<div class="hints" markdown="1">

> Hidden files start with a dot (`.`) -use `ls -a` to find them.

> Source the hidden config file first -it tells you what to set.

> All commands (`export`, `alias`) must be run in the same shell session.

</div>
---

!!! info "🔓 Unlock Room 09"

    Once you solve the puzzle, run:

    ```bash
    next <PASSWORD>
    ```
