---
title: "(Room 30) 🍃 The Fork in the Road"
password: "while100"
title_prefix: "🍃 "
summary: "Use if/else conditions and test operators to navigate a decision tree."
---

[![Room-30](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-30.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-30.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 30</span>
  <div class="room-title">
    <span class="room-title-accent">🍃 The</span>
    <span class="room-title-main">Fork in the Road</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Use if/else conditions and test operators to navigate a decision tree.

- A decision tree guards the exit.
- Evaluate conditions correctly to follow the right path.

</div>

---

### CHOOSE YOUR PATH!

<ol class="tasks">
  <li>Read <code>decision_tree.sh</code> to understand the conditions. <code>cat decision_tree.sh</code></li>
  <li>The script expects two arguments: a number and a string.</li>
  <li>Find the number and string that satisfy ALL the if/else branches to reach <code>echo $PASSWORD</code>.</li>
  <li>Run: <code>bash decision_tree.sh <number> <string></code></li>
  <li>The output <strong>is</strong> the password.</li>
</ol>

---

### Key Commands

| Syntax                     | Purpose                           |
| -------------------------- | --------------------------------- |
| `if [ condition ]; then`   | Basic if statement                |
| `elif [ condition ]; then` | Else-if branch                    |
| `else`                     | Default branch                    |
| `[[ str == pattern ]]`     | String comparison (bash)          |
| `-eq -ne -lt -gt -le -ge`  | Numeric comparisons               |
| `-z -n`                    | Test if string is empty/non-empty |
| `-f -d -e`                 | Test if file/dir/path exists      |

### How `if` Statements Work

```bash
# Basic if/else
if [ $x -gt 0 ]; then
    echo "positive"
elif [ $x -lt 0 ]; then
    echo "negative"
else
    echo "zero"
fi

# Numeric comparisons
[ $a -eq $b ]   # equal
[ $a -ne $b ]   # not equal
[ $a -lt $b ]   # less than
[ $a -gt $b ]   # greater than
[ $a -le $b ]   # less than or equal
[ $a -ge $b ]   # greater than or equal

# String comparisons (use [[ ]])
[[ "$str" == "hello" ]]               # exact match
[[ "$str" != "hello" ]]               # not equal
[[ "$str" == *"ell"* ]]               # wildcard: contains "ell"
[[ "$str" =~ ^[0-9]+$ ]]              # regex match: all digits
[[ -z "$str" ]]                       # true if string is empty
[[ -n "$str" ]]                       # true if string is non-empty

# File tests
[ -f file.txt ]                       # true if regular file exists
[ -d dir/ ]                           # true if directory exists
[ -e path ]                           # true if path exists (any type)
[ -r file ]                           # true if file is readable
[ -x file ]                           # true if file is executable
[ -s file ]                           # true if file is non-empty

# Combining conditions
if [ $x -gt 0 ] && [ $x -lt 100 ]; then   # AND
if [ $x -eq 0 ] || [ $x -eq 1 ]; then     # OR
if [[ $x -gt 0 && $x -lt 100 ]]; then     # AND in double brackets
```


<div class="hints" markdown="1">

> Trace through each `if/elif/else` branch carefully to find which values satisfy all conditions.

> The conditions narrow down exact values - process of elimination works here.

</div>
---

!!! info "🔓 Unlock Room 31"

    Once you solve the puzzle, run:

    ```bash
    next <PASSWORD>
    ```
