---
password: "deadbeef"
title_prefix: "📚 "
summary: "Use the strings command to extract readable text from a compiled binary."
---

[![Room-21](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-21.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-21.yml)


**RAID THE BINARY LIBRARY!**

---

## 📚 The Binary Library

- A compiled program contains a hidden password in its binary data.
- The `strings` command can extract human-readable text from any binary file.

---

!!! abstract "📜 Mission Briefing"

    The file `vault_binary` is a compiled program that contains the password somewhere in its data.

    1. Run `strings` on the binary to extract all readable text.
       > hint: `strings vault_binary`
    2. The output will contain many strings - filter for lines that look like a password.
       > hint: `strings vault_binary | grep "pass"`
    3. The password line follows the format `PASSWORD=<value>`.
    4. Extract just the value after `=`.
       > hint: pipe to `cut -d'=' -f2`

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

### Hints

!!! tip "Hint 1"

    `strings vault_binary | grep "PASSWORD"` will narrow down the results.

!!! tip "Hint 2"

    `cut -d'=' -f2` extracts everything after the `=` sign.

---

!!! info "🔓 Unlock Room 22"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_22/README -out ../room_22/README.txt -pass pass:PASSWORD
    cat ../room_22/README.txt
    ```
