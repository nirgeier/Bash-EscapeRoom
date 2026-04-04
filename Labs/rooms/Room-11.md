---
title: "(Room 11) 🪆 The Nested Archive"
password: "awk2025"
title_prefix: "🪆 "
summary: "Unwrap a multi-layered archive using base64, gzip, and tar."
---

[![Room-11](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-11.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-11.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 11</span>
  <div class="room-title">
    <span class="room-title-accent">🪆 The</span>
    <span class="room-title-main">Nested Archive</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Unwrap a multi-layered archive using base64, gzip, and tar.

A mysterious artifact has been encoded in **3 layers** -like a Russian nesting doll.
Peel each layer to reveal the secret.

</div>

---

### UNWRAP THE MATRYOSHKA!

<ol class="tasks">
  <li>Decode Base64 → <code>base64 -d artifact.b64 > artifact.tar.gz</code></li>
  <li>Decompress gzip → <code>gunzip artifact.tar.gz</code></li>
  <li>Extract tar → <code>tar xf artifact.tar</code></li>
  <li>Read the extracted file -it contains the password!</li>
</ol>

### The 3 Layers (outermost to innermost)

1. **Base64** encoding
2. **Gzip** compression
3. **Tar** archive

### Key Commands

| Command              | Purpose                 |
| -------------------- | ----------------------- |
| `base64 -d`          | Decode base64 to binary |
| `gunzip` / `gzip -d` | Decompress gzip files   |
| `tar xf`             | Extract tar archives    |
| `file`               | Identify file type      |

### How Archive Tools Work

```bash
# base64 - encode/decode binary data as text
base64 file.bin > file.b64          # encode binary to base64 text
base64 -d file.b64 > file.bin       # decode base64 back to binary
base64 -d file.b64 | file -         # decode and identify type on the fly
base64 -w 0 file.bin > file.b64     # encode with no line wrapping

# gzip - compress / decompress files
gzip file.txt                       # compress (creates file.txt.gz, removes original)
gzip -d file.txt.gz                 # decompress
gunzip file.txt.gz                  # same as gzip -d
gzip -k file.txt                    # compress and keep original
gzip -l file.gz                     # list compression ratio and sizes
gzip -t file.gz                     # test archive integrity

# tar - archive (bundle) files
tar cf archive.tar dir/             # create archive from directory
tar czf archive.tar.gz dir/         # create and gzip-compress in one step
tar xf archive.tar                  # extract archive
tar xzf archive.tar.gz              # extract gzip-compressed archive
tar tf archive.tar                  # list contents without extracting
tar xf archive.tar -C /dest/        # extract to a specific directory

# file - identify an unknown file type
file mystery                        # prints: "gzip compressed data", "POSIX tar archive", etc.
file *                              # identify all files in current directory
```

### Pro Tip: Use `file` to Identify Unknown Types

```bash
file artifact.b64           # "ASCII text"
file artifact.tar.gz        # "gzip compressed data"
file artifact.tar           # "POSIX tar archive"
```


<div class="hints" markdown="1">

> After each step, use `ls` to see what appeared and `file` to identify it.

</div>
---

!!! info "🔓 Unlock Room 12"

    Once you solve the puzzle, run:

    ```bash
    next <PASSWORD>
    ```
