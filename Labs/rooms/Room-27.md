---
title: "(Room 27) 🗃️ The Array Arsenal"
password: "expand99"
title_prefix: "🗃️ "
summary: "Use bash arrays to collect, sort, and process a list of items."
---

<div class="room-hero">
  <span class="room-badge">ROOM 27</span>
  <div class="room-title">
    <span class="room-title-accent">🗃️ The</span>
    <span class="room-title-main">Array Arsenal</span>
  </div>
</div>

[![Room-27](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-27.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-27.yml)


**INVENTORY THE ARSENAL!**

---


- The armory has been scrambled - weapons are unordered and some are duplicates.
- Use Bash arrays to organize the inventory and count unique weapons.

---

<div class="tasks" markdown="1">

The file `weapons.txt` contains a list of weapon names, one per line.

1. Write a small bash script (or one-liner) to read all weapon names into an array.
   > `mapfile -t weapons < weapons.txt`
2. Count the total number of items in the array.
   > `${#weapons[@]}`
3. Count how many **unique** weapon names there are.
   > pipe through `sort | uniq | wc -l`
4. The password is `array` followed by the count of unique weapons *(no space)*.
   > Example: if there are 10 unique weapons → `array10`

</div>

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

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_28/README -out ../room_28/README.txt -pass pass:PASSWORD
    cat ../room_28/README.txt
    ```
