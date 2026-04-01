#!/usr/bin/env bash
# Room 48 Solution - Git History
# Password: commit42

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 48: Git History ==="
echo ""

# Run setup if vault_repo doesn't exist
if [ ! -d vault_repo ]; then
    bash setup.sh
fi

cd vault_repo
commit_hash=$(git log --oneline --all -- secret.txt | grep "Add secret" | awk '{print $1}')
password=$(git show "${commit_hash}:secret.txt")
echo "Password: $password"
