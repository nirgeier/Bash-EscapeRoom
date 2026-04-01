---
password: "daemon77"
title_prefix: "⛏️ "
summary: "Use awk to filter CSV data and calculate sums based on conditions."
---

[![Room-10](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-10.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-10.yml)


**MINE THE DATA!**

---

## ⛏️ The Data Mine

- A CSV file contains 100 mineral survey records.
- Use `awk` to filter rows by depth and sum the weight values.

!!! abstract "📜 Mission Briefing"

    The file `mine_data.csv` contains 100 mineral survey records.
    Format: `mineral,depth,weight,sector`

    1. Use `awk` to process `mine_data.csv`:
       - Skip the header line (line 1)
       - Filter rows where `depth` (field 2) is **greater than 50**
       - Sum the `weight` values (field 3) of those filtered rows
    2. The password is `awk` followed by the calculated sum *(no space)*.
       > Example: if the sum is 1234 → `awk1234`
       > hint: `awk -F',' 'NR>1 && $2>50 {sum+=$3} ..'

### Key Commands

| Command | Purpose |
| --- | --- |
| `awk '{print $1}' file` | Print first field |
| `awk '{print $NF}' file` | Print last field |
| `awk -F: '{print $1}' file` | Use : as delimiter |
| `awk 'NR==5' file` | Print only line 5 |
| `awk 'NR>=3 && NR<=7' file` | Print lines 3-7 |
| `awk '/pattern/' file` | Print lines matching pattern |
| `awk '!/pattern/' file` | Print non-matching lines |
| `awk '$3>100' file` | Print where field 3 > 100 |
| `awk '{sum+=$2} END{print sum}' file` | Sum field 2 |
| `awk 'BEGIN{FS=","} {print $2}' file` | CSV processing |
| `awk '{print NR": "$0}' file` | Number all lines |
| `awk 'END{print NR}' file` | Count total lines |
| `awk '{gsub(/old/,"new"); print}' file` | Global substitution |
| `awk '{print toupper($0)}' file` | Convert to uppercase |
| `awk -v OFS=, '{print $1,$3}' file` | Custom output separator |
| `awk 'length>80' file` | Lines longer than 80 chars |

### How `awk` Works

```bash
# Basic syntax: awk 'pattern { action }' file
awk '{print}' file.txt                  # print all lines (like cat)
awk '{print $1}' file.txt               # print first field
awk '{print $1, $3}' file.txt           # print fields 1 and 3
awk '{print NR, $0}' file.txt           # line number + full line
awk '{print NF}' file.txt               # number of fields per line

# Field separators
awk -F',' '{print $2}' file.csv         # comma-separated
awk -F':' '{print $1}' /etc/passwd      # colon-separated
awk -F'\t' '{print $1}' file.tsv        # tab-separated

# Filtering
awk '/pattern/ {print}' file.txt        # lines matching a regex
awk '!/pattern/ {print}' file.txt       # lines NOT matching
awk '$2 > 50 {print}' file.txt          # numeric comparison
awk '$1 == "gold" {print}' file.txt     # exact string match
awk 'NR > 1 {print}' file.txt           # skip first line (header)
awk 'NR >= 5 && NR <= 10' file.txt      # line range

# Calculations
awk '{sum += $1} END {print sum}' file.txt          # sum a column
awk '{count++} END {print count}' file.txt          # count lines
awk '{if ($1>max) max=$1} END {print max}' file.txt # find max value
awk '{total += $1} END {print total/NR}' file.txt   # average

# BEGIN and END blocks
awk 'BEGIN {print "Start"} {print} END {print "Done"}' file.txt
```

### The CSV Format

```
mineral,depth,weight,sector
gold,72,45,A1
silver,30,22,B2
...
```

### Hints

!!! tip "Hint 1"

    `NR>1` skips the header line.

!!! tip "Hint 2"

    `$2>50` filters for depth greater than 50.

!!! tip "Hint 3"

    The password format is: `awk` + the calculated sum (e.g., `awk1234`).

---

!!! info "🔓 Unlock Room 11"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_11/README -out ../room_11/README.txt -pass pass:PASSWORD
    cat ../room_11/README
    ```
