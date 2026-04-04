# Bash Escape Room — VS Code Extension

> If you find this useful, please ⭐ **[star the repo on GitHub](https://github.com/nirgeier/Bash-EscapeRoom)** — it helps others discover it!

> Learn Bash by solving **57 escape-room puzzles** right inside VS Code.
> No Docker. No setup. Just install and start hacking.

<p align="center">
  <img src="https://raw.githubusercontent.com/nirgeier/Bash-EscapeRoom/main/.vscode-extension/media/screenshots/overview.png" width="900" alt="Overview"/>
</p>

---

## What You Get

- **Sidebar panel** — room list, progress bar, navigation controls, auto-save
- **Lesson panel** — styled room card with mission brief, numbered tasks, and hints
- **Integrated terminal** — bash shell pre-loaded with `next`, `room`, `progress` commands
- **57 rooms** — fully bundled, no repo clone needed

---

## Installation

1. Press `Ctrl+Shift+X` (or `Cmd+Shift+X` on Mac) → search **Bash Escape Room** → **Install**
2. Click the 🏃 icon in the Activity Bar to open the panel

---

## Getting Started

### 1. Open the Panel

Click the **🏃 icon** in the Activity Bar (left edge of VS Code).

<p align="center">
  <img src="https://raw.githubusercontent.com/nirgeier/Bash-EscapeRoom/main/.vscode-extension/media/screenshots/sidebar.png" width="320" alt="Sidebar panel"/>
</p>

The sidebar shows:
- Status dot (stopped / starting / running)
- **▶ Launch** and **■ Stop** buttons
- **⬛ Terminal** and **📖 Open Room** quick links
- Room navigator `‹ 01 / 57 ›` with a progress bar
- Full room list — click any room to jump directly

---

### 2. Launch

Click **▶ Launch** in the sidebar.

<p align="center">
  <img src="https://raw.githubusercontent.com/nirgeier/Bash-EscapeRoom/main/.vscode-extension/media/screenshots/launch.png" width="600" alt="Launch button"/>
</p>

The embedded server starts and **Room 01** opens automatically in the lesson panel.

---

### 3. Read the Room

The lesson panel shows everything you need to solve the room.

<p align="center">
  <img src="https://raw.githubusercontent.com/nirgeier/Bash-EscapeRoom/main/.vscode-extension/media/screenshots/lesson-panel.png" width="900" alt="Lesson panel"/>
</p>

Each room includes a mission brief, numbered tasks, hints, and command examples.

---

### 4. Open the Terminal

Click **⬛ Terminal** in the sidebar.

<p align="center">
  <img src="https://raw.githubusercontent.com/nirgeier/Bash-EscapeRoom/main/.vscode-extension/media/screenshots/terminal-button.png" width="600" alt="Terminal button"/>
</p>

A bash shell opens **inside the current room's directory**, with these commands available:

| Command      | Description                    |
| ------------ | ------------------------------ |
| `next`       | Move to the next room          |
| `room <N>`   | Jump directly to room N        |
| `progress`   | Show saved progress            |
| `resume`     | Return to your last saved room |

<p align="center">
  <img src="https://raw.githubusercontent.com/nirgeier/Bash-EscapeRoom/main/.vscode-extension/media/screenshots/terminal.png" width="700" alt="Terminal"/>
</p>

---

### 5. Solve & Advance

Work through the **Tasks** shown in the lesson panel.

<p align="center">
  <img src="https://raw.githubusercontent.com/nirgeier/Bash-EscapeRoom/main/.vscode-extension/media/screenshots/tasks.png" width="900" alt="Tasks"/>
</p>

Once you find the password, run in the terminal:

```bash
next
```

Or jump to any room directly:

```bash
room 14
```

---

### 6. Track Progress

<p align="center">
  <img src="https://raw.githubusercontent.com/nirgeier/Bash-EscapeRoom/main/.vscode-extension/media/screenshots/rooms-list.png" width="320" alt="Room list with checkmarks"/>
</p>

- Completed rooms show a **green checkmark** in the sidebar list
- Progress is **saved automatically** on every room switch
- On next VS Code launch the extension **resumes from your last room**

---

## Room List

| Rooms | Topic                                                   |
| ----- | ------------------------------------------------------- |
| 01–06 | find, grep, head/tail, sed, base64, sort/uniq           |
| 07–09 | chmod, env/export, ps/kill                              |
| 10–13 | awk, tar/gzip, cut/pipes, ln                            |
| 14–16 | curl/wget, jq, df/du                                    |
| 17–25 | crontab, diff/patch, hashing, xxd, strings, date        |
| 26–32 | Parameter expansion, arrays, for/while loops, functions |
| 33–38 | getopts, heredocs, process substitution, trap, read     |
| 39–43 | ss/netstat, dig, netcat, lsof, strace                   |
| 44–56 | rsync, openssl, vim, ssh, git, advanced pipelines       |

---

## Commands

`Ctrl+Shift+P` / `Cmd+Shift+P`:

| Command                                 | Description                    |
| --------------------------------------- | ------------------------------ |
| `Bash Escape Room: Launch`              | Start the server and open Room 1 |
| `Bash Escape Room: Stop`                | Stop the server                  |
| `Bash Escape Room: Open Terminal Panel` | Open the bash terminal           |
| `Bash Escape Room: Open Current Room`   | Re-open the current room panel   |

---

## Settings

`Settings → Extensions → Bash Escape Room`:

| Setting               | Default | Description                         |
| --------------------- | ------- | ----------------------------------- |
| `bashEscapeRoom.port` | `3000`  | Port the embedded server listens on |

---

## Requirements

| Requirement   | Notes                                               |
| ------------- | --------------------------------------------------- |
| VS Code 1.85+ | Any platform — Windows, macOS, Linux                |
| `bash`        | macOS/Linux built-in; Windows needs WSL or Git Bash |

> All 57 rooms are bundled inside the extension — no Docker, no repo clone needed.

---

## Troubleshooting

**`next` / `room` not found**
→ Close the terminal and click **⬛ Terminal** again to open a fresh session.

**Room panel blank after reload**
→ `Cmd+Shift+P` → **Developer: Reload Window**

**Port 3000 in use**
→ Change `bashEscapeRoom.port` in Settings (e.g. `3001`).

---

## License

MIT © [nirgeier](https://github.com/nirgeier)
