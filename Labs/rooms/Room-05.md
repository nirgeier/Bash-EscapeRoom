---
title: "(Room 05) 💍 The Decoder Ring"
password: "sedmaster"
title_prefix: "💍 "
summary: "Chain base64, tr (ROT13), and rev to decode a triple-encoded message."
---

[![Room-05](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-05.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-05.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 05</span>
  <div class="room-title">
    <span class="room-title-accent">💍 The</span>
    <span class="room-title-main">Decoder Ring</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Chain base64, tr (ROT13), and rev to decode a triple-encoded message.

- A message was encoded with **3 layers** of transformation.
- Peel them off in reverse order using pipes.

</div>

---

### DECODE THE TRIPLE-ENCODED MESSAGE!

<ol class="tasks">
  <li>Characters were <strong>reversed</strong> (<code>rev</code>)</li>
  <li><strong>ROT13</strong> was applied (each letter shifted 13 positions)</li>
  <li>Result was <strong>Base64-encoded</strong> To decode, undo the layers in <strong>reverse order</strong>:</li>
  <li>Decode Base64 → <code>base64 -d</code></li>
  <li>Undo ROT13 → <code>tr 'a-zA-Z' 'n-za-mN-ZA-M'</code></li>
  <li>Reverse characters → <code>rev</code></li>
  <li>Chain all three with pipes in one command.</li>
  <li>The decoded output <strong>is</strong> the password.</li>
</ol>

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


<div class="hints" markdown="1">

> ROT13 is its own inverse -applying it twice gets you back to the original.

> The decoded output IS the password -one single word.

</div>
---

!!! info "🔓 Unlock Room 06"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_06/README -out ../room_06/README.txt -pass pass:PASSWORD
    cat ../room_06/README
    ```
