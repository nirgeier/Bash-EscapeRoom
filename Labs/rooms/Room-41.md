---
title: "(Room 41) 🔌 The Netcat Tunnel"
password: "resolve9"
title_prefix: "🔌 "
summary: "Use netcat (nc) to communicate with a local service and retrieve the key."
---

[![Room-41](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-41.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-41.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 41</span>
  <div class="room-title">
    <span class="room-title-accent">🔌 The</span>
    <span class="room-title-main">Netcat Tunnel</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Use netcat (nc) to communicate with a local service and retrieve the key.

- A secret server is listening, waiting for the magic word.
- Send it the right message using `nc` and receive the key.

</div>

---

### OPEN THE NETCAT TUNNEL!

<ol class="tasks">
  <li>Connect to the server using <code>nc</code>. <code>nc localhost 4444</code></li>
  <li>The server will ask: <code>SEND THE MAGIC WORD:</code></li>
  <li>Type the magic word: <code>OPEN</code></li>
  <li>The server will respond with the password.</li>
</ol>

---

### Key Commands

| Command | Purpose |
| ------- | ------- |
| `nc host port` | Connect to a TCP server |
| `nc -l -p PORT` | Listen on a port (create a server) |
| `nc -z host port` | Test if port is open (no data) |
| `nc -u host port` | Use UDP instead of TCP |
| `echo "msg" \| nc host port` | Send a message and exit |

### How `nc` (netcat) Works

```bash
# Connect to a server
nc localhost 8080                       # connect and interact manually
nc 192.168.1.1 22                      # connect to SSH port
echo "hello" | nc localhost 1234       # send one message and exit
echo -e "GET / HTTP/1.0\n\n" | nc example.com 80  # manual HTTP request

# Listen / create a server
nc -l 4444                             # listen on port 4444
nc -l -p 4444                         # explicit -p flag
nc -l -k 4444                         # keep listening (accept multiple connections)

# File transfer with nc
# Receiver side:
nc -l 4444 > received_file.txt
# Sender side:
nc receiver-host 4444 < file_to_send.txt

# Port scanning
nc -zv localhost 20-25                 # scan ports 20-25 (verbose)
nc -z -w 2 host port                  # timeout after 2 seconds

# Test if a port is open
nc -z localhost 80 && echo "Port 80 is open"

# UDP communication
nc -u localhost 514                    # UDP connection
nc -u -l 514                          # UDP listener

# Send data one-shot
printf "OPEN\n" | nc localhost 4444   # send "OPEN" and close
```


<div class="hints" markdown="1">

> `echo "OPEN" | nc localhost 4444` sends the magic word and prints the response.

> If the connection hangs, try `echo -e "OPEN\n" | nc -q 1 localhost 4444` to close after 1 second.

</div>
---

!!! info "🔓 Unlock Room 42"

    Once you solve the puzzle, run:

    ```bash
    next <PASSWORD>
    ```
