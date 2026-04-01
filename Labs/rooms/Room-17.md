---
password: "modulereactor"
title_prefix: "⏰ "
summary: "Decode cron expressions to determine how many times a job runs per day."
---

[![Room-17](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-17.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-17.yml)


**CRACK THE CLOCKWORK CODE!**

---

## ⏰ The Clockwork Fortress

- An ancient fortress runs on a clockwork schedule.
- Decode the cron expressions to find how many times the alarm fires per day.

---

!!! abstract "📜 Mission Briefing"

    The file `schedule.cron` contains several cron job definitions.

    1. Read `schedule.cron` to see all the scheduled jobs.
    2. Count how many times **per day** the job labelled `# ALARM` would execute.
       > hint: Analyze the cron expression - `minute hour day-of-month month day-of-week`
    3. The password is `cron` followed by the total number of daily executions *(no space)*.
       > Example: if the alarm fires 12 times per day → `cron12`

### Key Commands

| Command | Purpose |
| --- | --- |
| `crontab -l` | List current user's crontab |
| `crontab -e` | Edit crontab in default editor |
| `crontab -r` | Remove (delete) current crontab |
| `crontab file` | Install crontab from file |
| `* * * * * cmd` | Run cmd every minute |
| `0 * * * * cmd` | Every hour at :00 |
| `0 9 * * * cmd` | Every day at 09:00 |
| `0 9 * * 1 cmd` | Every Monday at 09:00 |
| `0 9 1 * * cmd` | 1st of every month at 09:00 |
| `*/5 * * * * cmd` | Every 5 minutes |
| `0 9-17 * * 1-5 cmd` | Every hour 9am-5pm weekdays |
| `@reboot cmd` | Run once at startup |
| `@daily cmd` | Equivalent to `0 0 * * *` |
| `@hourly cmd` | Equivalent to `0 * * * *` |
| `@weekly cmd` | Equivalent to `0 0 * * 0` |
| `MAILTO=user@host` | Email cron output |

### How Cron Works

```bash
# Cron expression format:
# ┌───────── minute (0-59)
# │ ┌───────── hour (0-23)
# │ │ ┌───────── day of month (1-31)
# │ │ │ ┌───────── month (1-12)
# │ │ │ │ ┌───────── day of week (0-6, Sunday=0)
# │ │ │ │ │
# * * * * *  command to execute

# Special characters:
# *  = every (any value)
# ,  = list of values (e.g., 1,3,5)
# -  = range (e.g., 1-5)
# /  = step (e.g., */5 = every 5)

# Examples:
0 * * * *         # every hour at minute 0 (24x/day)
*/15 * * * *      # every 15 minutes (96x/day)
0 9 * * 1-5       # 9am Monday through Friday
30 2 * * 0        # 2:30am every Sunday
0 0 1 * *         # midnight on first day of month
0 8,12,18 * * *   # 8am, noon, and 6pm every day

# Manage crontabs
crontab -l                          # list current jobs
crontab -e                          # open editor to modify
crontab -r                          # DANGER: removes ALL your cron jobs
crontab /path/to/file               # install jobs from file
sudo crontab -u username -l         # list another user's crons

# System-wide cron locations
cat /etc/crontab                    # system crontab (includes user field)
ls /etc/cron.d/                     # drop-in cron files
ls /etc/cron.daily/                 # scripts run once daily
ls /etc/cron.hourly/                # scripts run once hourly
```

### Cron Expression Quick Reference

| Expression     | Meaning          |
| -------------- | ---------------- |
| `* * * * *`    | Every minute     |
| `0 * * * *`    | Every hour       |
| `*/30 * * * *` | Every 30 minutes |
| `0 9 * * 1-5`  | 9am weekdays     |
| `0 0 * * *`    | Midnight daily   |

### Hints

!!! tip "Hint 1"

    Count each valid time combination in a 24-hour day (00:00 to 23:59).

!!! tip "Hint 2"

    `*/N` means "every N units" - e.g., `*/4` in hours = 6 times per day (0,4,8,12,16,20).

---

!!! info "🔓 Unlock Room 18"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_18/README -out ../room_18/README.txt -pass pass:PASSWORD
    cat ../room_18/README.txt
    ```
