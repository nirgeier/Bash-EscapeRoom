---
title: "(Room 26) 🧩 The Variable Vault"
password: "teeoff"
title_prefix: "🧩 "
summary: "Master bash parameter expansion to extract and transform variable values."
---

[![Room-26](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-26.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-26.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 26</span>
  <div class="room-title">
    <span class="room-title-accent">🧩 The</span>
    <span class="room-title-main">Variable Vault</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Master bash parameter expansion to extract and transform variable values.

- The combination to the vault is hidden inside shell variable values.
- Use Bash parameter expansion to extract and transform the pieces.

</div>

---

### EXPAND THE VARIABLES!

<ol class="tasks">
  <li>Source the file to load the variables. <code>source vault_env.sh</code></li>
  <li>The variable <code>TREASURE_PATH</code> contains something like <code>/deep/in/the/vault/jewel</code>. Extract just the <strong>filename</strong> part (after the last <code>/</code>). <code>${TREASURE_PATH##*/}</code></li>
  <li>The variable <code>GEMCODE</code> contains something like <code>gem-SECRETWORD-2024</code>. Extract the <strong>middle part</strong> between the two dashes. Use <code>${GEMCODE#*-}</code> then <code>${result%-*}</code></li>
  <li>Combine the extracted filename and middle part (separated by a <code>-</code>) - that <strong>is</strong> the password.</li>
</ol>

---

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


<div class="hints" markdown="1">

> `${TREASURE_PATH##*/}` removes everything up to and including the last `/`.

> To extract the middle of `gem-WORD-2024`: first do `${GEMCODE#*-}` to get `WORD-2024`, then `${result%-*}` to get `WORD`.

</div>
---

!!! info "🔓 Unlock Room 27"

    Once you solve the puzzle, run:

    ```bash
    next <PASSWORD>
    ```
