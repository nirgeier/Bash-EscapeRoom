---
title: "(Room 48) 🌿 The Version Vault"
password: "sshkey"
title_prefix: "🌿 "
summary: "Use git to explore a repository's history and recover a deleted secret."
---

[![Room-48](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-48.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-48.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 48</span>
  <div class="room-title">
    <span class="room-title-accent">🌿 The</span>
    <span class="room-title-main">Version Vault</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Use git to explore a repository's history and recover a deleted secret.

- A secret was committed to a git repository, then immediately deleted.
- Nothing is truly gone from git history - find the lost commit!

</div>

---

### RECOVER THE LOST COMMIT!

<ol class="tasks">
  <li>Navigate into the repository. <code>cd vault_repo</code></li>
  <li>View the commit history. <code>git log --oneline</code></li>
  <li>Find the commit where <code>secret.txt</code> was added (then later deleted).</li>
  <li>Check out or show that specific commit's content. <code>git show <COMMIT_HASH>:secret.txt</code></li>
  <li>The content of <code>secret.txt</code> from that commit <strong>is</strong> the password.</li>
</ol>

---

### Key Commands

| Command                         | Purpose                      |
| ------------------------------- | ---------------------------- |
| `git log`                       | Show commit history          |
| `git log --oneline`             | Compact one-line history     |
| `git log --graph --oneline`     | Graph view of branches       |
| `git log -n 10`                 | Last 10 commits              |
| `git log --all`                 | Show all branches            |
| `git log --author="name"`       | Filter by author             |
| `git log --since="2 weeks ago"` | Filter by date               |
| `git log -- file`               | History for specific file    |
| `git show HASH`                 | Show a specific commit       |
| `git show HASH:file`            | Show file at specific commit |
| `git diff HEAD~1`               | Changes since last commit    |
| `git diff branch1..branch2`     | Compare two branches         |
| `git checkout HASH -- file`     | Restore file from old commit |
| `git stash`                     | Stash uncommitted changes    |
| `git stash pop`                 | Restore stashed changes      |
| `git bisect start`              | Binary search for bug commit |
| `git reflog`                    | Show all HEAD movements      |
| `git blame file`                | Show who changed each line   |

### How `git` History Works

```bash
# View history
git log                                 # full commit log
git log --oneline                      # compact: hash + message
git log --oneline --graph              # visual branch graph
git log --oneline --all                # include all branches
git log --follow -- filename.txt       # history for a specific file
git log --oneline -10                  # last 10 commits

# Inspect commits
git show abc1234                        # full diff for commit
git show abc1234:path/to/file          # file content at that commit
git show HEAD                           # most recent commit
git show HEAD~1                         # one commit before HEAD
git show HEAD~3:config.json            # file 3 commits ago

# Compare commits
git diff abc1234 def5678               # diff between two commits
git diff HEAD~2 HEAD -- file.txt      # how file changed in last 2 commits

# Find when something changed
git log -p -- secret.txt               # show patches for a file
git log --diff-filter=A -- secret.txt  # find when file was Added
git log --diff-filter=D -- secret.txt  # find when file was Deleted
git log -S "password" --oneline        # find commits that added "password"

# Restore from history
git checkout abc1234 -- file.txt       # restore file from a commit
git show abc1234:file.txt > recovered.txt  # save to new file
```


<div class="hints" markdown="1">

> `git log --oneline` shows a concise list - look for a commit message mentioning "secret".

> `git show <HASH>:secret.txt` shows the file content without checking out anything.

</div>
---

!!! info "🔓 Unlock Room 49"

    Once you solve the puzzle, run:

    ```bash
    next <PASSWORD>
    ```
