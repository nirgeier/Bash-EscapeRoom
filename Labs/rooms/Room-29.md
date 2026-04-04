---
title: "(Room 29) 🌀 The Endless Corridor"
password: "loop50"
title_prefix: "🌀 "
summary: "Use a while loop to read and process a file line by line."
---

[![Room-29](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-29.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-29.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 29</span>
  <div class="room-title">
    <span class="room-title-accent">🌀 The</span>
    <span class="room-title-main">Endless Corridor</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Use a while loop to read and process a file line by line.

- A long corridor has doors on both sides.
- Read the door log line by line and count how many doors were left **open**.

</div>

---

### TRAVERSE THE ENDLESS CORRIDOR!

<ol class="tasks">
  <li>Use a <code>while read</code> loop to process each line of <code>door_log.txt</code>.</li>
  <li>Count lines where the status field is <code>OPEN</code>.</li>
  <li>The password is <code>while</code> followed by the count of open doors *(no space)*. Example: if 73 doors are OPEN → <code>while73</code></li>
</ol>

---

### Key Commands

| Syntax | Purpose |
| ------ | ------- |
| `while read line; do ... done < file` | Read file line by line |
| `while IFS= read -r line; do` | Read preserving whitespace/backslashes |
| `read var1 var2 <<< "$line"` | Split a line into variables |
| `[[ "$str" == "pattern" ]]` | String comparison |

### How `while` Loops Work

```bash
# Basic while loop
count=0
while [ $count -lt 5 ]; do
    echo "count: $count"
    (( count++ ))
done

# Read a file line by line
while IFS= read -r line; do
    echo "Line: $line"
done < file.txt

# Read specific fields from each line
while read -r id status; do
    echo "ID=$id STATUS=$status"
done < data.txt

# Count matching lines
count=0
while IFS= read -r line; do
    if [[ "$line" == *"ERROR"* ]]; then
        (( count++ ))
    fi
done < logfile.txt
echo "Errors: $count"

# Read output of a command
while IFS= read -r line; do
    echo "Processing: $line"
done < <(grep "pattern" bigfile.txt)   # process substitution

# until loop (opposite of while)
x=0
until [ $x -ge 5 ]; do
    echo $x
    (( x++ ))
done

# Infinite loop with break
while true; do
    read -p "Enter value (q to quit): " val
    [[ "$val" == "q" ]] && break
    echo "You entered: $val"
done
```


<div class="hints" markdown="1">

> `while read -r id status; do` splits each line into two variables automatically.

> `[[ "$status" == "OPEN" ]]` tests for exact equality.

</div>
---

!!! info "🔓 Unlock Room 30"

    Once you solve the puzzle, run:

    ```bash
    next <PASSWORD>
    ```
