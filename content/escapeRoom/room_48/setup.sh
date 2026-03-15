#!/bin/bash
# Create a git repo with a "deleted" secret in history
mkdir -p vault_repo
cd vault_repo

git init -b main 2>/dev/null || git init
git config user.email "escape@room.local"
git config user.name "Escape Room"

# Initial commit
echo "This is the main vault file." > README.md
git add README.md
git commit -m "Initial commit"

# Add the secret file
echo "commit42" > secret.txt
git add secret.txt
git commit -m "Add secret transmission data"

# Delete the secret (it stays in history!)
git rm secret.txt
echo "Vault log entry 1" >> README.md
git add README.md
git commit -m "Remove classified data and update logs"

echo "Git repository created. The secret is hidden in the history!"
cd ..
