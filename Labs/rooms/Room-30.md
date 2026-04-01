---
password: "while100"
title_prefix: "🍃 "
summary: "Use if/else conditions and test operators to navigate a decision tree."
---

[![Room-30](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-30.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-30.yml)


**CHOOSE YOUR PATH!**

---

## 🍃 The Fork in the Road

- A decision tree guards the exit.
- Evaluate conditions correctly to follow the right path.

---

!!! abstract "📜 Mission Briefing"

    The script `decision_tree.sh` contains a series of conditions that must be satisfied.
    Read it, understand the logic, and run it with the right arguments.

    1. Read `decision_tree.sh` to understand the conditions.
       > hint: `cat decision_tree.sh`
    2. The script expects two arguments: a number and a string.
    3. Find the number and string that satisfy ALL the if/else branches to reach `echo $PASSWORD`.
    4. Run: `bash decision_tree.sh <number> <string>`
    5. The output **is** the password.

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

### Hints

!!! tip "Hint 1"

    Trace through each `if/elif/else` branch carefully to find which values satisfy all conditions.

!!! tip "Hint 2"

    The conditions narrow down exact values - process of elimination works here.

---

!!! info "🔓 Unlock Room 31"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_31/README -out ../room_31/README.txt -pass pass:PASSWORD
    cat ../room_31/README.txt
    ```
