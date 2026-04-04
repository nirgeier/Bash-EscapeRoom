# Promotional Posts - Bash Escape Room VS Code Extension

## Reddit - r/bash, r/commandline, r/vscode

**Title:** I built a Bash escape room - 57 puzzle rooms inside VS Code (free)

**Body:**
```
Hey r/bash!

I've been working on an open-source Bash learning project and just shipped it as a VS Code extension.

**Bash Escape Room** - 57 interactive escape-room challenges, each teaching a real Bash skill.

Rooms cover: find/grep/sed/awk, permissions, processes, pipes, scripting, networking, git, openssl, and more.

- No Docker, no setup - install and start hacking immediately
- Integrated terminal pre-loaded with `next`, `room <N>`, `progress` commands
- Tracks progress, auto-saves, resumes on next launch
- Fully open source (MIT)

VS Code Marketplace: https://marketplace.visualstudio.com/items?itemName=nirgeier.EscapeRoom-Bash
GitHub: https://github.com/nirgeier/Bash-EscapeRoom

Would love feedback on the room difficulty curve and any commands you think are missing!
```

---

## dev.to Post

**Title:** Learn Bash by breaking out of 57 escape rooms - inside VS Code

**Tags:** bash, vscode, terminal, beginners

**Body:**
```markdown
# Learn Bash by breaking out of 57 escape rooms

I've always found that the best way to learn command-line tools is through challenges - not tutorials.

So I built **Bash Escape Room**: 57 progressively harder puzzles, each centered on a real Bash skill.

## What it looks like

Each room drops you into a scenario:
- *"You're an explorer lost in a filesystem - find the hidden coordinates file"* → teaches `find`, `cat`, `sort`
- *"Decrypt the spy cipher"* → teaches `sed`
- *"Escape the hex dungeon"* → teaches `xxd`, `od`, `hexdump`

## How it works

Install the VS Code extension. Click Launch. A terminal opens pre-loaded with navigation commands:

```bash
next          # move to the next room
room 14       # jump to room 14
progress      # show saved progress
```

Work through the tasks shown in the lesson panel, find the password, run `next`.

## Room topics

| Rooms | Topic |
|-------|-------|
| 01–06 | find, grep, head/tail, sed, base64, sort/uniq |
| 07–09 | chmod, env/export, ps/kill |
| 10–13 | awk, tar/gzip, cut/pipes, ln |
| 14–16 | curl/wget, jq, df/du |
| 17–25 | crontab, diff/patch, hashing, xxd, strings, date |
| 26–32 | Parameter expansion, arrays, for/while loops, functions |
| 33–38 | getopts, heredocs, process substitution, trap, read |
| 39–43 | ss/netstat, dig, netcat, lsof, strace |
| 44–56 | rsync, openssl, vim, ssh, git, advanced pipelines |

## Links

- VS Code Marketplace: https://marketplace.visualstudio.com/items?itemName=nirgeier.EscapeRoom-Bash
- GitHub (MIT): https://github.com/nirgeier/Bash-EscapeRoom
- Web version: https://nirgeier.github.io/Bash-EscapeRoom

Feedback and PRs welcome!
```

---

## LinkedIn Post

```
🚀 Just shipped a VS Code extension I've been building for months.

𝗕𝗮𝘀𝗵 𝗘𝘀𝗰𝗮𝗽𝗲 𝗥𝗼𝗼𝗺 - learn Bash by solving 57 escape-room puzzles, right inside VS Code.

Each room is a story-driven challenge:
🔍 Lost expedition → learn `find`
🔐 Spy cipher → learn `sed`
📡 Network hub → learn `ss`, `netstat`, `dig`
🗝️ Cryptographer's Den → learn `openssl`

No Docker. No browser. No setup. Install → Launch → Start hacking.

✅ Integrated terminal with navigation commands (`next`, `room 14`, `progress`)
✅ Tracks and saves your progress automatically
✅ 57 rooms covering find, grep, awk, sed, curl, jq, git, ssh, openssl, and more
✅ Fully open source (MIT)

👉 VS Code Marketplace: https://marketplace.visualstudio.com/items?itemName=nirgeier.EscapeRoom-Bash
👉 GitHub: https://github.com/nirgeier/Bash-EscapeRoom

If you know someone learning Linux/Bash - share it with them!

#bash #linux #vscode #devtools #opensource #terminal #learning
```

---

## awesome-bash PR Description

**Repo:** awesome-lists/awesome-bash
**File:** README.md
**Section:** Learning

```markdown
## Proposed addition

Under **Learning** section, add:

- [Bash Escape Room](https://github.com/nirgeier/Bash-EscapeRoom) - 57 interactive escape-room challenges teaching Bash skills progressively; available as a VS Code extension and a web app.
```

---

## awesome-vscode PR Description

**Repo:** viatsko/awesome-vscode (or similar)
**File:** README.md
**Section:** Tools / Learning

```markdown
## Proposed addition

Under a relevant section (Tools, Learning, or Terminal):

- [Bash Escape Room](https://marketplace.visualstudio.com/items?itemName=nirgeier.EscapeRoom-Bash) - Learn Bash through 57 escape-room puzzle rooms inside VS Code, with integrated terminal, progress tracking, and lesson panels.
```
