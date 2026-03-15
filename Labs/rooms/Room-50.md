---
password: "pipeline9"
title_prefix: "👑 "
summary: "The final challenge - combine all skills to defeat the Master Terminal."
---

**CONQUER THE MASTER TERMINAL!**

---

## 👑 The Master Terminal

- You've made it to the final room.
- The Master Terminal requires proof that you've mastered ALL the skills.
- This challenge combines multiple tools in one epic puzzle.

---

!!! danger "⚠️ Final Challenge"

    This is the last room before the exit exam. Give it everything you've got!

---

!!! abstract "📜 Mission Briefing"

    The directory `final_challenge/` contains multiple files.

    Complete ALL of the following tasks:

    1. **Find**: Locate all `.key` files recursively in `final_challenge/`.
       > hint: `find final_challenge/ -name "*.key"`
    2. **Decode**: Each `.key` file contains a base64-encoded value. Decode all of them.
       > hint: `base64 -d < each_file`
    3. **Filter**: Keep only decoded values that are purely numeric.
       > hint: `grep -E '^[0-9]+$'`
    4. **Calculate**: Sum all the numeric values.
       > hint: `paste -sd'+' | bc`
    5. **Verify**: The sum must be verified against `final_challenge/expected_checksum.txt`.
       > hint: `echo "sum" | sha256sum` and compare
    6. Once verified, run `./final_challenge/unlock.sh <sum>` to get the exit code.
    7. The exit code printed by the script **is** the password for the Final Exam (Room 99).

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

!!! tip "Tip 1 - Take it step by step"

    Run each stage of the pipeline separately before combining them.
    Use `| head` after each step to preview the intermediate output.

!!! tip "Tip 2 - Debug mid-pipeline"

    Use `tee /tmp/debug.txt` between pipe stages to capture intermediate output.

!!! tip "Tip 3 - Verify your math"

    `echo "your_sum" | sha256sum` - compare the output with `expected_checksum.txt`.

---

!!! success "🎉 Congratulations!"

    If you've made it this far, you are a true Bash Master.
    The final exam awaits - prove everything you've learned!

---

!!! info "🔓 Unlock the Final Exam (Room 99)"

    Once you have the password, decrypt the exit exam README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_99/README -out ../room_99/README.txt -pass pass:PASSWORD
    cat ../room_99/README.txt
    ```
