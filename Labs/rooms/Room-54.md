---
title: "(Room 54) 📊 The System Monitor"
password: "monitor5"
title_prefix: "📊 "
summary: "Monitor system resources: memory, CPU load, and uptime using top, free, and vmstat."
---

<div class="room-hero">
  <span class="room-badge">ROOM 54</span>
  <div class="room-title">
    <span class="room-title-accent">📊 The</span>
    <span class="room-title-main">System Monitor</span>
  </div>
</div>

[![Room-54](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-54.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-54.yml)


**WATCH THE SYSTEM!**

---


- The System Monitor room has a resource leak - a hidden process is consuming memory.
- Parse the system snapshot to identify the culprit and report what you find.

---

<div class="tasks" markdown="1">

A static snapshot of the system's resource state has been saved to `system_snapshot.txt`.
Extract the key metrics from it to prove you know the system's condition.

1. Check live memory usage.
   > `free -h`
2. Check the system's current load averages and uptime.
   > `uptime`
3. Read the static snapshot file generated from monitoring tools.
   > `cat system_snapshot.txt`
4. Parse `system_snapshot.txt` to find:
   - Total RAM in megabytes (integer)
   - The 1-minute load average
   - Number of currently running processes
5. Pass all three values to `./getKey.sh` to validate and retrieve the password.
   > `./getKey.sh <total_mem_mb> <load1> <running_procs>`

</div>

### Key Commands

| Command             | Purpose                                             |
| ------------------- | --------------------------------------------------- |
| `free`              | Show RAM and swap usage in kilobytes                |
| `free -h`           | Human-readable output (KB/MB/GB auto-scaled)        |
| `free -m`           | Show all values in megabytes                        |
| `free -g`           | Show all values in gigabytes                        |
| `free -s N`         | Repeat output every N seconds                       |
| `uptime`            | Show current time, user count, and load averages    |
| `uptime -p`         | Pretty format (e.g. "up 2 hours, 14 minutes")       |
| `top`               | Interactive real-time process and resource monitor  |
| `top -bn1`          | Batch mode, single iteration - scriptable/parseable |
| `top -p PID`        | Monitor a specific process by PID                   |
| `top -u user`       | Show only processes belonging to a user             |
| `vmstat`            | Summary of virtual memory, CPU, and I/O stats       |
| `vmstat 1 5`        | Sample stats every 1 second, 5 times                |
| `vmstat -s`         | Detailed memory event summary                       |
| `vmstat -d`         | Disk statistics                                     |
| `cat /proc/meminfo` | Detailed kernel-level memory information            |
| `cat /proc/loadavg` | Raw load averages (1, 5, 15 min + process counts)   |
| `nproc`             | Print number of available CPU processors            |
| `iostat`            | CPU and disk I/O statistics (from sysstat package)  |

### How `free`, `uptime`, `top`, and `vmstat` Work

```bash
# --- free ---
free                               # output in kibibytes
free -h                            # auto-scaled: 7.6G, 512M, etc.
free -m                            # megabytes (good for scripting)
free -s 2                          # update every 2 seconds

# Parse total RAM in MB with awk:
free -m | awk '/^Mem:/ {print $2}'

# --- uptime ---
uptime                             # 14:32:10 up 3 days, 2:15, 2 users, load average: 0.45, 0.60, 0.55
uptime -p                          # up 3 days, 2 hours, 15 minutes

# Extract 1-min load average:
uptime | awk -F'average:' '{print $2}' | cut -d, -f1 | tr -d ' '

# --- top (batch mode for scripting) ---
top -bn1                           # one snapshot, all processes
top -bn1 | head -5                 # show just the summary lines
top -bn1 | grep "^%Cpu"            # CPU usage line
top -bn1 -u www-data               # processes for www-data only

# Count running processes from top output:
top -bn1 | grep "Tasks:" | grep -o '[0-9]* running' | cut -d' ' -f1

# --- /proc files (always available, no external command needed) ---
cat /proc/meminfo                  # MemTotal, MemFree, Buffers, Cached, ...
cat /proc/loadavg                  # 0.45 0.60 0.55 1/342 12345
#                                    ^1min ^5min ^15min ^run/total ^lastpid

# Extract 1-min load from /proc directly:
cut -d' ' -f1 /proc/loadavg

# --- vmstat ---
vmstat                             # one-line snapshot
vmstat 1 5                         # 5 samples, 1 second apart
vmstat -s                          # detailed memory stats (human-readable totals)
vmstat -s | grep "total memory"    # total memory in kB
```


<div class="hints" markdown="1">

> Parse `free -m` output with `awk` to get a clean integer value:

</div>
`free -m | awk '/^Mem:/ {print $2}'` prints total RAM in MB with no units attached.
> `top -bn1` runs `top` in batch mode for a single iteration - perfect for scripting. The header lines contain load averages, running process counts, and memory totals all in one shot without needing an interactive terminal.
---

!!! info "🔓 Unlock Room 55"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_55/README -out ../room_55/README.txt -pass pass:PASSWORD
    cat ../room_55/README.txt
    ```
