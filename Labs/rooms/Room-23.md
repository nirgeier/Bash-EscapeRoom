---
title: "(Room 23) 🕰️ The Time Machine"
password: "calc1337"
title_prefix: "🕰️ "
summary: "Use the date command to calculate time differences and decode timestamps."
---

[![Room-23](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-23.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-23.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 23</span>
  <div class="room-title">
    <span class="room-title-accent">🕰️ The</span>
    <span class="room-title-main">Time Machine</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Use the date command to calculate time differences and decode timestamps.

- A time traveler left encrypted coordinates encoded as UNIX timestamps.
- Decode them using the `date` command.

</div>

---

### DECODE THE TIMESTAMPS!

<ol class="tasks">
  <li>Read <code>timestamps.txt</code> to get the three timestamps.</li>
  <li>Convert each timestamp to a human-readable date. <code>date -d @TIMESTAMP</code> (Linux) or <code>date -r TIMESTAMP</code> (macOS)</li>
  <li>Extract just the <strong>year</strong> from each converted date. <code>date -d @TIMESTAMP +%Y</code></li>
  <li>The password is the word <code>epoch</code> followed by the <strong>sum of the three years</strong> *(no space)*. Example: if the years are 2001, 2010, 2015 → <code>epoch6026</code></li>
</ol>

---

### Key Commands

| Command | Purpose |
| ------- | ------- |
| `date` | Display current date and time |
| `date +FORMAT` | Format date output |
| `date -d @TIMESTAMP` | Convert UNIX timestamp to date (Linux) |
| `date -r TIMESTAMP` | Convert UNIX timestamp to date (macOS) |
| `date -d "STRING"` | Parse a date string |

### How `date` Works

```bash
# Display dates
date                                    # current date and time
date +%Y-%m-%d                         # YYYY-MM-DD format
date +%H:%M:%S                         # HH:MM:SS time
date +%Y%m%d%H%M%S                     # compact timestamp
date +%s                               # current UNIX timestamp (seconds since epoch)
date +%A                               # full weekday name
date +%B                               # full month name

# Format codes (use with +)
# %Y  year (4 digits)    %m  month (01-12)    %d  day (01-31)
# %H  hour (00-23)       %M  minute (00-59)   %S  second (00-59)
# %s  UNIX timestamp     %A  weekday name     %B  month name
# %j  day of year        %u  day of week(1=Mon)

# Convert UNIX timestamps
date -d @0                             # epoch: Thu Jan  1 00:00:00 UTC 1970
date -d @1000000000                   # 2001-09-09
date -d @1700000000 +%Y               # extract year only

# macOS syntax (uses -r instead of -d @)
date -r 1000000000                    # macOS: convert timestamp
date -r 1000000000 +%Y                # macOS: extract year

# Date arithmetic (Linux)
date -d "2024-01-15 + 30 days"        # add 30 days to a date
date -d "2024-12-31 - 1 year"         # subtract 1 year
date -d "next Monday"                 # next Monday's date
date -d "yesterday"                   # yesterday's date

# Calculate a time difference
start=$(date -d "2024-01-01" +%s)
end=$(date -d "2024-12-31" +%s)
echo $(( (end - start) / 86400 )) days
```


<div class="hints" markdown="1">

> `date -d @TIMESTAMP +%Y` extracts just the year from a UNIX timestamp (Linux).

> On macOS, use `date -r TIMESTAMP +%Y` instead of `date -d @TIMESTAMP`.

</div>
---

!!! info "🔓 Unlock Room 24"

    Once you solve the puzzle, run:

    ```bash
    next <PASSWORD>
    ```
