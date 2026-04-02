# Bash EscapeRoom Labs

<!-- header start -->
<div markdown style="text-align: center;border-radius: 20px;">
![Logo](assets/images/escape_room.png)
</div>

---

<img src="assets/images/tldr.png" style="width:100px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">

!!! success "Decryption Tip"

    If the content doesn't appear after entering the password in the selected room, please refresh the page (F5 or Ctrl+R).

---

<!-- markdownlint-disable MD033 -->
{% include "./assets/partials/usage.md" %}
<!-- markdownlint-enable MD033 -->

---

## Intro

- This tutorial is for teaching bash scripting through puzzles designed as escape rooms.
- Each room is packaged in its own folder and includes the files, scripts, and assets required to play.
- Every room folder includes a `README` that describes the room's objectives, hints, rules, and how to verify the solution.
- The Bash Escape Room is a series of bash puzzles (Escape-rooms, rooms similar to the real-life attractions of Escape rooms).
- The Bash Escape Room puzzles are designed to teach the players Bash and Linux skills & features.
- The inspiration for this project is the real-life Escape rooms.

---

## Pre-Requirements

- This tutorial will test your `Linux` and `Bash` skills.
- You should be familiar with the following topics:
  - Basic Linux commands
  - Linux File system navigation
  - Linux Text processing tools (like `grep`, `sed`, `awk`)
  - Linux Shell scripting basics
  - Linux Understanding of environment variables
  - Basic knowledge of `Docker` (if you choose to run it with Docker)
  - Basic knowledge of `Vim`

---

## Room Links

| Room                          | Title                       | Key Commands                                                   | Status                                                                                                                                                                       |
|-------------------------------|-----------------------------|----------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Room-01](./rooms/Room-01.md) | The Lost Expedition         | `find`, `cat`, `sort`, `xargs`                                 | [![Room-01](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-01.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-01.yml) |
| [Room-02](./rooms/Room-02.md) | The Broken Radio            | `grep`, `grep -c`, `wc -l`                                     | [![Room-02](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-02.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-02.yml) |
| [Room-03](./rooms/Room-03.md) | The Time Capsule            | `tac`, `rev`, `head`, `tail`, `wc`                             | [![Room-03](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-03.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-03.yml) |
| [Room-04](./rooms/Room-04.md) | The Spy Cipher              | `sed`, `sed 's/old/new/g'`                                     | [![Room-04](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-04.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-04.yml) |
| [Room-05](./rooms/Room-05.md) | The Decoder Ring            | `base64`, `tr` (ROT13), `rev`                                  | [![Room-05](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-05.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-05.yml) |
| [Room-06](./rooms/Room-06.md) | The Duplicate Detective     | `sort`, `uniq`, `comm`, `diff`                                 | [![Room-06](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-06.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-06.yml) |
| [Room-07](./rooms/Room-07.md) | The Permission Maze         | `chmod`, `stat`, `ls -l`                                       | [![Room-07](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-07.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-07.yml) |
| [Room-08](./rooms/Room-08.md) | The Environment Lab         | `export`, `env`, `source`, `alias`                             | [![Room-08](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-08.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-08.yml) |
| [Room-09](./rooms/Room-09.md) | The Ghost Process           | `ps`, `kill`, `jobs`, `bg`, `fg`                               | [![Room-09](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-09.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-09.yml) |
| [Room-10](./rooms/Room-10.md) | The Data Mine               | `awk`, `awk -F`, `NR`, `NF`                                    | [![Room-10](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-10.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-10.yml) |
| [Room-11](./rooms/Room-11.md) | The Nested Archive          | `base64 -d`, `gzip`, `tar`, `file`                             | [![Room-11](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-11.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-11.yml) |
| [Room-12](./rooms/Room-12.md) | The Grand Pipeline          | `cut`, `tr`, pipes                                             | [![Room-12](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-12.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-12.yml) |
| [Room-13](./rooms/Room-13.md) | The Mirror Maze             | `ln -s`, `readlink`, `readlink -f`                             | [![Room-13](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-13.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-13.yml) |
| [Room-14](./rooms/Room-14.md) | The Web Crawler             | `curl`, `curl -H`, `curl -s`                                   | [![Room-14](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-14.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-14.yml) |
| [Room-15](./rooms/Room-15.md) | The JSON Vault              | `jq`, `jq -r`, `select()`                                      | [![Room-15](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-15.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-15.yml) |
| [Room-16](./rooms/Room-16.md) | The Space Station           | `df -h`, `du -sh`, `sort -rh`                                  | [![Room-16](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-16.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-16.yml) |
| [Room-17](./rooms/Room-17.md) | The Clockwork Fortress      | `crontab -l`, cron expressions                                 | [![Room-17](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-17.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-17.yml) |
| [Room-18](./rooms/Room-18.md) | The Twin Blueprints         | `diff`, `diff -u`, `patch`                                     | [![Room-18](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-18.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-18.yml) |
| [Room-19](./rooms/Room-19.md) | The Integrity Check         | `md5sum`, `sha256sum`, `sha256sum -c`                          | [![Room-19](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-19.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-19.yml) |
| [Room-20](./rooms/Room-20.md) | The Hex Dungeon             | `xxd`, `xxd -r`, `od`, `hexdump`                               | [![Room-20](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-20.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-20.yml) |
| [Room-21](./rooms/Room-21.md) | The Binary Library          | `strings`, `strings -n`                                        | [![Room-21](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-21.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-21.yml) |
| [Room-22](./rooms/Room-22.md) | The Calculator Cave         | `bc`, `expr`, `$(( ))`                                         | [![Room-22](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-22.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-22.yml) |
| [Room-23](./rooms/Room-23.md) | The Time Machine            | `date`, `date -d @TIMESTAMP`                                   | [![Room-23](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-23.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-23.yml) |
| [Room-24](./rooms/Room-24.md) | The Formatter's Workshop    | `printf`, `echo -e`                                            | [![Room-24](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-24.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-24.yml) |
| [Room-25](./rooms/Room-25.md) | The Signal Crossroads       | `tee`, `tee -a`, `paste`                                       | [![Room-25](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-25.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-25.yml) |
| [Room-26](./rooms/Room-26.md) | The Variable Vault          | `${var##*/}`, `${var%/*}`, parameter expansion                 | [![Room-26](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-26.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-26.yml) |
| [Room-27](./rooms/Room-27.md) | The Array Arsenal           | `arr=()`, `${arr[@]}`, `mapfile`                               | [![Room-27](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-27.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-27.yml) |
| [Room-28](./rooms/Room-28.md) | The Loop Labyrinth          | `for` loops, `$(( ))`                                          | [![Room-28](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-28.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-28.yml) |
| [Room-29](./rooms/Room-29.md) | The Endless Corridor        | `while read`, `while IFS= read -r`                             | [![Room-29](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-29.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-29.yml) |
| [Room-30](./rooms/Room-30.md) | The Fork in the Road        | `if/elif/else`, `[ ]`, `[[ ]]`                                 | [![Room-30](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-30.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-30.yml) |
| [Room-31](./rooms/Room-31.md) | The Decision Chamber        | `case ... in`, pattern matching                                | [![Room-31](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-31.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-31.yml) |
| [Room-32](./rooms/Room-32.md) | The Function Factory        | `func(){}`, `local`, `return`                                  | [![Room-32](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-32.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-32.yml) |
| [Room-33](./rooms/Room-33.md) | The Argument Decoder        | `getopts`, `$OPTARG`                                           | [![Room-33](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-33.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-33.yml) |
| [Room-34](./rooms/Room-34.md) | The Ancient Scroll          | `<< 'EOF'`, here-documents                                     | [![Room-34](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-34.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-34.yml) |
| [Room-35](./rooms/Room-35.md) | The Nested Worlds           | `$()`, `<(cmd)`, process substitution                          | [![Room-35](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-35.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-35.yml) |
| [Room-36](./rooms/Room-36.md) | The Signal Tower            | `trap`, `kill -SIGUSR1`                                        | [![Room-36](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-36.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-36.yml) |
| [Room-37](./rooms/Room-37.md) | The Interactive Gateway     | `read`, `read -p`, `read -s`                                   | [![Room-37](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-37.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-37.yml) |
| [Room-38](./rooms/Room-38.md) | The Time Bomb               | `timeout`, `watch`, `sleep`                                    | [![Room-38](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-38.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-38.yml) |
| [Room-39](./rooms/Room-39.md) | The Network Hub             | `ss -tlnp`, `netstat -tlnp`                                    | [![Room-39](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-39.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-39.yml) |
| [Room-40](./rooms/Room-40.md) | The DNS Oracle              | `dig`, `host`, `nslookup`                                      | [![Room-40](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-40.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-40.yml) |
| [Room-41](./rooms/Room-41.md) | The Netcat Tunnel           | `nc`, `nc -l`                                                  | [![Room-41](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-41.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-41.yml) |
| [Room-42](./rooms/Room-42.md) | The Open Files Archive      | `lsof`, `lsof -p`, `lsof -i`                                   | [![Room-42](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-42.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-42.yml) |
| [Room-43](./rooms/Room-43.md) | The System Call Observatory | `strace`, `ltrace`                                             | [![Room-43](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-43.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-43.yml) |
| [Room-44](./rooms/Room-44.md) | The Mirror Sync             | `rsync -av`, `rsync --delete`                                  | [![Room-44](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-44.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-44.yml) |
| [Room-45](./rooms/Room-45.md) | The Cryptographer's Den     | `openssl enc -d`, `openssl dgst`                               | [![Room-45](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-45.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-45.yml) |
| [Room-46](./rooms/Room-46.md) | The Vi Vortex               | `vim`, `NG`, `/pattern`                                        | [![Room-46](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-46.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-46.yml) |
| [Room-47](./rooms/Room-47.md) | The Remote Gateway          | `ssh-keygen`, `ssh -i`, `scp`                                  | [![Room-47](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-47.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-47.yml) |
| [Room-48](./rooms/Room-48.md) | The Version Vault           | `git log`, `git show HASH:file`                                | [![Room-48](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-48.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-48.yml) |
| [Room-49](./rooms/Room-49.md) | The Grand Pipeline II       | `awk`, `sort`, `uniq -c`, `sort -rn`                           | [![Room-49](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-49.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-49.yml) |
| [Room-50](./rooms/Room-50.md) | The Master Terminal         | `find`, `base64`, `grep`, `bc`, `sha256sum`                    | [![Room-50](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-50.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-50.yml) |
| [Room-51](./rooms/Room-51.md) | The Command Assembler       | `xargs`, `xargs -I{}`, `xargs -P`, `xargs -0`, `find \| xargs` | [![Room-51](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-51.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-51.yml) |
| [Room-52](./rooms/Room-52.md) | The Ownership Vault         | `chown`, `chgrp`, `umask`, `id`, `groups`, `stat`              | [![Room-52](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-52.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-52.yml) |
| [Room-53](./rooms/Room-53.md) | The Network Probe           | `ping`, `traceroute`, `tracepath`, `wget`, `wget -O -`         | [![Room-53](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-53.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-53.yml) |
| [Room-54](./rooms/Room-54.md) | The System Monitor          | `top`, `free`, `uptime`, `vmstat`, `/proc/meminfo`, `nproc`    | [![Room-54](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-54.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-54.yml) |
| [Room-55](./rooms/Room-55.md) | The System Inspector        | `uname`, `hostname`, `whoami`, `id`, `who`, `w`, `lscpu`       | [![Room-55](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-55.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-55.yml) |
| [Room-56](./rooms/Room-56.md) | The Process Controller      | `pgrep`, `pkill`, `nohup`, `nice`, `renice`, `killall`         | [![Room-56](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-56.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-56.yml) |
| [Room-99](./rooms/Room-99.md) | Final Exam                  | All commands                                                   | [![Room-99](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-99.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-99.yml) |

---

Good Luck!
