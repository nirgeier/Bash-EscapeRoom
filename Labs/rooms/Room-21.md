---
title: "(Room 21) 📚 The Binary Library"
password: "deadbeef"
title_prefix: "📚 "
summary: "Use the strings command to extract readable text from a compiled binary."
---

[![Room-21](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-21.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-21.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 21</span>
  <div class="room-title">
    <span class="room-title-accent">📚 The</span>
    <span class="room-title-main">Binary Library</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Use the strings command to extract readable text from a compiled binary.

- A compiled program contains a hidden password in its binary data.
- The `strings` command can extract human-readable text from any binary file.

</div>

---

### RAID THE BINARY LIBRARY!

<ol class="tasks">
  <li>Run <code>strings</code> on the binary to extract all readable text. <code>strings vault_binary</code></li>
  <li>The output will contain many strings - filter for lines that look like a password. <code>strings vault_binary | grep "pass"</code></li>
  <li>The password line follows the format <code>PASSWORD=<value></code>.</li>
  <li>Extract just the value after <code>=</code>. pipe to <code>cut -d'=' -f2</code></li>
</ol>

---

### Key Commands

| Command             | Purpose                                      |
| ------------------- | -------------------------------------------- |
| `strings file`      | Extract printable strings from a binary file |
| `strings -n 8 file` | Only strings of minimum length 8             |
| `nm binary`         | List symbols in a binary (compiled names)    |
| `objdump -s file`   | Full binary disassembly                      |

### How `strings` Works

```bash
# Basic usage
strings binary_file                     # extract all printable strings (default min 4 chars)
strings -n 8 binary_file               # only strings of 8+ characters
strings -a binary_file                 # scan all sections (not just initialized data)
strings -t x binary_file               # show offset in hex before each string
strings -t d binary_file               # show offset in decimal

# Combine with filtering
strings binary | grep -i "password"    # look for password-related strings
strings binary | grep -E "^[a-z]+[0-9]+$"  # look for word+number patterns
strings binary | sort | uniq           # deduplicate strings

# Inspect other binary formats
strings /usr/bin/ls | head -20         # strings from a system binary
strings library.so | grep "version"   # version strings from a .so file
strings core_dump | grep "error"      # error messages from a core dump

# Alternative: hexdump for raw inspection
xxd binary | grep "pass"              # search hex dump for "pass" in ASCII
```


<div class="hints" markdown="1">

> `strings vault_binary | grep "PASSWORD"` will narrow down the results.

> `cut -d'=' -f2` extracts everything after the `=` sign.

</div>
---

!!! info "🔓 Unlock Room 22"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_22/README -out ../room_22/README.txt -pass pass:PASSWORD
    cat ../room_22/README.txt
    ```
