---
password: "funcret"
title_prefix: "🎛️ "
summary: "Use getopts to parse command-line arguments and unlock a protected script."
---

**CRACK THE ARGUMENT DECODER!**

---

## 🎛️ The Argument Decoder

- A protected script only responds to the correct combination of flags.
- Use `getopts` to build a command that passes all validations.

---

!!! abstract "📜 Mission Briefing"

    The script `locked_program.sh` uses `getopts` to validate its arguments.
    Study it, then call it with the right flags to unlock the password.

    1. Read `locked_program.sh` to understand what flags it expects.
       > hint: `cat locked_program.sh`
    2. The script expects flags `-u <username>` `-p <pin>` and optionally `-v` (verbose).
    3. Call it with `-u agent -p 1337 -v`.
    4. The output when all conditions pass **is** the password.

### Key Commands

| Syntax                  | Purpose                             |
| ----------------------- | ----------------------------------- |
| `getopts "abc:" opt`    | Parse flags; `:` means arg required |
| `$OPTARG`               | Value of the option argument        |
| `$OPTIND`               | Index of next arg to be processed   |
| `shift $(( OPTIND-1 ))` | Move past parsed options            |

### How `getopts` Works

```bash
# Basic getopts loop
while getopts "abc:" opt; do
    case $opt in
        a) echo "Flag -a was set" ;;
        b) echo "Flag -b was set" ;;
        c) echo "Flag -c with value: $OPTARG" ;;
        ?) echo "Unknown option: $opt" ; exit 1 ;;
    esac
done

# Script with named options
#!/bin/bash
verbose=false
username=""
port=8080

while getopts "u:p:vh" opt; do
    case $opt in
        u) username="$OPTARG" ;;
        p) port="$OPTARG" ;;
        v) verbose=true ;;
        h) echo "Usage: $0 -u user -p port [-v]"; exit 0 ;;
        ?) echo "Invalid option"; exit 1 ;;
    esac
done

# Shift past parsed options to get positional args
shift $(( OPTIND - 1 ))
remaining_args="$@"

# Validate
[ -z "$username" ] && { echo "Username required"; exit 1; }

if $verbose; then
    echo "Connecting to $username on port $port"
fi

# Calling the script
./script.sh -u alice -p 9090 -v
./script.sh -u bob -p 22           # no verbose flag
```

### Hints

!!! tip "Hint 1"

    `getopts "u:p:v"` - the `:` after `u` and `p` means those flags take arguments.

!!! tip "Hint 2"

    Run `bash locked_program.sh -u agent -p 1337 -v` and read the output.

---

!!! info "🔓 Unlock Room 34"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_34/README -out ../room_34/README.txt -pass pass:PASSWORD
    cat ../room_34/README.txt
    ```
