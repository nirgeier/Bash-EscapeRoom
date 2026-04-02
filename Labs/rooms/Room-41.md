---
password: "resolve9"
title_prefix: "🔌 "
summary: "Use netcat (nc) to communicate with a local service and retrieve the key."
---

[![Room-41](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-41.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-41.yml)


**OPEN THE NETCAT TUNNEL!**

---

## 🔌 The Netcat Tunnel

- A secret server is listening, waiting for the magic word.
- Send it the right message using `nc` and receive the key.

---

!!! abstract "📜 Mission Briefing"

    A server is listening on `localhost` port `4444`.

    1. Connect to the server using `nc`.
       > hint: `nc localhost 4444`
    2. The server will ask: `SEND THE MAGIC WORD:`
    3. Type the magic word: `OPEN`
    4. The server will respond with the password.

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

### Hints

!!! tip "Hint 1"

    `echo "OPEN" | nc localhost 4444` sends the magic word and prints the response.

!!! tip "Hint 2"

    If the connection hangs, try `echo -e "OPEN\n" | nc -q 1 localhost 4444` to close after 1 second.

---

!!! info "🔓 Unlock Room 42"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_42/README -out ../room_42/README.txt -pass pass:PASSWORD
    cat ../room_42/README.txt
    ```
