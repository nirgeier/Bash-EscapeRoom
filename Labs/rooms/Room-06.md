---
password: "translate"
title_prefix: "🔍 "
summary: "Use sort, uniq, comm, and wc to find unique gems between two vaults."
---

[![Room-06](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-06.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-06.yml)


**FIND THE UNIQUE GEMS!**

---

## 🔍 The Duplicate Detective

Two treasure vaults contain gem inventories. Some gems appear in both vaults,
some are unique to one. Find the gems that exist ONLY in vault A.

!!! abstract "📜 Mission Briefing"

    Two vaults (`vault_a.txt` and `vault_b.txt`) contain gem inventories with
    duplicates within each file.

    1. Remove duplicate entries within each file.
       > hint: `sort` + `uniq` removes duplicates from sorted input
    2. Find gems that appear **only** in `vault_a.txt` (not in `vault_b.txt`).
       > hint: `comm -23 file1 file2` shows lines only in file1 (both must be sorted)
    3. Count those unique-to-vault-a gems.
       > hint: pipe to `wc -l`
    4. The password is the word `unique` followed by that count *(no space)*.
       > Example: if there are 15 unique gems → `unique15`

### Key Commands

| Command    | Purpose                                                |
| ---------- | ------------------------------------------------------ |
| `sort`     | Sort lines alphabetically                              |
| `uniq`     | Remove adjacent duplicate lines (input must be sorted) |
| `comm`     | Compare two sorted files line by line                  |
| `comm -23` | Show lines only in file 1 (not in file 2)              |
| `diff`     | Show differences between two files                     |
| `wc -l`    | Count lines                                            |

---

### How These Commands Work

```bash
# sort - order lines
sort file.txt                        # alphabetical (default)
sort -r file.txt                     # reverse order
sort -n file.txt                     # numeric sort
sort -k2 file.txt                    # sort by 2nd field
sort -t',' -k2 -n file.txt           # CSV, numeric sort on field 2
sort -u file.txt                     # sort and remove duplicates

# uniq - filter duplicate adjacent lines (input must be sorted!)
uniq file.txt                        # remove consecutive duplicates
uniq -c file.txt                     # prefix count of occurrences
uniq -d file.txt                     # show only duplicate lines
uniq -u file.txt                     # show only unique lines
uniq -i file.txt                     # case-insensitive comparison

# comm - compare two sorted files line by line
comm file1.txt file2.txt             # 3 columns: only-1 | only-2 | both
comm -12 file1.txt file2.txt         # lines in BOTH files only
comm -23 file1.txt file2.txt         # lines only in file1
comm -13 file1.txt file2.txt         # lines only in file2
comm -3  file1.txt file2.txt         # suppress lines in both

# Process substitution (skip temp files)
comm -23 <(sort fileA.txt | uniq) <(sort fileB.txt | uniq)
```

---

### Hints

!!! tip "Hint"

    The password format is: `unique` + the count (e.g., `unique15`).

---

!!! info "🔓 Unlock Room 07"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_07/README -out ../room_07/README.txt -pass pass:PASSWORD
    cat ../room_07/README
    ```
