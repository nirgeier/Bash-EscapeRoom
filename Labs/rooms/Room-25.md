---
title: "(Room 25) 🔀 The Signal Crossroads"
password: "format77"
title_prefix: "🔀 "
summary: "Use tee to split output to both a file and the screen simultaneously."
---

[![Room-25](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-25.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-25.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 25</span>
  <div class="room-title">
    <span class="room-title-accent">🔀 The</span>
    <span class="room-title-main">Signal Crossroads</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Use tee to split output to both a file and the screen simultaneously.

- Incoming data must be routed simultaneously to two destinations.
- Use `tee` to split the stream and write a log while still processing the data.

</div>

---

### SPLIT THE SIGNAL!

<ol class="tasks">
  <li>Run <code>generate_signal.sh</code> and use <code>tee</code> to write the output to <code>signal.log</code> while also piping it onward. <code>./generate_signal.sh | tee signal.log | grep "CODE"</code></li>
  <li>From the tee'd stream, filter lines containing <code>CODE:</code> and extract the code values. <code>grep "CODE:" | cut -d':' -f2</code></li>
  <li>Sort the codes numerically and sum them. <code>sort -n | paste -sd'+' | bc</code></li>
  <li>The password is <code>tee</code> followed by the total sum *(no space)*. Example: if the sum is 99 → <code>tee99</code></li>
</ol>

---

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


<div class="hints" markdown="1">

> `tee signal.log` writes to the file AND passes data along to the next pipe.

> `paste -sd'+'` turns a vertical list of numbers into `1+2+3+4` which `bc` can evaluate.

</div>
---

!!! info "🔓 Unlock Room 26"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_26/README -out ../room_26/README.txt -pass pass:PASSWORD
    cat ../room_26/README.txt
    ```
