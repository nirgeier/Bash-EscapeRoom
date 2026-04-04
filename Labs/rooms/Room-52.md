---
title: "(Room 52) 🏛️ The Ownership Vault"
password: "chownit"
title_prefix: "🏛️ "
summary: "Fix file ownership with chown and chgrp, and control default permissions with umask."
---

[![Room-52](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-52.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-52.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 52</span>
  <div class="room-title">
    <span class="room-title-accent">🏛️ The</span>
    <span class="room-title-main">Ownership Vault</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Fix file ownership with chown and chgrp, and control default permissions with umask.

- Files in the Ownership Vault have been scrambled - wrong owners, wrong groups.
- The vault's locking mechanism checks ownership before granting access.

</div>

---

### RECLAIM THE VAULT!

<ol class="tasks">
  <li>Inspect the current ownership of all files in <code>vault/</code>. <code>ls -la vault/</code></li>
  <li>Check your own user and group identity. <code>id</code></li>
  <li>Read <code>requirements.txt</code> to see what each file's owner and group should be. <code>cat requirements.txt</code></li>
  <li>Fix ownership of each file using <code>chown</code> or <code>chgrp</code> as required. <code>chown user:group vault/filename</code></li>
  <li>Set the correct default permission mask using <code>umask</code>. <code>umask 022</code></li>
  <li>Run <code>./getKey.sh</code> to validate all ownership and retrieve the password. <code>./getKey.sh</code></li>
</ol>

---

### Key Commands

| Command                      | Purpose                                         |
| ---------------------------- | ----------------------------------------------- |
| `chown user file`            | Change the owner of a file                      |
| `chown user:group file`      | Change both owner and group in one step         |
| `chown :group file`          | Change only the group (owner unchanged)         |
| `chown -R user:group dir/`   | Recursively change owner and group              |
| `chown --reference=ref file` | Copy ownership from a reference file            |
| `chgrp group file`           | Change the group of a file                      |
| `chgrp -R group dir/`        | Recursively change group of a directory         |
| `umask`                      | Display the current umask value                 |
| `umask 022`                  | Set umask (removes write for group and others)  |
| `umask 077`                  | Restrictive: new files are owner-only (600/700) |
| `umask -S`                   | Show symbolic umask (e.g. `u=rwx,g=rx,o=rx`)    |
| `id`                         | Show current user's uid, gid, and all groups    |
| `id username`                | Show uid/gid/groups for a specific user         |
| `groups`                     | List all groups the current user belongs to     |
| `stat -c "%U %G %a" file`    | Show owner, group, and octal permissions        |
| `ls -la`                     | Long listing with owner and group columns       |

### How `chown`, `chgrp`, and `umask` Work

```bash
# --- chown ---
chown alice file.txt               # change owner to alice
chown alice:devs file.txt          # change owner to alice, group to devs
chown :devs file.txt               # change group only (same as chgrp devs)
chown -R www-data:www-data /var/www/html  # recursive, common web server pattern
chown --reference=/etc/passwd shadow.bak  # copy ownership from /etc/passwd

# --- chgrp ---
chgrp staff report.pdf             # change group to staff
chgrp -R docker /var/run/docker.sock   # recursive group change

# --- umask math ---
# umask removes bits from the default permissions:
#   Default file permissions: 666 (rw-rw-rw-)
#   Default dir  permissions: 777 (rwxrwxrwx)
#   umask 022 removes write (2) from group and other:
#     666 - 022 = 644  (rw-r--r--)  for new files
#     777 - 022 = 755  (rwxr-xr-x)  for new dirs
umask           # show current: e.g. 0022
umask 022       # standard: owner full, group/other read only
umask 027       # stricter: group read only, others no access
umask 077       # private:  owner only
umask -S        # symbolic view: u=rwx,g=rx,o=rx

# --- stat ---
stat -c "%U %G %a" /etc/passwd     # root root 644
stat -c "%n %U %G" vault/*         # name, owner, group for all files

# --- check identity ---
id                                 # uid=1000(alice) gid=1000(alice) groups=...
id -u                              # numeric uid only
id -g                              # numeric gid only
id -un                             # username only (same as whoami)
groups                             # alice adm sudo docker
```


<div class="hints" markdown="1">

> `chown user:group file` sets both owner and group in a single command.

`chown :group file` sets only the group - useful when you don't want to change the owner.
`chgrp group file` is equivalent to `chown :group file`.
> Use `stat -c "%U %G %a" <file>` to quickly verify the owner, group, and octal permissions of a file after you make changes - much faster than reading `ls -la` output manually.

</div>
---

!!! info "🔓 Unlock Room 53"

    Once you solve the puzzle, run:

    ```bash
    next <PASSWORD>
    ```
