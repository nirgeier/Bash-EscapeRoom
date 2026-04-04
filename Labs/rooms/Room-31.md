---
title: "(Room 31) 🎭 The Decision Chamber"
password: "branch3"
title_prefix: "🎭 "
summary: "Use case statements to route inputs through a pattern-matching decision engine."
---

[![Room-31](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-31.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-31.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 31</span>
  <div class="room-title">
    <span class="room-title-accent">🎭 The</span>
    <span class="room-title-main">Decision Chamber</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Use case statements to route inputs through a pattern-matching decision engine.

- The chamber has five doors, each labeled with a symbol.
- Only the `case` statement can correctly route each symbol to the right door.

</div>

---

### CHOOSE YOUR DESTINY!

<ol class="tasks">
  <li>Write a script or one-liner using a <code>case</code> statement to categorize each symbol.</li>
  <li>Count how many lines contain <code>$</code> (the dollar sign). loop + case, or simply <code>grep -c '\$' symbols.txt</code></li>
  <li>The password is <code>matched</code> followed by that count *(no space)*. Example: if 7 lines contain <code>$</code> → <code>matched7</code></li>
</ol>

---

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

    Once you solve the puzzle, run:

    ```bash
    next <PASSWORD>
    ```
