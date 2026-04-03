---
title: "(Room 45) 🔑 The Cryptographer's Den"
password: "synced"
title_prefix: "🔑 "
summary: "Use openssl to decrypt a message encrypted with a symmetric cipher."
---

<div class="room-hero">
  <span class="room-badge">ROOM 45</span>
  <div class="room-title">
    <span class="room-title-accent">🔑 The</span>
    <span class="room-title-main">Cryptographer's Den</span>
  </div>
</div>

[![Room-45](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-45.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-45.yml)


**CRACK THE CRYPTOGRAPHER'S DEN!**

---


- A message was encrypted with `openssl` using a known algorithm and key.
- Decrypt it to reveal the secret.

---

<div class="tasks" markdown="1">

The file `encrypted_message.enc` was encrypted using AES-256-CBC.
The encryption password is hidden in a file called `keyfile.txt` in the same directory.

1. Find and read the encryption password.
   > `cat keyfile.txt`
2. Decrypt the file using `openssl` with the password you found.
   > `openssl enc -aes-256-cbc -d -a -pbkdf2 -in encrypted_message.enc -pass pass:PASSWORD`
3. The decrypted output **is** the password for Room 46.

</div>

### Key Commands

| Command                    | Purpose                     |
| -------------------------- | --------------------------- |
| `openssl enc -e`           | Encrypt a file              |
| `openssl enc -d`           | Decrypt a file              |
| `openssl enc -aes-256-cbc` | Use AES-256-CBC cipher      |
| `openssl dgst -sha256`     | Compute SHA-256 hash        |
| `openssl genrsa`           | Generate RSA private key    |
| `openssl rand -hex N`      | Generate N random hex bytes |

### How `openssl` Works

```bash
# Symmetric encryption/decryption
# Encrypt
openssl enc -aes-256-cbc -e -a -pbkdf2 \
    -in plaintext.txt \
    -out encrypted.enc \
    -pass pass:mypassword

# Decrypt
openssl enc -aes-256-cbc -d -a -pbkdf2 \
    -in encrypted.enc \
    -out plaintext.txt \
    -pass pass:mypassword

# Flags:
# -e = encrypt  -d = decrypt
# -a = base64 encode/decode (ASCII output)
# -pbkdf2 = use PBKDF2 key derivation (recommended)
# -pass pass:PASSWORD = specify password inline
# -pass env:VARNAME = read password from env variable
# -pass file:key.txt = read password from file

# Common ciphers
openssl enc -list                       # list all available ciphers
openssl enc -aes-128-cbc ...           # AES 128-bit
openssl enc -aes-256-cbc ...           # AES 256-bit (strongest)
openssl enc -des3 ...                  # Triple-DES

# Hashing with openssl
openssl dgst -md5 file.txt             # MD5 hash
openssl dgst -sha256 file.txt         # SHA-256 hash
openssl dgst -sha256 -hmac "key" file  # HMAC-SHA256

# Generate random data
openssl rand -hex 16                   # 16 random hex bytes (32 chars)
openssl rand -base64 24                # 24 random base64 bytes
openssl rand 32 > keyfile              # 32 random raw bytes

# Check openssl version and capabilities
openssl version                        # version info
openssl help                           # list all commands
```


<div class="hints" markdown="1">

> Copy the exact decrypt command from the Mission Briefing - the password is `cryptokey2024`.

> `-a` flag is needed if the encrypted file was base64-encoded. `-pbkdf2` should match what was used to encrypt.

</div>
---

!!! info "🔓 Unlock Room 46"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_46/README -out ../room_46/README.txt -pass pass:PASSWORD
    cat ../room_46/README.txt
    ```
