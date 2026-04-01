---
password: "rewind99"
title_prefix: "🕵️ "
summary: "Use sed substitutions to decode an encrypted spy message."
---

[![Room-04](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-04.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-04.yml)


**CRACK THE SPY CODE!**

---

## 🕵️ The Spy Cipher

- A spy left an encoded message.
- Certain letters were replaced with codes.
- Use `sed` to reverse the substitutions and reveal the hidden password.

---

!!! abstract "📜 Mission Briefing"

    A spy left an encoded message in `cipher.txt`. Certain letters were
    replaced with codes using this substitution table:

    | Original | Encoded |
    |----------|---------|
    | s        | Z7      |
    | e        | Q3      |
    | d        | X9      |
    | m        | K1      |
    | a        | J2      |
    | t        | W8      |
    | r        | P6      |

    1. Use `sed` to reverse **all** substitutions on `cipher.txt`.
       > hint: `sed 's/ENCODED/ORIGINAL/g; s/ENCODED2/ORIGINAL2/g' cipher.txt`
    2. Read the decoded output -the password is in the decoded text.

### Key Commands

| Command | Purpose |
| --- | --- |
| `sed 's/old/new/' file` | Replace first occurrence per line |
| `sed 's/old/new/g' file` | Replace all occurrences (global) |
| `sed 's/old/new/I' file` | Case-insensitive replace |
| `sed -n '5p' file` | Print only line 5 |
| `sed -n '5,10p' file` | Print lines 5-10 |
| `sed '5d' file` | Delete line 5 |
| `sed '/pattern/d' file` | Delete lines matching pattern |
| `sed 's/^/  /' file` | Add indent to every line |
| `sed 's/ *$//' file` | Strip trailing whitespace |
| `sed -i 's/old/new/g' file` | Edit file in-place |
| `sed -i.bak 's/old/new/g' file` | In-place edit with backup |
| `sed 'y/abc/ABC/' file` | Transliterate characters |
| `sed -n '/start/,/end/p' file` | Print between two patterns |
| `sed '1i\header' file` | Insert line before line 1 |
| `sed '$a\footer' file` | Append line after last line |
| `sed 's/\t/ /g' file` | Replace tabs with spaces |

### How `sed` Works

```bash
# Basic substitution: replace first match per line
sed 's/old/new/' file.txt

# Replace ALL matches per line (global flag)
sed 's/old/new/g' file.txt

# Multiple substitutions chained in one command
sed 's/foo/bar/g; s/baz/qux/g' file.txt

# Case-insensitive replacement
sed 's/hello/world/gi' file.txt

# Delete lines matching a pattern
sed '/pattern/d' file.txt

# Print only specific lines (use -n to suppress default output)
sed -n '5p' file.txt           # line 5 only
sed -n '1,10p' file.txt        # lines 1 through 10
sed -n '/pattern/p' file.txt   # lines matching pattern

# Use alternate delimiters (useful when value contains /)
sed 's|/usr/local|/opt|g' file.txt

# Edit file in-place
sed -i 's/old/new/g' file.txt
sed -i.bak 's/old/new/g' file.txt  # keep .bak backup
```

---

### The Substitution Table

| Original Letter | Was Replaced With |
| --------------- | ----------------- |
| s               | Z7                |
| e               | Q3                |
| d               | X9                |
| m               | K1                |
| a               | J2                |
| t               | W8                |
| r               | P6                |

---

### Hints

!!! tip "Hint"

    The decoded text contains the password in its final line.

---

!!! info "🔓 Unlock Room 05"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_05/README -out ../room_05/README.txt -pass pass:PASSWORD
    cat ../room_05/README
    ```
