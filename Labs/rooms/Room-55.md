---
title: "(Room 55) 🔍 The System Inspector"
password: "sysinfo9"
title_prefix: "🔍 "
summary: "Inspect system identity: kernel version, hostname, user info, and logged-in sessions."
---

[![Room-55](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-55.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-55.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 55</span>
  <div class="room-title">
    <span class="room-title-accent">🔍 The</span>
    <span class="room-title-main">System Inspector</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Inspect system identity: kernel version, hostname, user info, and logged-in sessions.

- You've entered an uncharted system with no documentation and no map.
- Your mission: identify it completely using system inspection commands.

</div>

---

### IDENTIFY THE SYSTEM!

<ol class="tasks">
  <li>Get the complete system information in one line. <code>uname -a</code></li>
  <li>Find out the system's network name. <code>hostname</code></li>
  <li>Confirm your user identity - uid, gid, and group memberships. <code>id</code></li>
  <li>See who else is currently logged in. <code>who</code></li>
  <li>Run <code>./getKey.sh</code> with your username and OS kernel name as arguments. <code>./getKey.sh "$(whoami)" "$(uname -s)"</code></li>
</ol>

---

### Key Commands

| Command               | Purpose                                                |
| --------------------- | ------------------------------------------------------ |
| `uname`               | Print the OS/kernel name                               |
| `uname -a`            | All system info: kernel, hostname, release, arch       |
| `uname -r`            | Kernel release version (e.g. `5.15.0-91-generic`)      |
| `uname -n`            | Network node hostname (same as `hostname`)             |
| `uname -m`            | Machine hardware architecture (e.g. `x86_64`, `arm64`) |
| `uname -s`            | Kernel name (`Linux`, `Darwin`, `FreeBSD`)             |
| `uname -v`            | Kernel build version string                            |
| `uname -p`            | Processor type                                         |
| `hostname`            | Display the system's short hostname                    |
| `hostname -f`         | Display the fully qualified domain name (FQDN)         |
| `hostname -I`         | Show all assigned IP addresses                         |
| `whoami`              | Print the effective (current) username                 |
| `id`                  | Show uid, gid, and all supplementary groups            |
| `id username`         | Show uid/gid/groups for a named user                   |
| `id -u`               | Print only the numeric user ID                         |
| `id -un`              | Print only the username (equivalent to `whoami`)       |
| `who`                 | Show currently logged-in users and their terminals     |
| `w`                   | Like `who` but also shows what each user is running    |
| `last`                | Show login history from `/var/log/wtmp`                |
| `last -n 10`          | Show the 10 most recent login records                  |
| `lscpu`               | Detailed CPU architecture and topology info            |
| `arch`                | Print the machine architecture (short form)            |
| `cat /etc/os-release` | Linux distribution name, version, and ID               |

### How `uname`, `hostname`, `id`, and `who` Work

```bash
# --- uname ---
uname                              # Linux
uname -s                           # Linux   (Darwin on macOS)
uname -r                           # 5.15.0-91-generic
uname -m                           # x86_64  (arm64 on Apple Silicon)
uname -n                           # myhost.local
uname -a                           # Linux myhost 5.15.0 #1 SMP x86_64 GNU/Linux

# Use in scripts to detect the OS:
OS=$(uname -s)
if [ "$OS" = "Linux" ]; then
    echo "Running on Linux"
elif [ "$OS" = "Darwin" ]; then
    echo "Running on macOS"
fi

# --- hostname ---
hostname                           # myhost
hostname -f                        # myhost.corp.example.com
hostname -I                        # 192.168.1.42 10.0.0.1

# --- whoami / id ---
whoami                             # alice
id                                 # uid=1000(alice) gid=1000(alice) groups=1000(alice),27(sudo),998(docker)
id -u                              # 1000
id -g                              # 1000
id -un                             # alice  (same as whoami)
id -Gn                             # alice sudo docker  (all group names)
id root                            # uid=0(root) gid=0(root) groups=0(root)

# --- who / w / last ---
who                                # alice   pts/0  2024-03-10 09:15 (192.168.1.5)
w                                  # shows user, terminal, login time, idle, CPU, command
last -n 5                          # 5 most recent logins
last reboot                        # show all reboots

# --- architecture & distro ---
lscpu | grep "Architecture"        # Architecture: x86_64
arch                               # x86_64
cat /etc/os-release                # NAME="Ubuntu" VERSION="22.04.3 LTS" ...

# Combine for a system fingerprint:
echo "Host: $(hostname) | OS: $(uname -s) $(uname -r) | Arch: $(uname -m) | User: $(id -un)"
```


<div class="hints" markdown="1">

> `uname -s` returns `Linux` on Linux systems and `Darwin` on macOS - the result is case-sensitive. Use it in scripts to write cross-platform code that branches based on the operating system.

> `id -u` returns just the numeric uid; `id -un` returns just the username string - both are more reliable in scripts than parsing the full `id` output. Either is equivalent to running `whoami`.

</div>
---

!!! info "🔓 Unlock Room 56"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_56/README -out ../room_56/README.txt -pass pass:PASSWORD
    cat ../room_56/README.txt
    ```
