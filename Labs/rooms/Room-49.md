---
title: "(Room 49) 🏭 The Grand Pipeline II"
password: "commit42"
title_prefix: "🏭 "
summary: "Build an advanced multi-stage pipeline combining awk, sed, sort, and uniq."
---

[![Room-49](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-49.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-49.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 49</span>
  <div class="room-title">
    <span class="room-title-accent">🏭 The</span>
    <span class="room-title-main">Grand Pipeline II</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Build an advanced multi-stage pipeline combining awk, sed, sort, and uniq.

- The final lock requires you to build a sophisticated data processing pipeline.
- Combine your knowledge of multiple tools to crack it.

</div>

---

### BUILD THE GRAND PIPELINE!

<ol class="tasks">
  <li>Filter lines where <code>STATUS</code> is <code>SUCCESS</code>. <code>awk '$3 == "SUCCESS"'</code></li>
  <li>Extract the <code>MACHINE_ID</code> field (field 2). <code>awk '{print $2}'</code></li>
  <li>Sort and count occurrences of each machine ID. <code>sort | uniq -c | sort -rn</code></li>
  <li>Find the machine with the <strong>most</strong> successes - note the count.</li>
  <li>The password is <code>pipeline</code> followed by that count *(no space)*. Example: if the top machine had 47 successes → <code>pipeline47</code></li>
</ol>

### The Complete Pipeline

```bash
awk '$3 == "SUCCESS" {print $2}' factory_log.txt \
  | sort \
  | uniq -c \
  | sort -rn \
  | head -1 \
  | awk '{print $1}'
```

### Key Commands

| Command             | Purpose                               |
| ------------------- | ------------------------------------- |
| `awk '$N == "val"'` | Filter rows by field value            |
| `sort \| uniq -c`   | Count occurrences of each unique line |
| `sort -rn`          | Sort numerically, descending          |
| `head -1`           | Take only the top result              |

### Full Pipeline Reference

```bash
# Data filtering and transformation chain
cat data.txt \
  | grep "pattern"                     # pre-filter with grep
  | awk '{print $2, $4}'               # extract fields
  | sort                               # sort for uniq
  | uniq -c                            # count duplicates
  | sort -rn                           # sort by count descending
  | head -10                           # top 10

# Aggregate with awk
awk 'BEGIN {max=0; maxid=""}
     $3=="SUCCESS" {
       count[$2]++
       if (count[$2] > max) { max=count[$2]; maxid=$2 }
     }
     END { print max, maxid }' factory_log.txt

# Multi-condition filtering
awk '$3 == "SUCCESS" && $4 > 100' file.txt   # success with 100+ units
awk 'NR > 1 && $2 ~ /^M/' file.txt           # skip header, machine IDs starting with M

# Join two files
join <(sort file1.txt) <(sort file2.txt)     # inner join on first field
```


<div class="hints" markdown="1">

> `uniq -c` prefixes each line with its count - the format is `COUNT VALUE`.

> After `sort -rn`, the first line has the highest count. `head -1 | awk '{print $1}'` extracts just the number.

</div>
---

!!! info "🔓 Unlock Room 50"

    Once you solve the puzzle, run:

    ```bash
    next <PASSWORD>
    ```
