---
password: "commit42"
title_prefix: "🏭 "
summary: "Build an advanced multi-stage pipeline combining awk, sed, sort, and uniq."
---

[![Room-49](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-49.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-49.yml)


**BUILD THE GRAND PIPELINE!**

---

## 🏭 The Grand Pipeline II

- The final lock requires you to build a sophisticated data processing pipeline.
- Combine your knowledge of multiple tools to crack it.

---

!!! abstract "📜 Mission Briefing"

    The file `factory_log.txt` contains production records with the format:
    `TIMESTAMP MACHINE_ID STATUS UNITS_PRODUCED`

    Build a pipeline to derive the password:

    1. Filter lines where `STATUS` is `SUCCESS`.
       > hint: `awk '$3 == "SUCCESS"'`
    2. Extract the `MACHINE_ID` field (field 2).
       > hint: `awk '{print $2}'`
    3. Sort and count occurrences of each machine ID.
       > hint: `sort | uniq -c | sort -rn`
    4. Find the machine with the **most** successes - note the count.
    5. The password is `pipeline` followed by that count *(no space)*.
       > Example: if the top machine had 47 successes → `pipeline47`

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

### Hints

!!! tip "Hint 1"

    `uniq -c` prefixes each line with its count - the format is `COUNT VALUE`.

!!! tip "Hint 2"

    After `sort -rn`, the first line has the highest count. `head -1 | awk '{print $1}'` extracts just the number.

---

!!! info "🔓 Unlock Room 50"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_50/README -out ../room_50/README.txt -pass pass:PASSWORD
    cat ../room_50/README.txt
    ```
