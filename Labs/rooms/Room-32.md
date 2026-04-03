---
title: "(Room 32) ⚙️ The Function Factory"
password: "matched7"
title_prefix: "⚙️ "
summary: "Write and call bash functions to process a complex multi-step task."
---

<div class="room-hero">
  <span class="room-badge">ROOM 32</span>
  <div class="room-title">
    <span class="room-title-accent">⚙️ The</span>
    <span class="room-title-main">Function Factory</span>
  </div>
</div>

[![Room-32](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-32.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-32.yml)


**POWER UP THE FACTORY!**

---


- The factory machines only work when the right functions are called in the right order.
- Write bash functions to process the assembly line.

---

<div class="tasks" markdown="1">

The file `assembly.txt` contains 10 product codes, one per line.
Write a bash script using functions to process them.

1. Write a function `validate` that checks if a code starts with `PROD-`.
2. Write a function `extract_id` that returns the numeric part after `PROD-`.
3. For each valid code, extract its ID and sum all IDs.
4. The password is `func` followed by the total sum *(no space)*.
   > Example: if the sum is 550 → `func550`

</div>

### Key Commands

| Syntax                       | Purpose                     |
| ---------------------------- | --------------------------- |
| `function_name() { ... }`    | Define a function           |
| `function func_name { ... }` | Alternative syntax          |
| `return N`                   | Return an exit code (0-255) |
| `echo value`                 | Return a value via stdout   |
| `local var=value`            | Declare a local variable    |
| `$1 $2 $@`                   | Function arguments          |

### How Bash Functions Work

```bash
# Define a function
greet() {
    echo "Hello, $1!"
}
greet "World"                          # Hello, World!

# Function with return value (via stdout)
add() {
    echo $(( $1 + $2 ))
}
result=$(add 3 5)                      # capture output
echo $result                           # 8

# Function with exit code (return)
is_even() {
    if (( $1 % 2 == 0 )); then
        return 0                       # success = true
    else
        return 1                       # failure = false
    fi
}
is_even 4 && echo "even" || echo "odd"

# Local variables
counter=0
increment() {
    local step=${1:-1}                 # local var with default
    counter=$(( counter + step ))
}
increment 5
echo $counter                          # 5

# Functions in scripts
validate() {
    [[ "$1" == PROD-* ]]              # returns 0 if true, 1 if false
}

extract_id() {
    echo "${1#PROD-}"                  # remove PROD- prefix
}

total=0
while IFS= read -r code; do
    if validate "$code"; then
        id=$(extract_id "$code")
        total=$(( total + id ))
    fi
done < assembly.txt
echo "Total: $total"
```


<div class="hints" markdown="1">

> Use `[[ "$1" == PROD-* ]]` in the validate function - it returns exit code 0 (true) if matched.

> `echo "${1#PROD-}"` strips the `PROD-` prefix, leaving just the number.

</div>
---

!!! info "🔓 Unlock Room 33"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_33/README -out ../room_33/README.txt -pass pass:PASSWORD
    cat ../room_33/README.txt
    ```
