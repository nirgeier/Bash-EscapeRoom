---
title: "(Room 31) 🎭 The Decision Chamber"
password: "branch3"
title_prefix: "🎭 "
summary: "Use case statements to route inputs through a pattern-matching decision engine."
---

<div class="room-hero">
  <span class="room-badge">ROOM 31</span>
  <div class="room-title">
    <span class="room-title-accent">🎭 The</span>
    <span class="room-title-main">Decision Chamber</span>
  </div>
</div>

[![Room-31](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-31.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-31.yml)


**CHOOSE YOUR DESTINY!**

---


- The chamber has five doors, each labeled with a symbol.
- Only the `case` statement can correctly route each symbol to the right door.

---

<div class="tasks" markdown="1">

The file `symbols.txt` contains 20 lines, each with a single symbol: `@`, `#`, `$`, `%`, or `&`.

1. Write a script or one-liner using a `case` statement to categorize each symbol.
2. Count how many lines contain `$` (the dollar sign).
   > loop + case, or simply `grep -c '\$' symbols.txt`
3. The password is `matched` followed by that count *(no space)*.
   > Example: if 7 lines contain `$` → `matched7`

</div>

### Key Commands

| Syntax | Purpose |
| ------ | ------- |
| `case $var in pattern) ... ;; esac` | Pattern-matching switch |
| `*)` | Default/catch-all case |
| `pattern1\|pattern2)` | Match multiple patterns |

### How `case` Statements Work

```bash
# Basic case statement
case $fruit in
    apple)
        echo "It's an apple"
        ;;
    banana|mango)
        echo "It's tropical"
        ;;
    *)
        echo "Unknown fruit"
        ;;
esac

# Case with variable input
read -p "Enter a letter: " letter
case $letter in
    [a-z])  echo "lowercase letter" ;;
    [A-Z])  echo "uppercase letter" ;;
    [0-9])  echo "a digit" ;;
    *)      echo "special character" ;;
esac

# Case inside a loop
count=0
while IFS= read -r line; do
    case $line in
        \$)  (( count++ )) ;;
        \#)  echo "comment symbol" ;;
        *)   echo "other: $line" ;;
    esac
done < symbols.txt
echo "Dollar count: $count"

# Case with pattern matching
filename="report.pdf"
case $filename in
    *.pdf)   echo "PDF document" ;;
    *.txt)   echo "Text file" ;;
    *.sh)    echo "Shell script" ;;
    *.tar.*)  echo "Archive" ;;
esac
```


<div class="hints" markdown="1">

> In a `case` pattern, `$` must be escaped as `\$` to avoid variable expansion.

> You can also just use `grep -c '\$' symbols.txt` directly without a case statement.

</div>
---

!!! info "🔓 Unlock Room 32"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_32/README -out ../room_32/README.txt -pass pass:PASSWORD
    cat ../room_32/README.txt
    ```
