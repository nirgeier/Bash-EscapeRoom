---
password: "sedmaster"
title_prefix: "💍 "
summary: "Chain base64, tr (ROT13), and rev to decode a triple-encoded message."
---

[![Room-05](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-05.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-05.yml)


**DECODE THE TRIPLE-ENCODED MESSAGE!**

---

## 💍 The Decoder Ring

- A message was encoded with **3 layers** of transformation.
- Peel them off in reverse order using pipes.

!!! abstract "📜 Mission Briefing"

        The file `encoded_message.txt` has been encoded in **3 layers** (applied in this order):

        1. Characters were **reversed** (`rev`)
        2. **ROT13** was applied (each letter shifted 13 positions)
        3. Result was **Base64-encoded**

        To decode, undo the layers in **reverse order**:

        1. Decode Base64 → `base64 -d`
        2. Undo ROT13 → `tr 'a-zA-Z' 'n-za-mN-ZA-M'`
        3. Reverse characters → `rev`
        4. Chain all three with pipes in one command.
        5. The decoded output **is** the password.

---

### The 3 Encoding Layers (applied in order)

1. **Reversed** characters (`rev`)
2. **ROT13** applied (`tr` character shift)
3. **Base64** encoded

### Key Commands

| Command                      | Purpose                                |
| ---------------------------- | -------------------------------------- |
| `base64 -d`                  | Decode base64 encoding                 |
| `tr 'a-zA-Z' 'n-za-mN-ZA-M'` | Apply/reverse ROT13 cipher             |
| `rev`                        | Reverse characters                     |
| `\|` (pipe)                  | Send output of one command to the next |

---

### How Encoding Tools Work

```bash
# base64 - encode/decode binary-safe text
base64 file.txt                    # encode a file to stdout
base64 -d file.b64                 # decode base64 back to original
echo "hello" | base64              # encode a string
echo "aGVsbG8=" | base64 -d       # decode a string
base64 -d file.b64 > output.bin    # decode and save to file
base64 -w 0 file.txt               # encode with no line wrapping

# tr - translate or delete characters
tr 'a-z' 'A-Z' < file.txt         # lowercase to uppercase
tr 'A-Z' 'a-z' < file.txt         # uppercase to lowercase
tr -d '\n' < file.txt             # delete all newlines
tr -d '[:space:]' < file.txt      # delete all whitespace
tr -s ' ' < file.txt              # squeeze repeated spaces to one
tr '[:upper:]' '[:lower:]'        # use character class names
tr 'a-mn-z' 'n-za-m'              # ROT13 (lowercase only)
tr 'a-zA-Z' 'n-za-mN-ZA-M'       # ROT13 (full alphabet)

# rev - reverse characters on each line
echo "hello" | rev                # outputs: olleh
rev file.txt                      # reverse each line in a file
echo "racecar" | rev              # outputs: racecar (palindrome)
```

---

### Hints

!!! tip "Hint 1"

    ROT13 is its own inverse -applying it twice gets you back to the original.

!!! tip "Hint 2"

    The decoded output IS the password -one single word.

---

!!! info "🔓 Unlock Room 06"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_06/README -out ../room_06/README.txt -pass pass:PASSWORD
    cat ../room_06/README
    ```
