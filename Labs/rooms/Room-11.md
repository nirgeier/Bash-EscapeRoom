---
password: "awk2025"
title_prefix: "🪆 "
summary: "Unwrap a multi-layered archive using base64, gzip, and tar."
---

[![Room-11](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-11.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/rooms/room-11.yml)


**UNWRAP THE MATRYOSHKA!**

---

## 🪆 The Nested Archive

A mysterious artifact has been encoded in **3 layers** -like a Russian nesting doll.
Peel each layer to reveal the secret.

!!! abstract "📜 Mission Briefing"

    The file `artifact.b64` has been wrapped in **3 layers** of encoding:

    - Layer 3 (outermost): **Base64**
    - Layer 2: **Gzip** compression
    - Layer 1 (innermost): **Tar** archive

    Unwrap in reverse order:

    1. Decode Base64 → `base64 -d artifact.b64 > artifact.tar.gz`
    2. Decompress gzip → `gunzip artifact.tar.gz`
    3. Extract tar → `tar xf artifact.tar`
    4. Read the extracted file -it contains the password!

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

### Hints

!!! tip "Hint"

    After each step, use `ls` to see what appeared and `file` to identify it.

---

!!! info "🔓 Unlock Room 12"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_12/README -out ../room_12/README.txt -pass pass:PASSWORD
    cat ../room_12/README
    ```
