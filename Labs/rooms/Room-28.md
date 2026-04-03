---
title: "(Room 28) 🔁 The Loop Labyrinth"
password: "array10"
title_prefix: "🔁 "
summary: "Use a for loop to process files and accumulate a result."
---

[![Room-28](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-28.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-28.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 28</span>
  <div class="room-title">
    <span class="room-title-accent">🔁 The</span>
    <span class="room-title-main">Loop Labyrinth</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Use a for loop to process files and accumulate a result.

- 50 numbered chambers each contain a single digit.
- Loop through them all and sum the digits to unlock the exit.

</div>

---

### LOOP THROUGH THE LABYRINTH!

<ol class="tasks">
  <li>Write a <code>for</code> loop to iterate over all chamber files. <code>for f in chambers/chamber_*.txt; do ...</code></li>
  <li>Read each file's value and add it to a running total. <code>total=$(( total + $(cat "$f") ))</code></li>
  <li>After the loop, print the total.</li>
  <li>The password is <code>loop</code> followed by the total *(no space)*. Example: if the sum is 250 → <code>loop250</code></li>
</ol>

---

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


<div class="hints" markdown="1">

> Initialize `total=0` before the loop and add each file's value inside.

> `$(cat "$f")` reads the content of a file and substitutes it inline.

</div>
---

!!! info "🔓 Unlock Room 29"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_29/README -out ../room_29/README.txt -pass pass:PASSWORD
    cat ../room_29/README.txt
    ```
