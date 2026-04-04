---
title: "(Room 39) 🕸️ The Network Hub"
password: "timeout3"
title_prefix: "🕸️ "
summary: "Use ss and netstat to inspect network connections and find the listening port."
---

[![Room-39](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-39.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-39.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 39</span>
  <div class="room-title">
    <span class="room-title-accent">🕸️ The</span>
    <span class="room-title-main">Network Hub</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Use ss and netstat to inspect network connections and find the listening port.

- Hidden services are running on this machine.
- Use network inspection tools to find which port holds the secret.

</div>

---

### MAP THE NETWORK HUB!

<ol class="tasks">
  <li>List all listening TCP ports. <code>ss -tlnp</code> or <code>netstat -tlnp</code></li>
  <li>Find which port in the range 8000-9000 has a listener.</li>
  <li>Connect to it and read what it says. <code>curl http://localhost:<PORT></code> or <code>nc localhost <PORT></code></li>
  <li>The response <strong>is</strong> the password.</li>
</ol>

---

### Key Commands

| Command | Purpose |
| ------- | ------- |
| `ss -tlnp` | Show TCP listening ports with process info |
| `ss -tuln` | Show TCP and UDP listening ports |
| `netstat -tlnp` | Similar to ss (older tool) |
| `ss -an \| grep LISTEN` | Filter for listening sockets |

### How `ss` and `netstat` Work

```bash
# ss - socket statistics (modern replacement for netstat)
ss -t                                   # TCP connections
ss -u                                   # UDP connections
ss -l                                   # listening sockets only
ss -n                                   # numeric (don't resolve names)
ss -p                                   # show process using socket
ss -tlnp                                # TCP listening, numeric, with processes

# Useful ss filters
ss -tlnp | grep :80                    # find what's on port 80
ss -tlnp | grep LISTEN                 # all listeners
ss state ESTABLISHED                   # established connections only
ss dst 192.168.1.1                     # connections to specific host

# netstat (older, may need net-tools package)
netstat -tlnp                          # TCP listening with processes
netstat -an | grep LISTEN              # all listeners
netstat -r                             # routing table
netstat -i                             # interface statistics

# Find what's using a specific port
ss -tlnp | grep :8080                 # using ss
lsof -i :8080                         # using lsof
fuser 8080/tcp                        # using fuser

# Check if a port is open
nc -zv localhost 80                   # test port 80 (verbose)
nc -zv localhost 8000-9000            # scan a range
timeout 3 bash -c 'cat < /dev/tcp/localhost/8080'  # bash TCP test

# Port scanning basics
for port in {8000..9000}; do
    (echo >/dev/tcp/localhost/$port) 2>/dev/null && echo "OPEN: $port"
done
```


<div class="hints" markdown="1">

> `ss -tlnp | awk '/808[0-9]/ {print $5}'` helps filter for ports in the 8080s.

> Once you find the port, `curl http://localhost:<PORT>` or `nc localhost <PORT>` connects to it.

</div>
---

!!! info "🔓 Unlock Room 40"

    Once you solve the puzzle, run:

    ```bash
    next <PASSWORD>
    ```
