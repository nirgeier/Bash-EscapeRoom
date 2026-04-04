---
title: "(Room 22) 🧮 The Calculator Cave"
password: "hidden42"
title_prefix: "🧮 "
summary: "Use bc and expr to perform mathematical calculations and crack the code."
---

[![Room-22](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-22.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-22.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 22</span>
  <div class="room-title">
    <span class="room-title-accent">🧮 The</span>
    <span class="room-title-main">Calculator Cave</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Use bc and expr to perform mathematical calculations and crack the code.

- The door lock requires solving a series of mathematical equations.
- Linux has built-in calculators - use them!

</div>

---

### SOLVE THE EQUATION!

<ol class="tasks">
  <li>Read <code>equations.txt</code> to see the problems.</li>
  <li>Solve each equation using <code>bc</code> (supports floating point and complex math). <code>echo "2^10 + 15 * 3" | bc</code></li>
  <li>The password is the word <code>calc</code> followed by the <strong>sum of all three answers</strong> *(no space)*. Example: if answers are 5, 10, and 20 → <code>calc35</code></li>
</ol>

---

### Key Commands

| Command                      | Purpose                        |
| ---------------------------- | ------------------------------ |
| `bc`                         | Arbitrary precision calculator |
| `echo "EXPR" \| bc`          | Evaluate a math expression     |
| `echo "scale=2; EXPR" \| bc` | Set decimal places             |
| `expr A + B`                 | Simple integer arithmetic      |
| `$(( A + B ))`               | Bash arithmetic expansion      |

### How `bc` and `expr` Work

```bash
# bc - arbitrary precision calculator
echo "2 + 2" | bc                       # basic addition → 4
echo "10 / 3" | bc                      # integer division → 3
echo "scale=4; 10 / 3" | bc            # 4 decimal places → 3.3333
echo "2^10" | bc                        # power: 2^10 = 1024
echo "sqrt(144)" | bc                   # square root = 12
echo "l(100)" | bc -l                   # natural log (requires -l for math lib)
echo "s(3.14159/2)" | bc -l            # sine function (radians)
echo "obase=16; 255" | bc              # convert 255 to hex: FF
echo "ibase=16; FF" | bc              # convert hex FF to decimal: 255

# Multi-line bc
bc << 'EOF'
scale=2
a = 10
b = 3
a / b
EOF

# expr - simple integer arithmetic (older style)
expr 5 + 3                              # 8
expr 10 \* 4                           # 40 (escape the asterisk)
expr 10 % 3                            # 1 (modulo)
expr length "hello"                    # 5 (string length)

# Bash arithmetic ($(( )))
echo $(( 2 + 3 ))                       # 5
echo $(( 10 ** 3 ))                     # 1000 (power)
echo $(( 100 % 7 ))                     # 2 (modulo)
result=$(( 5 * 8 ))                     # assign to variable
```


<div class="hints" markdown="1">

> Use `echo "expression" | bc` for each equation, then add all results together.

> For floating point results, use `echo "scale=0; expression" | bc` to get integers.

</div>
---

!!! info "🔓 Unlock Room 23"

    Once you solve the puzzle, run:

    ```bash
    next <PASSWORD>
    ```
