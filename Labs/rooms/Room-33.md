---
title: "(Room 33) 🎛️ The Argument Decoder"
password: "funcret"
title_prefix: "🎛️ "
summary: "Use getopts to parse command-line arguments and unlock a protected script."
---

[![Room-33](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-33.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-33.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 33</span>
  <div class="room-title">
    <span class="room-title-accent">🎛️ The</span>
    <span class="room-title-main">Argument Decoder</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Use getopts to parse command-line arguments and unlock a protected script.

- A protected script only responds to the correct combination of flags.
- Use `getopts` to build a command that passes all validations.

</div>

---

### CRACK THE ARGUMENT DECODER!

<ol class="tasks">
  <li>Read <code>locked_program.sh</code> to understand what flags it expects. <code>cat locked_program.sh</code></li>
  <li>The script expects flags <code>-u <username></code> <code>-p <pin></code> and optionally <code>-v</code> (verbose).</li>
  <li>Call it with <code>-u agent -p 1337 -v</code>.</li>
  <li>The output when all conditions pass <strong>is</strong> the password.</li>
</ol>

---

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


<div class="hints" markdown="1">

> `getopts "u:p:v"` - the `:` after `u` and `p` means those flags take arguments.

> Run `bash locked_program.sh -u agent -p 1337 -v` and read the output.

</div>
---

!!! info "🔓 Unlock Room 34"

    Once you solve the puzzle, run:

    ```bash
    next <PASSWORD>
    ```
