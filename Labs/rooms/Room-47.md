---
title: "(Room 47) 🛰️ The Remote Gateway"
password: "vimmode"
title_prefix: "🛰️ "
summary: "Generate an SSH key pair and use it to authenticate to a local service."
---

[![Room-47](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-47.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-47.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 47</span>
  <div class="room-title">
    <span class="room-title-accent">🛰️ The</span>
    <span class="room-title-main">Remote Gateway</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Generate an SSH key pair and use it to authenticate to a local service.

- A remote vault only accepts SSH key authentication.
- Generate a key pair and use it to retrieve the secret.

</div>

---

### OPEN THE REMOTE GATEWAY!

<ol class="tasks">
  <li>Generate an SSH key pair. <code>ssh-keygen -t rsa -f /tmp/escape_key -N ""</code></li>
  <li>Add the public key to the authorized list. <code>./setup_ssh_access.sh /tmp/escape_key.pub</code></li>
  <li>Connect using your new key. <code>ssh -i /tmp/escape_key -o StrictHostKeyChecking=no escape@localhost</code></li>
  <li>The SSH session will show the password immediately upon login.</li>
</ol>

---

### Key Commands

| Command | Purpose |
| --- | --- |
| `ssh user@host` | Connect to remote host |
| `ssh -p 2222 user@host` | Connect on non-default port |
| `ssh -i ~/.ssh/key user@host` | Use specific identity file |
| `ssh -L 8080:localhost:80 user@host` | Local port forwarding |
| `ssh -R 8080:localhost:80 user@host` | Remote port forwarding |
| `ssh -N -f user@host` | Background tunnel (no shell) |
| `ssh -o StrictHostKeyChecking=no user@host` | Skip host key check |
| `ssh user@host 'cmd'` | Run command remotely |
| `ssh-keygen -t rsa -f ~/.ssh/id_rsa` | Generate rsa key |
| `ssh-keygen -t rsa -b 4096` | Generate 4096-bit RSA key |
| `ssh-keygen -p -f ~/.ssh/key` | Change passphrase |
| `ssh-copy-id user@host` | Copy public key to remote |
| `ssh-add ~/.ssh/key` | Add key to SSH agent |
| `ssh-agent bash` | Start SSH agent |
| `scp file user@host:/path/` | Copy file to remote |
| `scp user@host:/path/file .` | Copy file from remote |
| `scp -r dir/ user@host:/path/` | Recursive copy |
| `scp -P 2222 file user@host:/path/` | SCP on custom port |

### How SSH Works

```bash
# Generate key pairs
ssh-keygen -t rsa -b 4096              # RSA 4096-bit key
ssh-keygen -t rsa                  # rsa key (modern, recommended)
ssh-keygen -t rsa -f ~/.ssh/mykey  # specify filename
ssh-keygen -t rsa -N ""           # no passphrase (for automation)
# Creates: ~/.ssh/id_rsa (private) and ~/.ssh/id_rsa.pub (public)

# Connect with SSH
ssh user@hostname                      # connect (uses default key)
ssh -p 2222 user@hostname             # non-standard port
ssh -i ~/.ssh/mykey user@host         # specify key file
ssh -o StrictHostKeyChecking=no user@host  # skip host key verification

# Copy public key to remote server
ssh-copy-id user@hostname              # copies ~/.ssh/id_*.pub
ssh-copy-id -i mykey.pub user@host   # specify key to copy

# Run commands remotely
ssh user@host "ls -la /home"          # run a single command
ssh user@host "cat /etc/hostname"     # read remote file
ssh user@host < local_script.sh       # run local script on remote

# SCP - secure copy
scp file.txt user@host:/remote/path/  # copy to remote
scp user@host:/remote/file.txt .      # copy from remote
scp -r dir/ user@host:/path/          # recursive directory copy
scp -P 2222 file.txt user@host:/path/ # non-standard port

# SSH config file (~/.ssh/config)
# Host myserver
#   HostName 192.168.1.100
#   User alice
#   IdentityFile ~/.ssh/mykey
#   Port 2222
# Then just: ssh myserver
```


<div class="hints" markdown="1">

> `ssh-keygen -t rsa -f /tmp/escape_key -N ""` creates the key without a passphrase.

> `-o StrictHostKeyChecking=no` prevents the "unknown host" prompt when connecting.

</div>
---

!!! info "🔓 Unlock Room 48"

    Once you solve the puzzle, run:

    ```bash
    next <PASSWORD>
    ```
