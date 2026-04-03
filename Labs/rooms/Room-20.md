---
title: "(Room 20) 🔢 The Hex Dungeon"
password: "hash256"
title_prefix: "🔢 "
summary: "Decode a hex dump using xxd to reveal the hidden message."
---

[![Room-20](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-20.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-20.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 20</span>
  <div class="room-title">
    <span class="room-title-accent">🔢 The</span>
    <span class="room-title-main">Hex Dungeon</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Decode a hex dump using xxd to reveal the hidden message.

- An ancient computer left a message encoded in hexadecimal.
- Reverse the hex dump to read the original text.

</div>

---

### DECODE THE HEX DUNGEON!

<ol class="tasks">
  <li>View the hex dump file. <code>cat hex_message.hex</code></li>
  <li>Reverse the hex dump back to its original text. <code>xxd -r hex_message.hex</code></li>
  <li>The decoded text <strong>is</strong> the password.</li>
</ol>

---

### Key Commands

| Command | Purpose |
| ------- | ------- |
| `xxd file` | Create a hex dump of a file |
| `xxd -r file` | Reverse a hex dump back to binary/text |
| `od -c file` | Octal dump with character representation |
| `od -x file` | Octal dump in hex format |
| `hexdump -C file` | Canonical hex+ASCII dump |

### How `xxd` Works

```bash
# Create hex dumps
xxd file.txt                            # hex dump (16 bytes per line)
xxd -l 32 file.txt                      # dump only first 32 bytes
xxd -s 16 file.txt                      # skip first 16 bytes, then dump
xxd -c 8 file.txt                       # 8 bytes per line (default: 16)
xxd -p file.txt                         # plain hex (no offsets/ASCII)
xxd -b file.txt                         # binary dump (bits) instead of hex

# Reverse a hex dump
xxd -r hexdump.hex > original.bin       # restore binary file from hex dump
xxd -r -p plain_hex.txt > original.bin # restore from plain hex

# Useful for inspecting binary files
xxd /bin/ls | head -5                   # peek at binary file structure
file unknown.bin                        # identify file type before dumping

# od - alternative dump tool
od -c file.txt                          # character representation
od -x file.txt                          # hex format
od -An -tx1 file.txt                    # hex bytes, no address prefix
od -An -tu1 file.txt                    # unsigned decimal bytes

# hexdump
hexdump -C file.txt                     # canonical: offset | hex | ASCII
hexdump -e '"%08.8_ax  " 16/1 "%02x " "\n"' file.txt  # custom format
```


<div class="hints" markdown="1">

> `xxd -r hex_message.hex` converts the hex dump back to the original text.

> If the output has binary noise, redirect to a file and use `cat` or `strings` on it.

</div>
---

!!! info "🔓 Unlock Room 21"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_21/README -out ../room_21/README.txt -pass pass:PASSWORD
    cat ../room_21/README.txt
    ```
