#!/usr/bin/env bash
# Room 08 Solution - Environment Lab
# Password: export99

ROOM_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOM_DIR"

echo "=== Room 08: Environment Lab ==="
echo ""

# Use bash -i for interactive shell (enables aliases) or use a wrapper function
source .lab_config
export LAB_KEY=42
export EXPERIMENT=active
export SCIENTIST=darwin

# Aliases don't work in non-interactive subshells, so use a bash -c with shopt
bash -c "
    shopt -s expand_aliases
    source '$ROOM_DIR/.lab_config'
    export LAB_KEY=42
    export EXPERIMENT=active
    export SCIENTIST=darwin
    alias labstatus='echo ready'
    source '$ROOM_DIR/script.sh'
"
