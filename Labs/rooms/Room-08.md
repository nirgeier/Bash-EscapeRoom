---
title: "(Room 08) 🧪 The Environment Lab"
password: "access42"
title_prefix: "🧪 "
summary: "Configure environment variables, aliases, and source config files."
---

<div class="room-hero">
  <span class="room-badge">ROOM 08</span>
  <div class="room-title">
    <span class="room-title-accent">🧪 The</span>
    <span class="room-title-main">Environment Lab</span>
  </div>
</div>

[![Room-08](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-08.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-08.yml)


**CONFIGURE THE ENVIRONMENT!**

---


Your shell environment must be configured precisely to unlock the lab door.

<div class="tasks" markdown="1">

Configure your shell environment precisely to unlock the lab door.

1. Find the hidden configuration file in this room.
   > hidden files start with `.` -use `ls -a`
2. Source the hidden config file to load its settings.
   > `source .filename` or `. .filename`
3. The config tells you what environment variables to set. Set them with `export`.
4. Create an alias named `labstatus` that prints `ready`.
   > `alias labstatus='echo ready'`
5. Once everything is set, run `./getKey.sh` to verify and get the password.

</div>

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

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_09/README -out ../room_09/README.txt -pass pass:PASSWORD
    cat ../room_09/README
    ```
