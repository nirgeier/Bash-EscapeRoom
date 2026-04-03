---
title: "(Room 19) 🔒 The Integrity Check"
password: "patch13"
title_prefix: "🔒 "
summary: "Use md5sum and sha256sum to verify file integrity and find the authentic document."
---

[![Room-19](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-19.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-19.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 19</span>
  <div class="room-title">
    <span class="room-title-accent">🔒 The</span>
    <span class="room-title-main">Integrity Check</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Use md5sum and sha256sum to verify file integrity and find the authentic document.

- Seven documents were delivered, but only one is authentic.
- The authentic document matches a known checksum. Find it!

</div>

---

### FIND THE AUTHENTIC DOCUMENT!

<ol class="tasks">
  <li>Read <code>authentic.sha256</code> to see the expected hash. <code>cat authentic.sha256</code></li>
  <li>Calculate the SHA-256 hash of each document. <code>sha256sum documents/*.txt</code></li>
  <li>Find which document's hash matches the one in <code>authentic.sha256</code>.</li>
  <li>Read that document - its contents <strong>are</strong> the password.</li>
</ol>

---

### Key Commands

| Command | Purpose |
| --- | --- |
| `sha256sum file` | Compute SHA-256 checksum |
| `sha256sum -c sums.txt` | Verify checksums from file |
| `sha256sum * > checksums.txt` | Compute checksums for all files |
| `md5sum file` | Compute MD5 checksum |
| `md5sum -c sums.txt` | Verify MD5 checksums |
| `sha1sum file` | Compute SHA-1 checksum |
| `sha512sum file` | Compute SHA-512 checksum |
| `echo "text" \| sha256sum` | Hash a string |
| `sha256sum file \| cut -d' ' -f1` | Extract hash only |
| `diff <(sha256sum a) <(sha256sum b)` | Compare two file hashes |
| `openssl dgst -sha256 file` | OpenSSL alternative |
| `openssl dgst -md5 file` | MD5 via OpenSSL |
| `b2sum file` | BLAKE2 checksum (faster) |
| `cksum file` | Simple CRC checksum |

### How Checksum Tools Work

```bash
# Calculate checksums
md5sum file.txt                         # 32-character hex hash
sha1sum file.txt                        # 40-character hex hash
sha256sum file.txt                      # 64-character hex hash
sha512sum file.txt                      # 128-character hex hash

# Multiple files at once
md5sum *.txt                            # hash all .txt files
sha256sum dir/*                         # hash all files in a directory

# Verify against a checksum file
sha256sum -c checksums.sha256           # check all listed files
md5sum -c hashes.md5                    # verify using md5 hashes
# Output: "filename: OK" or "filename: FAILED"

# Create a checksum file
sha256sum file1.txt file2.txt > checksums.sha256   # save hashes to file
sha256sum * > all_checksums.sha256                 # hash everything in dir

# Compare a single file to a known hash
echo "EXPECTEDHASH  filename" | sha256sum -c   # verify one file inline

# Quick comparison
sha256sum file1.txt file2.txt           # same hash = identical content
```


<div class="hints" markdown="1">

> `sha256sum documents/*.txt` will show hashes for all documents at once.

> Use `grep` to match the hash from `authentic.sha256` against the computed hashes.

</div>
---

!!! info "🔓 Unlock Room 20"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_20/README -out ../room_20/README.txt -pass pass:PASSWORD
    cat ../room_20/README.txt
    ```
