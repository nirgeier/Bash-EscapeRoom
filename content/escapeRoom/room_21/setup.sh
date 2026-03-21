#!/bin/bash
# Create a "binary" file that contains the password string embedded in noise
python3 -c "
import os, sys
# Write random bytes, then embedded strings, then more random bytes
data = os.urandom(256)
data += b'This is a binary vault file\x00'
data += os.urandom(128)
data += b'BUILD_VERSION=3.14.2\x00'
data += os.urandom(64)
data += b'PASSWORD=hidden42\x00'
data += os.urandom(128)
data += b'AUTHOR=EscapeRoom\x00'
data += os.urandom(256)
sys.stdout.buffer.write(data)
" > vault_binary 2>/dev/null || \
{
  # Fallback if python3 not available - use dd and printf
  dd if=/dev/urandom bs=256 count=1 2>/dev/null > vault_binary
  printf 'BUILD_VERSION=3.14.2\0' >> vault_binary
  dd if=/dev/urandom bs=64 count=1 2>/dev/null >> vault_binary
  printf 'PASSWORD=hidden42\0' >> vault_binary
  dd if=/dev/urandom bs=256 count=1 2>/dev/null >> vault_binary
}
