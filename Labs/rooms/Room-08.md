---
password: "access42"
title_prefix: "🧪 "
summary: "Configure environment variables, aliases, and source config files."
---

**CONFIGURE THE ENVIRONMENT!**

---

## 🧪 The Environment Lab

Your shell environment must be configured precisely to unlock the lab door.

!!! abstract "📜 Mission Briefing"

    Configure your shell environment precisely to unlock the lab door.

    1. Find the hidden configuration file in this room.
       > hint: hidden files start with `.` -use `ls -a`
    2. Source the hidden config file to load its settings.
       > hint: `source .filename` or `. .filename`
    3. The config tells you what environment variables to set. Set them with `export`.
    4. Create an alias named `labstatus` that prints `ready`.
       > hint: `alias labstatus='echo ready'`
    5. Once everything is set, run `./getKey.sh` to verify and get the password.

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

### Hints

!!! tip "Hint 1"

    Hidden files start with a dot (`.`) -use `ls -a` to find them.

!!! tip "Hint 2"

    Source the hidden config file first -it tells you what to set.

!!! tip "Hint 3"

    All commands (`export`, `alias`) must be run in the same shell session.

---

!!! info "🔓 Unlock Room 09"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_09/README -out ../room_09/README.txt -pass pass:PASSWORD
    cat ../room_09/README
    ```
