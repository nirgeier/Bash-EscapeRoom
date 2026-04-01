#!/usr/bin/env bash
# Room 19 Solution - Document Integrity
# Password: hash256

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 19: Document Integrity ==="
echo ""

# Run setup if documents don't exist
if [ ! -d documents ]; then
    bash setup.sh
fi

expected=$(awk '{print $1}' authentic.sha256)
for f in documents/doc_*.txt; do
    # macOS uses shasum -a 256, Linux uses sha256sum
    if command -v sha256sum &>/dev/null; then
        hash=$(sha256sum "$f" | awk '{print $1}')
    else
        hash=$(shasum -a 256 "$f" | awk '{print $1}')
    fi
    if [ "$hash" = "$expected" ]; then
        echo "Authentic document: $f"
        password=$(cat "$f")
        echo "Password: $password"
        break
    fi
done
