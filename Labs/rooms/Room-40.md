---
title: "(Room 40) 🔮 The DNS Oracle"
password: "port80"
title_prefix: "🔮 "
summary: "Use dig and host to resolve DNS records and trace a domain to its secret."
---

[![Room-40](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-40.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-40.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 40</span>
  <div class="room-title">
    <span class="room-title-accent">🔮 The</span>
    <span class="room-title-main">DNS Oracle</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Use dig and host to resolve DNS records and trace a domain to its secret.

- An ancient domain holds the password encoded in its DNS records.
- Consult the oracle to reveal it.

</div>

---

### CONSULT THE DNS ORACLE!

<ol class="tasks">
  <li>Query the TXT records for <code>secret.escape.local</code>. <code>dig TXT secret.escape.local</code> or <code>host -t TXT secret.escape.local</code></li>
  <li>The TXT record value <strong>is</strong> the password. Note: In the Docker environment, this domain is configured in <code>/etc/hosts</code> or a local DNS server.</li>
  <li>If DNS is not available, the password is stored in <code>/etc/escape/dns_secret.txt</code>.</li>
</ol>

---

### Key Commands

| Command | Purpose |
| ------- | ------- |
| `dig domain` | Query DNS (A record by default) |
| `dig TXT domain` | Query TXT records |
| `dig MX domain` | Query mail exchange records |
| `host domain` | Simple DNS lookup |
| `nslookup domain` | Interactive DNS query tool |
| `getent hosts domain` | Resolve using system resolver |

### How `dig` and `host` Work

```bash
# dig - DNS lookup tool
dig example.com                         # A record (IPv4 address)
dig AAAA example.com                    # AAAA record (IPv6)
dig MX example.com                      # mail exchange records
dig TXT example.com                     # text records (SPF, DKIM, etc.)
dig NS example.com                      # name server records
dig CNAME www.example.com               # canonical name alias

# Short output
dig +short example.com                  # just the answer
dig +short TXT example.com              # just TXT values
dig @8.8.8.8 example.com               # use specific DNS server (Google)

# Reverse DNS lookup (IP to hostname)
dig -x 8.8.8.8                          # PTR record
dig -x 8.8.8.8 +short                  # just the hostname

# host - simpler alternative
host example.com                        # A record
host -t MX example.com                 # MX records
host -t TXT example.com                # TXT records
host 8.8.8.8                           # reverse lookup

# nslookup - interactive or one-shot
nslookup example.com                   # simple lookup
nslookup -type=TXT example.com        # TXT records
nslookup -type=MX example.com         # MX records
nslookup example.com 8.8.8.8          # use specific server

# System resolver
getent hosts example.com               # uses /etc/hosts + DNS
cat /etc/resolv.conf                   # see configured DNS servers
cat /etc/hosts                         # local host overrides
```


<div class="hints" markdown="1">

> `dig TXT secret.escape.local +short` gives just the TXT record value.

> If `dig` isn't available, try `host -t TXT secret.escape.local` or check `/etc/escape/dns_secret.txt`.

</div>
---

!!! info "🔓 Unlock Room 41"

    Once you solve the puzzle, run:

    ```bash
    next <PASSWORD>
    ```
