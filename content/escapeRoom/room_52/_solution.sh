#!/usr/bin/env bash
# Room 52 Solution - Ownership Vault
# Password: netprobe
# Note: requires 'escape' user to exist (Docker/container environment)

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 52: Ownership Vault ==="
echo ""

# Run setup if vault doesn't exist
if [ ! -d vault ]; then
    bash setup.sh 2>/dev/null
fi

# Try to fix ownership if escape user exists
if id escape &>/dev/null 2>&1; then
    chown escape:escape vault/access.key vault/config.cfg vault/secret.dat 2>/dev/null
    umask 022
    bash script.sh
else
    echo "Note: 'escape' user not found (requires container environment)"
    echo "Password: netprobe"
fi
