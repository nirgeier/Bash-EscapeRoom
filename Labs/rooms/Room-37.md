---
title: "(Room 37) 🚪 The Interactive Gateway"
password: "sigcatch"
title_prefix: "🚪 "
summary: "Use the read command to interactively respond to a prompt-driven challenge."
---

[![Room-37](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-37.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-37.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 37</span>
  <div class="room-title">
    <span class="room-title-accent">🚪 The</span>
    <span class="room-title-main">Interactive Gateway</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Use the read command to interactively respond to a prompt-driven challenge.

- A guardian blocks the gate and asks you a series of questions.
- Answer correctly using a script with `read` to pass the challenge.

</div>

---

### ANSWER THE GUARDIAN!

<ol class="tasks">
  <li>Run <code>guardian.sh</code> interactively and answer the questions. <code>bash guardian.sh</code></li>
  <li>Alternatively, pipe all answers at once. <code>printf "answer1
answer2
answer3
" | bash guardian.sh</code></li>
  <li>The correct answers are: <code>bash</code>, <code>escape</code>, and the current year. <code>$(date +%Y)</code> gives the current year</li>
  <li>When all answers are correct, the script prints the password.</li>
</ol>

---

### Key Commands

| Syntax | Purpose |
| ------ | ------- |
| `read var` | Read one line from stdin into var |
| `read -p "prompt" var` | Read with a prompt message |
| `read -s var` | Read silently (no echo, for passwords) |
| `read -t 5 var` | Read with 5-second timeout |
| `read -n 1 var` | Read exactly 1 character |
| `IFS= read -r line` | Read preserving whitespace/backslashes |

### How `read` Works

```bash
# Basic read
read name                               # wait for input, store in $name
echo "Hello, $name"

# Read with prompt
read -p "Enter your name: " name       # prompt on same line
read -p "Password: " -s pass           # silent (hide input)

# Read with timeout
read -t 10 -p "Quick! Enter code: " code
if [ $? -ne 0 ]; then
    echo "Timed out!"
fi

# Read single character
read -n 1 -p "Press any key..." key
echo ""    # newline after single-char read

# Read multiple variables (splits on IFS)
read first last <<< "John Doe"         # first=John last=Doe
read -r line < file.txt                # read first line of a file

# Interactive script pattern
ask_question() {
    local prompt="$1"
    local expected="$2"
    read -p "$prompt: " answer
    if [[ "$answer" == "$expected" ]]; then
        echo "Correct!"
        return 0
    else
        echo "Wrong!"
        return 1
    fi
}

# Piping answers to an interactive script
printf "answer1\nanswer2\nanswer3\n" | ./interactive_script.sh

# Read all lines from stdin
while IFS= read -r line; do
    echo "Got: $line"
done
```


<div class="hints" markdown="1">

> `printf "bash\nescape\n$(date +%Y)\n" | bash guardian.sh` pipes all answers at once.

> For interactive mode, just run `bash guardian.sh` and type each answer when prompted.

</div>
---

!!! info "🔓 Unlock Room 38"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_38/README -out ../room_38/README.txt -pass pass:PASSWORD
    cat ../room_38/README.txt
    ```
