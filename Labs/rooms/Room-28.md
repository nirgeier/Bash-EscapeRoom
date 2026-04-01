---
password: "array10"
title_prefix: "🔁 "
summary: "Use a for loop to process files and accumulate a result."
---

[![Room-28](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-28.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-28.yml)


**LOOP THROUGH THE LABYRINTH!**

---

## 🔁 The Loop Labyrinth

- 50 numbered chambers each contain a single digit.
- Loop through them all and sum the digits to unlock the exit.

---

!!! abstract "📜 Mission Briefing"

    The directory `chambers/` contains 50 files: `chamber_01.txt` through `chamber_50.txt`.
    Each file contains a single integer.

    1. Write a `for` loop to iterate over all chamber files.
       > hint: `for f in chambers/chamber_*.txt; do ...`
    2. Read each file's value and add it to a running total.
       > hint: `total=$(( total + $(cat "$f") ))`
    3. After the loop, print the total.
    4. The password is `loop` followed by the total *(no space)*.
       > Example: if the sum is 250 → `loop250`

### Key Commands

| Syntax | Purpose |
| ------ | ------- |
| `for x in LIST; do ... done` | Iterate over a list |
| `for (( i=0; i<N; i++ )); do` | C-style numeric for loop |
| `$(( expr ))` | Arithmetic expansion |
| `$(cat file)` | Command substitution |

### How `for` Loops Work

```bash
# Iterate over a list of values
for color in red green blue; do
    echo "Color: $color"
done

# Iterate over files (glob)
for file in *.txt; do
    echo "Processing: $file"
    wc -l "$file"
done

# Iterate over a range of numbers
for i in {1..10}; do
    echo "Number: $i"
done

for i in {1..10..2}; do              # step by 2
    echo "Odd: $i"
done

# C-style for loop
for (( i=0; i<5; i++ )); do
    echo "i = $i"
done

# Iterate over array elements
fruits=("apple" "banana" "cherry")
for fruit in "${fruits[@]}"; do
    echo "$fruit"
done

# Iterate over command output
for user in $(cut -d: -f1 /etc/passwd); do
    echo "User: $user"
done

# Accumulate values
total=0
for f in numbers/*.txt; do
    val=$(cat "$f")
    total=$(( total + val ))
done
echo "Total: $total"

# break and continue
for i in {1..10}; do
    [ $i -eq 5 ] && continue         # skip 5
    [ $i -eq 8 ] && break            # stop at 8
    echo $i
done
```

### Hints

!!! tip "Hint 1"

    Initialize `total=0` before the loop and add each file's value inside.

!!! tip "Hint 2"

    `$(cat "$f")` reads the content of a file and substitutes it inline.

---

!!! info "🔓 Unlock Room 29"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_29/README -out ../room_29/README.txt -pass pass:PASSWORD
    cat ../room_29/README.txt
    ```
