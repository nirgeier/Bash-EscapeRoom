---
password: "vimmode"
title_prefix: "🛰️ "
summary: "Generate an SSH key pair and use it to authenticate to a local service."
---

**OPEN THE REMOTE GATEWAY!**

---

## 🛰️ The Remote Gateway

- A remote vault only accepts SSH key authentication.
- Generate a key pair and use it to retrieve the secret.

---

!!! abstract "📜 Mission Briefing"

    A service running locally only allows key-based authentication.

    1. Generate an SSH key pair.
       > hint: `ssh-keygen -t ed25519 -f /tmp/escape_key -N ""`
    2. Add the public key to the authorized list.
       > hint: `./setup_ssh_access.sh /tmp/escape_key.pub`
    3. Connect using your new key.
       > hint: `ssh -i /tmp/escape_key -o StrictHostKeyChecking=no escape@localhost`
    4. The SSH session will show the password immediately upon login.

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
| `ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519` | Generate Ed25519 key |
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
ssh-keygen -t ed25519                  # Ed25519 key (modern, recommended)
ssh-keygen -t ed25519 -f ~/.ssh/mykey  # specify filename
ssh-keygen -t ed25519 -N ""           # no passphrase (for automation)
# Creates: ~/.ssh/id_ed25519 (private) and ~/.ssh/id_ed25519.pub (public)

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

### Hints

!!! tip "Hint 1"

    `ssh-keygen -t ed25519 -f /tmp/escape_key -N ""` creates the key without a passphrase.

!!! tip "Hint 2"

    `-o StrictHostKeyChecking=no` prevents the "unknown host" prompt when connecting.

---

!!! info "🔓 Unlock Room 48"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_48/README -out ../room_48/README.txt -pass pass:PASSWORD
    cat ../room_48/README.txt
    ```
