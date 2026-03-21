# Bash Escape Room Solutions

- Decrypt a room README with OpenSSL:

  ```bash
  PASSWORD=xxx
  ROOM_NUM=xxx

  cd ~/escapeRooms/room_$ROOM_NUM && \
  openssl enc -aes-256-cbc -d -a -pbkdf2 -in README -out README.txt -pass pass:$PASSWORD && \
  mv README.txt README && \
  cat README
  ```

## Password Chain

| Room | Encrypted With | Solution Gives |
| ---- | -------------- | -------------- |
| 01   | (open)         | northstar      |
| 02   | northstar      | signal59       |
| 03   | signal59       | rewind99       |
| 04   | rewind99       | sedmaster      |
| 05   | sedmaster      | translate      |
| 06   | translate      | unique37       |
| 07   | unique37       | access42       |
| 08   | access42       | export99       |
| 09   | export99       | daemon77       |
| 10   | daemon77       | awk2025        |
| 11   | awk2025        | layered7       |
| 12   | layered7       | pipeline       |
| 13   | pipeline       | link42         |
| 14   | link42         | webfetch       |
| 15   | webfetch       | json64         |
| 16   | json64         | modulereactor  |
| 17   | modulereactor  | cron5min       |
| 18   | cron5min       | patch13        |
| 19   | patch13        | hash256        |
| 20   | hash256        | deadbeef       |
| 21   | deadbeef       | hidden42       |
| 22   | hidden42       | calc1337       |
| 23   | calc1337       | epoch6026      |
| 24   | epoch6026      | format77       |
| 25   | format77       | teeoff         |
| 26   | teeoff         | expand99       |
| 27   | expand99       | array10        |
| 28   | array10        | loop50         |
| 29   | loop50         | while100       |
| 30   | while100       | branch3        |
| 31   | branch3        | matched7       |
| 32   | matched7       | funcret        |
| 33   | funcret        | optparse       |
| 34   | optparse       | heredoc5       |
| 35   | heredoc5       | nested42       |
| 36   | nested42       | sigcatch       |
| 37   | sigcatch       | readline       |
| 38   | readline       | timeout3       |
| 39   | timeout3       | port80         |
| 40   | port80         | resolve9       |
| 41   | resolve9       | ncat7          |
| 42   | ncat7          | openfd         |
| 43   | openfd         | syscall        |
| 44   | syscall        | synced         |
| 45   | synced         | cipher99       |
| 46   | cipher99       | vimmode        |
| 47   | vimmode        | sshkey         |
| 48   | sshkey         | commit42       |
| 49   | commit42       | pipeline9      |
| 50   | pipeline9      | masterkey      |
| 51   | masterkey      | chownit        |
| 52   | chownit        | netprobe       |
| 53   | netprobe       | monitor5       |
| 54   | monitor5       | sysinfo9       |
| 55   | sysinfo9       | procctrl       |
| 56   | procctrl       | allclear       |
| 100  | masterkey      | escaped        |

---

<details>
<summary>Room 01 - The Lost Expedition</summary>

**Commands:** `find`, `cat`, `sort`, `xargs`

```bash
cd ~/escapeRooms/room_01
find expedition/ -name "*.map" | sort | xargs cat
# Output: northstar
```

**Password:** `northstar`

</details>

<details>
<summary>Room 02 - The Broken Radio</summary>

**Commands:** `grep`, `wc`

```bash
cd ~/escapeRooms/room_02
grep -c "SOS" radio_intercepts.txt
# Output: 59
```

**Password:** `signal59` (the word "signal" + the count)

</details>

<details>
<summary>Room 03 - The Time Capsule</summary>

**Commands:** `tac`, `rev`, `head`, `wc`

```bash
cd ~/escapeRooms/room_03
wc -l time_capsule.txt
# Output: 99

tac time_capsule.txt | head -1 | rev
# Output: The secret word is: rewind
```

**Password:** `rewind99` (the word "rewind" + line count 99)

</details>

<details>
<summary>Room 04 - The Spy Cipher</summary>

**Commands:** `sed`

```bash
cd ~/escapeRooms/room_04
sed 's/Z7/s/g; s/Q3/e/g; s/X9/d/g; s/K1/m/g; s/J2/a/g; s/W8/t/g; s/P6/r/g' cipher.txt
# Last line reveals: The password for the next room is: sedmaster
```

**Password:** `sedmaster`

</details>

<details>
<summary>Room 05 - The Decoder Ring</summary>

**Commands:** `base64`, `tr`, `rev`, pipes

```bash
cd ~/escapeRooms/room_05
base64 -d encoded_message.txt | tr 'a-zA-Z' 'n-za-mN-ZA-M' | rev
# Output: translate
```

**Password:** `translate`

</details>

<details>
<summary>Room 06 - The Duplicate Detective</summary>

**Commands:** `sort`, `uniq`, `comm`, `wc`

```bash
cd ~/escapeRooms/room_06
comm -23 <(sort vault_a.txt | uniq) <(sort vault_b.txt | uniq) | wc -l
# Output: 37
```

**Password:** `unique37` (the word "unique" + the count)

</details>

<details>
<summary>Room 07 - The Permission Maze</summary>

**Commands:** `chmod`, `stat`, `ls -l`

```bash
cd ~/escapeRooms/room_07
chmod 755 gate_1
chmod 644 gate_2
chmod 700 gate_3
chmod 444 gate_4
chmod 775 gate_5
chmod 660 gate_6
chmod 511 gate_7
./getKey.sh
# Output: access42
```

**Password:** `access42`

</details>

<details>
<summary>Room 08 - The Environment Lab</summary>

**Commands:** `source`, `export`, `alias`, `env`

```bash
cd ~/escapeRooms/room_08
source .lab_config
export LAB_KEY=42
export EXPERIMENT=active
export SCIENTIST=darwin
alias labstatus='echo ready'
./getKey.sh
# Output: export99
```

**Password:** `export99`

</details>

<details>
<summary>Room 09 - The Ghost Process</summary>

**Commands:** `useradd`, `ps`, `kill`, `&` (background)

```bash
cd ~/escapeRooms/room_09
sudo adduser -D ghost_user
echo 'while true; do sleep 1; done' > ghost_loop.sh
chmod +x ghost_loop.sh
sudo -u ghost_user bash ./ghost_loop.sh &
PID=$(ps -eo pid,user,args | grep ghost_user | grep ghost_loop | grep -v grep | awk '{print $1}')
./getKey.sh $PID
# Output: daemon77
```

**Password:** `daemon77`

</details>

<details>
<summary>Room 10 - The Data Mine</summary>

**Commands:** `awk`

```bash
cd ~/escapeRooms/room_10
awk -F',' 'NR>1 && $2>50 {sum+=$3} END {print sum}' mine_data.csv
# Output: 2025
```

**Password:** `awk2025` (the word "awk" + the sum)

</details>

<details>
<summary>Room 11 - The Nested Archive</summary>

**Commands:** `base64`, `gzip`/`gunzip`, `tar`, `file`

```bash
cd ~/escapeRooms/room_11
base64 -d artifact.b64 > artifact.tar.gz
gunzip artifact.tar.gz
tar xf artifact.tar
cat secret_scroll.txt
# Reveals: layered7
```

**Password:** `layered7`

</details>

<details>
<summary>Room 12 - The Grand Pipeline</summary>

**Commands:** `cut`, `tr`, pipes

```bash
cd ~/escapeRooms/room_12
cut -d'|' -f1 stations.txt | cut -c1 | tr -d '\n' | tr 'A-Z' 'a-z'
# Output: pipeline
```

**Password:** `pipeline`

</details>

<details>
<summary>Room 13 - The Mirror Maze</summary>

**Commands:** `ln -s`, `readlink`, `cat`

```bash
cd ~/escapeRooms/room_13
readlink -f start.link
# Shows the chain ends at treasure.txt
cat start.link
# Output: link42
```

**Password:** `link42`

</details>

<details>
<summary>Room 14 - The Web Crawler</summary>

**Commands:** `curl`, `curl -H`

```bash
cd ~/escapeRooms/room_14
curl -s -H "X-Access-Key: escape" http://localhost:8080/secret
# Output: webfetch
# Fallback: cat backup_password.txt
```

**Password:** `webfetch`

</details>

<details>
<summary>Room 15 - The JSON Vault</summary>

**Commands:** `jq`, `jq -r`, `sort`, `tr`

```bash
cd ~/escapeRooms/room_15
jq -r '.agents[] | select(.status == "active") | .code' database.json | sort | tr -d '\n'
# Output: json64
```

**Password:** `json64`

</details>

<details>
<summary>Room 16 - The Space Station</summary>

**Commands:** `df -h`, `du -sh`, `sort -rh`

```bash
cd ~/escapeRooms/room_16
du -sh station/*/ | sort -rh | head -1
# Output: ...  station/reactor/
```

**Password:** `modulereactor` (the word "module" + directory name)

</details>

<details>
<summary>Room 17 - The Clockwork Fortress</summary>

**Commands:** `crontab`, cron expressions

```bash
cd ~/escapeRooms/room_17
cat schedule.cron
# Find the # ALARM line: */5 * * * *
# Interval = every 5 minutes
```

**Password:** `cron5min` (the word "cron" + the interval)

</details>

<details>
<summary>Room 18 - The Twin Blueprints</summary>

**Commands:** `diff`

```bash
cd ~/escapeRooms/room_18
diff blueprint_v1.txt blueprint_v2.txt | grep '^>'
# Output: > SecretCode: patch13
```

**Password:** `patch13`

</details>

<details>
<summary>Room 19 - The Integrity Check</summary>

**Commands:** `sha256sum`, `sha256sum -c`

```bash
cd ~/escapeRooms/room_19
sha256sum documents/*.txt
# Compare hashes against authentic.sha256
# Matching file (doc_4.txt) contains: hash256
cat documents/doc_4.txt
```

**Password:** `hash256`

</details>

<details>
<summary>Room 20 - The Hex Dungeon</summary>

**Commands:** `xxd`, `xxd -r`

```bash
cd ~/escapeRooms/room_20
xxd -r hex_message.hex
# Output: deadbeef
```

**Password:** `deadbeef`

</details>

<details>
<summary>Room 21 - The Binary Library</summary>

**Commands:** `strings`

```bash
cd ~/escapeRooms/room_21
strings vault_binary | grep "PASSWORD" | cut -d'=' -f2
# Output: hidden42
```

**Password:** `hidden42`

</details>

<details>
<summary>Room 22 - The Calculator Cave</summary>

**Commands:** `bc`, `expr`, `$(( ))`

```bash
cd ~/escapeRooms/room_22
cat equations.txt
echo "2^10" | bc        # 1024
echo "9 * 9" | bc       # 81
echo "8 * 29" | bc      # 232
echo $((1024 + 81 + 232))  # 1337
```

**Password:** `calc1337` (the word "calc" + the sum 1337)

</details>

<details>
<summary>Room 23 - The Time Machine</summary>

**Commands:** `date`, `date -d @TIMESTAMP`

```bash
cd ~/escapeRooms/room_23
cat timestamps.txt
date -d @946684800 +%Y   # 2000
date -d @1276560000 +%Y  # 2010
date -d @1458432000 +%Y  # 2016
echo $((2000 + 2010 + 2016))  # 6026
```

**Password:** `epoch6026` (the word "epoch" + sum of years)

</details>

<details>
<summary>Room 24 - The Formatter's Workshop</summary>

**Commands:** `printf`

```bash
cd ~/escapeRooms/room_24
printf "%-10s | %05d | %s\n" "key" 77 "format77"
# Last word of last row: format77
```

**Password:** `format77`

</details>

<details>
<summary>Room 25 - The Signal Crossroads</summary>

**Commands:** `tee`, `grep`, `cut`, `tr`

```bash
cd ~/escapeRooms/room_25
./generate_signal.sh | tee signal.log | grep "CODE:" | cut -d':' -f2 | tr -d ' '
# Output: teeoff
```

**Password:** `teeoff`

</details>

<details>
<summary>Room 26 - The Variable Vault</summary>

**Commands:** parameter expansion `${var##*/}`

```bash
cd ~/escapeRooms/room_26
source vault_env.sh
echo ${TREASURE_PATH##*/}
# Output: expand99
```

**Password:** `expand99`

</details>

<details>
<summary>Room 27 - The Array Arsenal</summary>

**Commands:** bash arrays, `mapfile`, `sort`, `uniq`

```bash
cd ~/escapeRooms/room_27
sort weapons.txt | uniq | wc -l
# Output: 10
```

**Password:** `array10` (the word "array" + unique count)

</details>

<details>
<summary>Room 28 - The Loop Labyrinth</summary>

**Commands:** `for` loops, `$(( ))`

```bash
cd ~/escapeRooms/room_28
total=0
for f in chambers/chamber_*.txt; do
  total=$(( total + $(cat "$f") ))
done
echo $total
# Output: 50
```

**Password:** `loop50` (the word "loop" + the sum)

</details>

<details>
<summary>Room 29 - The Endless Corridor</summary>

**Commands:** `while read`, `grep -c`

```bash
cd ~/escapeRooms/room_29
grep -c "OPEN" door_log.txt
# Output: 100
```

**Password:** `while100` (the word "while" + open door count)

</details>

<details>
<summary>Room 30 - The Fork in the Road</summary>

**Commands:** `if`/`elif`/`else`, test operators

```bash
cd ~/escapeRooms/room_30
bash decision_tree.sh 42 unlock
# Output: The password is: branch3
```

**Password:** `branch3`

</details>

<details>
<summary>Room 31 - The Decision Chamber</summary>

**Commands:** `case`, `grep -c`

```bash
cd ~/escapeRooms/room_31
grep -c '\$' symbols.txt
# Output: 7
```

**Password:** `matched7` (the word "matched" + count of $ lines)

</details>

<details>
<summary>Room 32 - The Function Factory</summary>

**Commands:** bash functions, `while read`, parameter expansion

```bash
cd ~/escapeRooms/room_32
total=0
while IFS= read -r code; do
  [[ "$code" == PROD-* ]] && total=$(( total + ${code#PROD-} ))
done < assembly.txt
echo $total   # 200
./getKey.sh 200
# Output: funcret
```

**Password:** `funcret`

</details>

<details>
<summary>Room 33 - The Argument Decoder</summary>

**Commands:** `getopts`, `$OPTARG`

```bash
cd ~/escapeRooms/room_33
bash locked_program.sh -u agent -p 1337 -v
# Output: optparse
```

**Password:** `optparse`

</details>

<details>
<summary>Room 34 - The Ancient Scroll</summary>

**Commands:** here-documents `<< 'EOF'`

```bash
cd ~/escapeRooms/room_34
./verify_config.sh << 'EOF'
MODE=escape
LEVEL=master
KEY=ancient
EOF
# Output: heredoc5
```

**Password:** `heredoc5`

</details>

<details>
<summary>Room 35 - The Nested Worlds</summary>

**Commands:** `$()`, `<(cmd)` process substitution, `comm`

```bash
cd ~/escapeRooms/room_35
comm -12 <(sort world_a.txt) <(sort world_b.txt) | wc -l
# Output: 42
```

**Password:** `nested42` (the word "nested" + intersection count)

</details>

<details>
<summary>Room 36 - The Signal Tower</summary>

**Commands:** `trap`, `kill -SIGUSR1`

```bash
cd ~/escapeRooms/room_36
# Full challenge:
trap 'echo "sigcatch" > trap_result.txt' SIGUSR1
while true; do sleep 1; done &
kill -SIGUSR1 $!
cat trap_result.txt
# Shortcut:
./reveal_signal.sh
# Output: sigcatch
```

**Password:** `sigcatch`

</details>

<details>
<summary>Room 37 - The Interactive Gateway</summary>

**Commands:** `read`, `read -p`

```bash
cd ~/escapeRooms/room_37
printf "bash\nescape\n$(date +%Y)\n" | bash guardian.sh
# Output: readline
```

**Password:** `readline`

</details>

<details>
<summary>Room 38 - The Time Bomb</summary>

**Commands:** `timeout`, `watch`

```bash
cd ~/escapeRooms/room_38
timeout 5 ./countdown.sh
grep "BOMB_CODE" progress.log | tail -1 | cut -d'=' -f2
# Output: timeout3
```

**Password:** `timeout3`

</details>

<details>
<summary>Room 39 - The Network Hub</summary>

**Commands:** `ss -tlnp`, `netstat`

```bash
cd ~/escapeRooms/room_39
ss -tlnp | grep ':8[0-9][0-9][0-9]'
# Find open port, then: curl http://localhost:<PORT>
# Fallback: cat network_secret.txt
# Output: port80
```

**Password:** `port80`

</details>

<details>
<summary>Room 40 - The DNS Oracle</summary>

**Commands:** `dig`, `host`, `nslookup`

```bash
cd ~/escapeRooms/room_40
dig TXT secret.escape.local +short
# Fallback: cat dns_fallback.txt
# Output: resolve9
```

**Password:** `resolve9`

</details>

<details>
<summary>Room 41 - The Netcat Tunnel</summary>

**Commands:** `nc`, `echo | nc`

```bash
cd ~/escapeRooms/room_41
echo "OPEN" | nc localhost 4444
# Fallback: cat nc_fallback.txt
# Output: ncat7
```

**Password:** `ncat7`

</details>

<details>
<summary>Room 42 - The Open Files Archive</summary>

**Commands:** `lsof`, `lsof -p`

```bash
cd ~/escapeRooms/room_42
bash start_keeper.sh &
lsof | grep secret_key
# Note PID, then: lsof -p <PID> | grep password.txt
# Fallback: cat lsof_secret.txt
# Output: openfd
```

**Password:** `openfd`

</details>

<details>
<summary>Room 43 - The System Call Observatory</summary>

**Commands:** `strace`, `strace -e trace=write`

```bash
cd ~/escapeRooms/room_43
./mystery_program
# OR: strace -e trace=write ./mystery_program 2>&1 | grep '"'
# Output: syscall
```

**Password:** `syscall`

</details>

<details>
<summary>Room 44 - The Mirror Sync</summary>

**Commands:** `rsync -av`, `rsync --delete`, `find`

```bash
cd ~/escapeRooms/room_44
rsync -av --delete source_archive/ mirror_archive/
find mirror_archive/ -type f | wc -l   # 10
./getKey.sh 10
# Output: synced
```

**Password:** `synced`

</details>

<details>
<summary>Room 45 - The Cryptographer's Den</summary>

**Commands:** `openssl enc -d`

```bash
cd ~/escapeRooms/room_45
openssl enc -aes-256-cbc -d -a -pbkdf2 \
  -in encrypted_message.enc -pass pass:cryptokey2024
# Output: cipher99
```

**Password:** `cipher99`

</details>

<details>
<summary>Room 46 - The Vi Vortex</summary>

**Commands:** `vim`, `sed -n`

```bash
cd ~/escapeRooms/room_46
sed -n '777p' ancient_tome.txt
# Output: SECRET: vimmode
# In vim: open file, type 777G, read line, :q!
```

**Password:** `vimmode`

</details>

<details>
<summary>Room 47 - The Remote Gateway</summary>

**Commands:** `ssh-keygen`, `ssh -i`, `scp`

```bash
cd ~/escapeRooms/room_47
ssh-keygen -t rsa -f /tmp/escape_key -N ""
./setup_ssh_access.sh /tmp/escape_key.pub
ssh -i /tmp/escape_key -o StrictHostKeyChecking=no escape@localhost
# Fallback: cat ssh_secret.txt
# Output: sshkey
```

**Password:** `sshkey`

</details>

<details>
<summary>Room 48 - The Version Vault</summary>

**Commands:** `git log`, `git show`

```bash
cd ~/escapeRooms/room_48/vault_repo
git log --oneline
# Find hash where secret.txt was added
git show <HASH>:secret.txt
# Output: commit42
```

**Password:** `commit42`

</details>

<details>
<summary>Room 49 - The Grand Pipeline II</summary>

**Commands:** `awk`, `sort`, `uniq -c`, `sort -rn`, `head`

```bash
cd ~/escapeRooms/room_49
awk '$3 == "SUCCESS" {print $2}' factory_log.txt \
  | sort | uniq -c | sort -rn | head -1
# Output: 9 M001
# Top machine had 9 successes
```

**Password:** `pipeline9` (the word "pipeline" + top count)

</details>

<details>
<summary>Room 50 - The Master Terminal</summary>

**Commands:** `find`, `base64 -d`, `grep -E`, `paste -sd`, `bc`

```bash
cd ~/escapeRooms/room_50
find final_challenge/ -name "*.key" | sort \
  | xargs -I{} base64 -d {} \
  | grep -E '^[0-9]+$' \
  | paste -sd'+' | bc
# Output: 1000
./getKey.sh 1000
# Output: masterkey
```

**Password:** `masterkey`

</details>

<details>
<summary>Room 51 - xargs (password: masterkey → chownit)</summary>

**Challenge:** Sum numeric VALUES from all .part files using xargs.

**Solution:**

```bash
find parts/ -name "*.part" | xargs grep -h "VALUE=" | cut -d= -f2 | paste -sd+ | bc
# Output: 777
./getKey.sh 777
# Password: chownit
```

</details>

<details>
<summary>Room 52 - chown, chgrp, umask (password: chownit → netprobe)</summary>

**Challenge:** Fix file ownership in vault/ to escape:escape.

**Solution:**

```bash
chown escape:escape vault/access.key vault/config.cfg vault/secret.dat
# or: chown -R escape:escape vault/
./getKey.sh
# Password: netprobe
```

</details>

<details>
<summary>Room 53 - ping, traceroute, wget (password: netprobe → monitor5)</summary>

**Challenge:** Start the beacon server and wget the key file.

**Solution:**

```bash
ping -c 3 127.0.0.1
./start_server.sh &
wget -q -O - http://127.0.0.1:9053/key.txt
# Password: monitor5
```

</details>

<details>
<summary>Room 54 - top, free, uptime (password: monitor5 → sysinfo9)</summary>

**Challenge:** Parse system_snapshot.txt to extract total_mem=2048, load1=0.42, running=2.

**Solution:**

```bash
grep 'Mem:' system_snapshot.txt | awk '{print $2}'       # 2048
grep 'load average' system_snapshot.txt | awk -F': ' '{print $2}' | cut -d, -f1 | xargs  # 0.42
grep 'running' system_snapshot.txt | awk '{print $4}'    # 2
./getKey.sh 2048 0.42 2
# Password: sysinfo9
```

</details>

<details>
<summary>Room 55 - uname, hostname, id, who (password: sysinfo9 → procctrl)</summary>

**Challenge:** Submit your username and OS kernel name.

**Solution:**

```bash
whoami   # escape
uname -s # Linux
./getKey.sh "$(whoami)" "$(uname -s)"
# Password: procctrl
```

</details>

<details>
<summary>Room 56 - pgrep, pkill, nohup (password: procctrl → allclear)</summary>

**Challenge:** Launch agents, find them with pgrep, and terminate them.

**Solution:**

```bash
./launch_agents.sh
pgrep -a agent                # find all agent PIDs
cat /tmp/agent_keeper.log     # read the keeper log
pkill -f agent_keeper.sh      # kill keeper
pkill -f agent_worker         # kill workers
./getKey.sh
# Code: allclear
```

</details>

<details>
<summary>Room 99 - The Exit Exam</summary>

**Commands:** all of the above

```bash
cd ~/escapeRooms/room_99
./getKey.sh
# Answer 5 random trivia questions about Linux commands
```

**Password:** `escaped`

</details>
