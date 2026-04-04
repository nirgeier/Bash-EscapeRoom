---
title: "(Room 50) 👑 The Master Terminal"
password: "pipeline9"
title_prefix: "👑 "
summary: "The final challenge - combine all skills to defeat the Master Terminal."
---

[![Room-50](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-50.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-50.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 50</span>
  <div class="room-title">
    <span class="room-title-accent">👑 The</span>
    <span class="room-title-main">Master Terminal</span>
  </div>
</div>


---

<div class="summary" markdown="1">

The final challenge - combine all skills to defeat the Master Terminal.

- You've made it to the final room.
- The Master Terminal requires proof that you've mastered ALL the skills.
- This challenge combines multiple tools in one epic puzzle.
!!! danger "⚠️ Final Challenge"
    This is the last room before the exit exam. Give it everything you've got!

</div>

---

### CONQUER THE MASTER TERMINAL!

<ol class="tasks">
  <li><strong>Find</strong>: Locate all <code>.key</code> files recursively in <code>final_challenge/</code>. <code>find final_challenge/ -name "*.key"</code></li>
  <li><strong>Decode</strong>: Each <code>.key</code> file contains a base64-encoded value. Decode all of them. <code>base64 -d < each_file</code></li>
  <li><strong>Filter</strong>: Keep only decoded values that are purely numeric. <code>grep -E '^[0-9]+$'</code></li>
  <li><strong>Calculate</strong>: Sum all the numeric values. <code>paste -sd'+' | bc</code></li>
  <li><strong>Verify</strong>: The sum must be verified against <code>final_challenge/expected_checksum.txt</code>. <code>echo "sum" | sha256sum</code> and compare</li>
  <li>Once verified, run <code>./final_challenge/unlock.sh <sum></code> to get the exit code.</li>
  <li>The exit code printed by the script <strong>is</strong> the password for the Final Exam (Room 99).</li>
</ol>

### The Master Pipeline

```bash
find final_challenge/ -name "*.key" \
  | sort \
  | xargs -I{} base64 -d {} \
  | grep -E '^[0-9]+$' \
  | paste -sd'+' \
  | bc
```

### Skills Checklist

| Skill            | Command            |
| ---------------- | ------------------ |
| Find files       | `find`             |
| Decode data      | `base64 -d`        |
| Filter output    | `grep -E`          |
| Sum numbers      | `bc`               |
| Verify integrity | `sha256sum`        |
| Run a script     | `bash ./script.sh` |

### Final Boss Tips

> Run each stage of the pipeline separately before combining them.
Use `| head` after each step to preview the intermediate output.
> Use `tee /tmp/debug.txt` between pipe stages to capture intermediate output.
> `echo "your_sum" | sha256sum` - compare the output with `expected_checksum.txt`.
---

!!! success "🎉 Congratulations!"

    If you've made it this far, you are a true Bash Master.
    The final exam awaits - prove everything you've learned!

---

!!! info "🔓 Unlock the Final Exam (Room 99)"

    Once you solve the puzzle, run:

    ```bash
    next <PASSWORD>
    ```
