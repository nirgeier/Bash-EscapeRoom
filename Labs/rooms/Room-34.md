---
password: "optparse"
title_prefix: "📜 "
summary: "Use here-documents to write a multi-line config and run embedded commands."
---

[![Room-34](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-34.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-34.yml)


**INSCRIBE THE ANCIENT SCROLL!**

---

## 📜 The Ancient Scroll

- The vault door requires a precisely formatted configuration scroll.
- Use a here-document to write it without creating temp files.

---

!!! abstract "📜 Mission Briefing"

    You must write a configuration block and pipe it directly to a verifier script.

    1. Use a heredoc to pass multi-line input to `./verify_config.sh`:
       ```bash
       ./verify_config.sh << 'EOF'
       MODE=escape
       LEVEL=master
       KEY=ancient
       EOF
       ```
    2. The script checks the values and outputs the password if all fields are correct.
    3. The output of that command **is** the password.

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

### Hints

!!! tip "Hint 1"

    Use `<< 'EOF'` (quoted marker) to prevent variable expansion inside the heredoc.

!!! tip "Hint 2"

    The heredoc content ends when the marker (`EOF`) appears alone on a line.

---

!!! info "🔓 Unlock Room 35"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_35/README -out ../room_35/README.txt -pass pass:PASSWORD
    cat ../room_35/README.txt
    ```
