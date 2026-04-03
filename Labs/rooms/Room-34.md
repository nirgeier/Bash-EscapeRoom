---
title: "(Room 34) 📜 The Ancient Scroll"
password: "optparse"
title_prefix: "📜 "
summary: "Use here-documents to write a multi-line config and run embedded commands."
---

[![Room-34](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-34.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-34.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 34</span>
  <div class="room-title">
    <span class="room-title-accent">📜 The</span>
    <span class="room-title-main">Ancient Scroll</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Use here-documents to write a multi-line config and run embedded commands.

- The vault door requires a precisely formatted configuration scroll.
- Use a here-document to write it without creating temp files.

</div>

---

### INSCRIBE THE ANCIENT SCROLL!

<ol class="tasks">
  <li>Use a heredoc to pass multi-line input to <code>./verify_config.sh</code>: ``<code>bash ./verify_config.sh << 'EOF' MODE=escape LEVEL=master KEY=ancient EOF </code>``</li>
  <li>The script checks the values and outputs the password if all fields are correct.</li>
  <li>The output of that command <strong>is</strong> the password.</li>
</ol>

---

### Key Commands

| Syntax | Purpose |
| ------ | ------- |
| `cmd << 'EOF' ... EOF` | Here-document: pass multi-line string |
| `cmd <<- 'EOF' ... EOF` | Here-doc ignoring leading tabs |
| `var=$(cat << 'EOF' ... EOF)` | Capture heredoc in a variable |
| `cat << EOF` | Print a heredoc (variable expansion ON) |
| `cat << 'EOF'` | Print a heredoc (no variable expansion) |

### How Here-Documents Work

```bash
# Basic heredoc (variable expansion enabled)
name="World"
cat << EOF
Hello, $name!
Today is $(date)
EOF

# Heredoc with no variable expansion (single-quoted marker)
cat << 'EOF'
Literal: $HOME is not expanded here
Neither is $(date)
EOF

# Heredoc piped to a command
grep "error" << 'EOF'
this is fine
error: something went wrong
also fine
EOF

# Heredoc as stdin to a script
./configure.sh << 'EOF'
HOST=localhost
PORT=8080
DEBUG=true
EOF

# Capture heredoc in a variable
config=$(cat << 'EOF'
key1=value1
key2=value2
EOF
)
echo "$config"

# Heredoc in a function
write_file() {
    cat << 'EOF' > "$1"
#!/bin/bash
echo "Generated script"
EOF
    chmod +x "$1"
}

# Here-string (single-line heredoc)
grep "pattern" <<< "this is a pattern string"
wc -w <<< "count these words please"
```


<div class="hints" markdown="1">

> Use `<< 'EOF'` (quoted marker) to prevent variable expansion inside the heredoc.

> The heredoc content ends when the marker (`EOF`) appears alone on a line.

</div>
---

!!! info "🔓 Unlock Room 35"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_35/README -out ../room_35/README.txt -pass pass:PASSWORD
    cat ../room_35/README.txt
    ```
