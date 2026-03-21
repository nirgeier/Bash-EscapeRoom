#!/bin/bash
PUB_KEY="$1"
if [ -z "$PUB_KEY" ]; then
    echo "Usage: $0 <public_key_file>"
    exit 1
fi
mkdir -p ~/.ssh
chmod 700 ~/.ssh
cat "$PUB_KEY" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
echo "Public key added to authorized_keys."
echo "Now try: ssh -i /tmp/escape_key -o StrictHostKeyChecking=no escape@localhost"
