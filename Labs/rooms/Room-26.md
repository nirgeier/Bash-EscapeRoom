---
password: "teeoff"
title_prefix: "🧩 "
summary: "Master bash parameter expansion to extract and transform variable values."
---

[![Room-26](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-26.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-26.yml)


**EXPAND THE VARIABLES!**

---

## 🧩 The Variable Vault

- The combination to the vault is hidden inside shell variable values.
- Use Bash parameter expansion to extract and transform the pieces.

---

!!! abstract "📜 Mission Briefing"

    The file `vault_env.sh` sets several environment variables. Source it and then use parameter expansion.

    1. Source the file to load the variables.
       > hint: `source vault_env.sh`
    2. The variable `TREASURE_PATH` contains something like `/deep/in/the/vault/jewel`.
       Extract just the **filename** part (after the last `/`).
       > hint: `${TREASURE_PATH##*/}`
    3. The variable `GEMCODE` contains something like `gem-SECRETWORD-2024`.
       Extract the **middle part** between the two dashes.
       > hint: Use `${GEMCODE#*-}` then `${result%-*}`
    4. Combine the extracted filename and middle part (separated by a `-`) - that **is** the password.

### Key Commands

| Syntax            | Purpose                                 |
| ----------------- | --------------------------------------- |
| `${var}`          | Basic variable expansion                |
| `${var:-default}` | Use default if var is unset             |
| `${var#pattern}`  | Remove shortest prefix matching pattern |
| `${var##pattern}` | Remove longest prefix matching pattern  |
| `${var%pattern}`  | Remove shortest suffix matching pattern |
| `${var%%pattern}` | Remove longest suffix matching pattern  |
| `${var/old/new}`  | Replace first match                     |
| `${var//old/new}` | Replace all matches                     |
| `${#var}`         | Length of variable                      |

### How Parameter Expansion Works

```bash
# Basic access
name="Alice"
echo ${name}                            # Alice
echo ${name:-Unknown}                   # Alice (use default only if unset)

unset name
echo ${name:-Unknown}                   # Unknown (var is unset, use default)
echo ${name:=Default}                   # Default AND sets name=Default

# Substring removal (pattern matching)
path="/home/user/docs/file.txt"
echo ${path##*/}                        # file.txt  (remove longest */ prefix)
echo ${path#*/}                         # home/user/docs/file.txt (remove shortest)
echo ${path%/*}                         # /home/user/docs  (remove shortest suffix)
echo ${path%%/*}                        # (empty - longest /* suffix)
echo ${path%.txt}                       # /home/user/docs/file (remove .txt suffix)

# String replacement
str="hello world hello"
echo ${str/hello/bye}                   # bye world hello (first match)
echo ${str//hello/bye}                  # bye world bye (all matches)
echo ${str/#hello/Hi}                   # Hi world hello (anchor to start)
echo ${str/%hello/end}                  # hello world end (anchor to end)

# Case conversion (Bash 4+)
text="Hello World"
echo ${text,,}                          # hello world (all lowercase)
echo ${text^^}                          # HELLO WORLD (all uppercase)
echo ${text,}                           # hELLO WORLD (first char lowercase)
echo ${text^}                           # Hello World (first char uppercase)

# Length
echo ${#text}                           # 11 (character count)

# Slice
str="Hello, World!"
echo ${str:7:5}                         # World (start at 7, length 5)
echo ${str: -6}                         # orld!  (from 6 chars from end)
```

### Hints

!!! tip "Hint 1"

    `${TREASURE_PATH##*/}` removes everything up to and including the last `/`.

!!! tip "Hint 2"

    To extract the middle of `gem-WORD-2024`: first do `${GEMCODE#*-}` to get `WORD-2024`, then `${result%-*}` to get `WORD`.

---

!!! info "🔓 Unlock Room 27"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_27/README -out ../room_27/README.txt -pass pass:PASSWORD
    cat ../room_27/README.txt
    ```
