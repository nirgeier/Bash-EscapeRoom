---
password: "calc1337"
title_prefix: "🕰️ "
summary: "Use the date command to calculate time differences and decode timestamps."
---

[![Room-23](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-23.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-23.yml)


**DECODE THE TIMESTAMPS!**

---

## 🕰️ The Time Machine

- A time traveler left encrypted coordinates encoded as UNIX timestamps.
- Decode them using the `date` command.

---

!!! abstract "📜 Mission Briefing"

    The file `timestamps.txt` contains three UNIX timestamps (seconds since 1970-01-01).

    1. Read `timestamps.txt` to get the three timestamps.
    2. Convert each timestamp to a human-readable date.
       > hint: `date -d @TIMESTAMP` (Linux) or `date -r TIMESTAMP` (macOS)
    3. Extract just the **year** from each converted date.
       > hint: `date -d @TIMESTAMP +%Y`
    4. The password is the word `epoch` followed by the **sum of the three years** *(no space)*.
       > Example: if the years are 2001, 2010, 2015 → `epoch6026`

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

### Hints

!!! tip "Hint 1"

    `date -d @TIMESTAMP +%Y` extracts just the year from a UNIX timestamp (Linux).

!!! tip "Hint 2"

    On macOS, use `date -r TIMESTAMP +%Y` instead of `date -d @TIMESTAMP`.

---

!!! info "🔓 Unlock Room 24"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_24/README -out ../room_24/README.txt -pass pass:PASSWORD
    cat ../room_24/README.txt
    ```
