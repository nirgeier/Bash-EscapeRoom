---
password: "netprobe"
title_prefix: "📡 "
summary: "Probe the network with ping and traceroute, then retrieve a remote resource using wget."
---

[![Room-53](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-53.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-53.yml)


**TRACE THE SIGNAL!**

---

## 📡 The Network Probe

- A signal is being transmitted from a remote beacon somewhere on the network.
- You must verify connectivity, trace the route, and retrieve the transmission.

---

!!! abstract "📜 Mission Briefing"

    A local beacon is broadcasting a secret key. Probe your way to it.

    1. Verify network connectivity by pinging the loopback address.
       > hint: `ping -c 3 127.0.0.1`
    2. Trace the network route to confirm the path.
       > hint: `traceroute 127.0.0.1` or `tracepath 127.0.0.1`
    3. Start the local beacon server.
       > hint: `./start_server.sh`
    4. Use `wget` to retrieve the secret key file from the beacon.
    5. The content of `key.txt` **is** the next room's password.

### Key Commands

| Command                      | Purpose                                           |
| ---------------------------- | ------------------------------------------------- |
| `ping host`                  | Send ICMP echo packets to test connectivity       |
| `ping -c N host`             | Send exactly N packets then stop                  |
| `ping -i N host`             | Set interval to N seconds between packets         |
| `ping -W N host`             | Timeout after N seconds waiting for a reply       |
| `ping -q host`               | Quiet mode - show only the summary at end         |
| `ping -s N host`             | Set packet size to N bytes                        |
| `traceroute host`            | Trace each network hop to the destination         |
| `traceroute -n host`         | Skip DNS resolution (faster output)               |
| `traceroute -m N host`       | Set maximum number of hops to N                   |
| `tracepath host`             | Traceroute alternative requiring no root          |
| `mtr host`                   | Combines ping + traceroute in live display        |
| `wget URL`                   | Download a file from a URL                        |
| `wget -O file URL`           | Save downloaded content to a specific filename    |
| `wget -O - URL`              | Stream download output directly to stdout         |
| `wget -q URL`                | Quiet mode - suppress all progress output         |
| `wget --spider URL`          | Check if URL is reachable without downloading     |
| `wget -r -l 1 URL`           | Recursive download, depth limited to 1            |
| `wget --limit-rate=100k URL` | Throttle download to 100 KB/s                     |
| `curl -s URL`                | Alternative to wget: fetch URL silently to stdout |

### How `ping`, `traceroute`, and `wget` Work

```bash
# --- ping ---
ping 127.0.0.1                    # continuous ping (Ctrl-C to stop)
ping -c 3 127.0.0.1               # send exactly 3 packets
ping -c 5 -i 0.5 google.com       # 5 packets, 0.5 s interval
ping -c 4 -W 2 192.168.1.1        # timeout 2 s per reply
ping -q -c 10 8.8.8.8             # quiet: just the final stats
ping -s 1400 gateway.local        # large packet (test MTU)

# --- traceroute ---
traceroute 8.8.8.8                # trace to Google DNS
traceroute -n 8.8.8.8             # no DNS lookups (show IPs only)
traceroute -m 15 8.8.8.8          # max 15 hops
tracepath 8.8.8.8                 # no-root alternative
mtr --report --report-cycles 10 8.8.8.8  # batch MTU report

# --- wget ---
wget http://host/file.txt                  # download to current directory
wget -O /tmp/file.txt http://host/file.txt # save to specific path
wget -q -O - http://host/file.txt          # print to stdout, no noise
wget --spider http://host/                 # check server without downloading
wget -r -l 1 -q http://host/              # spider all links one level deep
wget --limit-rate=500k -O archive.tar.gz http://host/big.tar.gz

# --- wget vs curl comparison ---
wget -q -O - http://host/file.txt      # wget to stdout
curl -s http://host/file.txt           # curl equivalent
```

### Hints

!!! tip "Hint 1"

    `wget -q -O - http://host/file` streams the file content directly to your terminal without saving a local copy and without any progress noise. Pipe it to `tr -d '\n'` if you need to strip the trailing newline.

!!! tip "Hint 2"

    If `traceroute` is not available on your system, try `tracepath` (available without root on most Linux systems) or `mtr` for a real-time combined ping+trace view.

---

!!! info "🔓 Unlock Room 54"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_54/README -out ../room_54/README.txt -pass pass:PASSWORD
    cat ../room_54/README.txt
    ```
