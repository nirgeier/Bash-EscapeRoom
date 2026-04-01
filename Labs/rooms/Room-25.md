---
password: "format77"
title_prefix: "🔀 "
summary: "Use tee to split output to both a file and the screen simultaneously."
---

[![Room-25](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-25.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-25.yml)


**SPLIT THE SIGNAL!**

---

## 🔀 The Signal Crossroads

- Incoming data must be routed simultaneously to two destinations.
- Use `tee` to split the stream and write a log while still processing the data.

---

!!! abstract "📜 Mission Briefing"

    The script `generate_signal.sh` outputs a stream of data lines.

    1. Run `generate_signal.sh` and use `tee` to write the output to `signal.log` while also piping it onward.
       > hint: `./generate_signal.sh | tee signal.log | grep "CODE"`
    2. From the tee'd stream, filter lines containing `CODE:` and extract the code values.
       > hint: `grep "CODE:" | cut -d':' -f2`
    3. Sort the codes numerically and sum them.
       > hint: `sort -n | paste -sd'+' | bc`
    4. The password is `tee` followed by the total sum *(no space)*.
       > Example: if the sum is 99 → `tee99`

### Key Commands

| Command | Purpose |
| ------- | ------- |
| `tee file` | Write stdin to both stdout and a file |
| `tee -a file` | Append to file instead of overwriting |
| `tee file1 file2` | Write to multiple files at once |
| `paste -sd'+'` | Join lines with a delimiter |

### How `tee` Works

```bash
# Basic tee: write to file AND pass to stdout
cmd | tee output.txt                    # tee to file, output still visible
cmd | tee output.txt | next_cmd        # tee mid-pipeline

# Append mode
cmd | tee -a logfile.txt               # append to file (don't overwrite)

# Multiple output files
cmd | tee file1.txt file2.txt          # write to two files at once
cmd | tee file1.txt file2.txt | wc -l  # also count lines

# Use tee as a debug probe mid-pipeline
cmd1 | tee /dev/stderr | cmd2          # peek at data without breaking pipeline
cmd1 | tee debug.log | cmd2            # save intermediate state

# Process substitution with tee
cmd | tee >(grep "ERROR" > errors.log) >(grep "WARN" > warnings.log) > /dev/null

# Write to file with elevated privileges
echo "data" | sudo tee /etc/config     # write to root-owned file
echo "data" | sudo tee -a /etc/config  # append to root-owned file

# paste - join lines
paste file1.txt file2.txt              # merge files side by side with tab
paste -d',' file1.txt file2.txt        # merge with comma delimiter
echo -e "1\n2\n3" | paste -sd'+'      # join lines: "1+2+3" (for bc)
```

### Hints

!!! tip "Hint 1"

    `tee signal.log` writes to the file AND passes data along to the next pipe.

!!! tip "Hint 2"

    `paste -sd'+'` turns a vertical list of numbers into `1+2+3+4` which `bc` can evaluate.

---

!!! info "🔓 Unlock Room 26"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_26/README -out ../room_26/README.txt -pass pass:PASSWORD
    cat ../room_26/README.txt
    ```
