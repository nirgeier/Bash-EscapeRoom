---
title: "(Room 27) 🗃️ The Array Arsenal"
password: "expand99"
title_prefix: "🗃️ "
summary: "Use bash arrays to collect, sort, and process a list of items."
---

[![Room-27](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-27.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-27.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 27</span>
  <div class="room-title">
    <span class="room-title-accent">🗃️ The</span>
    <span class="room-title-main">Array Arsenal</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Use bash arrays to collect, sort, and process a list of items.

- The armory has been scrambled - weapons are unordered and some are duplicates.
- Use Bash arrays to organize the inventory and count unique weapons.

</div>

---

### INVENTORY THE ARSENAL!

<ol class="tasks">
  <li>Write a small bash script (or one-liner) to read all weapon names into an array. <code>mapfile -t weapons < weapons.txt</code></li>
  <li>Count the total number of items in the array. <code>${#weapons[@]}</code></li>
  <li>Count how many <strong>unique</strong> weapon names there are. pipe through <code>sort | uniq | wc -l</code></li>
  <li>The password is <code>array</code> followed by the count of unique weapons *(no space)*. Example: if there are 10 unique weapons → <code>array10</code></li>
</ol>

---

### Key Commands

| Syntax                  | Purpose                    |
| ----------------------- | -------------------------- |
| `arr=(a b c)`           | Declare an array           |
| `${arr[0]}`             | Access element by index    |
| `${arr[@]}`             | All elements               |
| `${#arr[@]}`            | Number of elements         |
| `arr+=(d)`              | Append an element          |
| `mapfile -t arr < file` | Read file lines into array |

### How Bash Arrays Work

```bash
# Declare and access arrays
fruits=("apple" "banana" "cherry")     # declare array
echo ${fruits[0]}                       # apple (index starts at 0)
echo ${fruits[1]}                       # banana
echo ${fruits[-1]}                      # cherry (last element)
echo ${fruits[@]}                       # all elements: apple banana cherry
echo ${#fruits[@]}                      # number of elements: 3

# Add and modify elements
fruits+=("date")                        # append element
fruits[1]="blueberry"                   # replace element at index 1
unset fruits[2]                         # remove element (leaves gap)

# Iterate over array
for fruit in "${fruits[@]}"; do
    echo "$fruit"
done

# Array slices
echo ${fruits[@]:1:2}                   # elements 1 and 2 (banana cherry)
echo ${fruits[@]: -2}                   # last 2 elements

# Read file into array
mapfile -t lines < file.txt             # read each line into array element
IFS=$'\n' read -r -a lines <<< "$(cat file.txt)"  # alternative

# Array of unique items
IFS=$'\n' sorted=($(sort -u <<< "${fruits[*]}"))

# Associative arrays (Bash 4+)
declare -A colors
colors["red"]="#FF0000"
colors["green"]="#00FF00"
echo ${colors["red"]}                   # #FF0000
echo ${!colors[@]}                      # all keys: red green
echo ${colors[@]}                       # all values

# Indices
echo ${!fruits[@]}                      # 0 1 3 (note: gap from unset[2])
```


<div class="hints" markdown="1">

> `mapfile -t weapons < weapons.txt` reads all lines into the array.

> `printf '%s\n' "${weapons[@]}" | sort | uniq | wc -l` counts unique elements.

</div>
---

!!! info "🔓 Unlock Room 28"

    Once you solve the puzzle, run:

    ```bash
    next <PASSWORD>
    ```
