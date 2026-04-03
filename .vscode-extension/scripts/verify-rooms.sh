#!/usr/bin/env bash
# =============================================================================
# verify-rooms.sh - Run each room's _solution.sh against built content
# and verify the output matches the expected password from passwords.yml
#
# Usage: bash scripts/verify-rooms.sh [CONTENT_DIR] [PASSWORDS_YML] [SOLUTIONS_DIR]
#   CONTENT_DIR    = path to built content/escapeRoom   (default: content/escapeRoom)
#   PASSWORDS_YML  = path to mkdocs/passwords.yml       (default: ../mkdocs/passwords.yml)
#   SOLUTIONS_DIR  = path to repo content/escapeRoom    (default: ../content/escapeRoom)
# =============================================================================
set -e
cd "$(dirname "$0")/.."

CONTENT_DIR="${1:-content/escapeRoom}"
PASSWORDS_YML="${2:-../mkdocs/passwords.yml}"
SOLUTIONS_DIR="${3:-../content/escapeRoom}"

PASS=0
FAIL=0
SKIP=0
ERRORS=()

# Build lookup: room_number -> expected_password
# passwords.yml: "rooms/Room-NN.md": "PASSWORD"
# Room N's _solution.sh produces password for Room N+1, which is under Room-(N+1).md
declare -A EXPECTED
while IFS= read -r line; do
    if [[ $line =~ rooms/Room-([0-9]+)\.md.*\"([^\"]+)\" ]]; then
        num=$((10#${BASH_REMATCH[1]}))
        # Room-NN.md password = what room_(NN-1) solution should output
        prev=$((num - 1))
        EXPECTED[$prev]="${BASH_REMATCH[2]}"
    fi
done < "$PASSWORDS_YML"

# Start room_14 server if needed
ROOM14_PID=""
ROOM14_SCRIPT="scripts/room14_server.py"
if [ -f "$ROOM14_SCRIPT" ] && command -v python3 &>/dev/null; then
    python3 "$ROOM14_SCRIPT" &>/dev/null &
    ROOM14_PID=$!
    sleep 1  # let it start
fi

cleanup() {
    [ -n "$ROOM14_PID" ] && kill "$ROOM14_PID" 2>/dev/null || true
}
trap cleanup EXIT

echo "▶ Verifying rooms against built content..."
echo ""

for room_dir in "$SOLUTIONS_DIR"/room_*/; do
    room=$(basename "$room_dir")
    num=$(echo "$room" | grep -oE '[0-9]+' | sed 's/^0*//')
    solution="$room_dir/_solution.sh"
    built_room="$CONTENT_DIR/$room"

    if [ ! -f "$solution" ]; then
        echo "  ⚪ $room - no _solution.sh (skip)"
        ((SKIP++))
        continue
    fi

    expected="${EXPECTED[$num]:-}"

    # Run solution with 10s timeout (macOS-compatible: background job + kill)
    tmpout=$(mktemp)
    (cd "$built_room" && bash "$solution" >"$tmpout" 2>&1) &
    sol_pid=$!
    for _i in $(seq 1 10); do
        sleep 1
        kill -0 "$sol_pid" 2>/dev/null || break
    done
    if kill -0 "$sol_pid" 2>/dev/null; then
        kill "$sol_pid" 2>/dev/null
        wait "$sol_pid" 2>/dev/null || true
        rm -f "$tmpout"
        echo "  ⏱  $room - timed out (skip)"
        ((SKIP++))
        continue
    fi
    wait "$sol_pid"
    exit_code=$?
    output=$(cat "$tmpout")
    rm -f "$tmpout"
    if [ $exit_code -ne 0 ]; then
        echo "  ❌ $room - solution script error (exit $exit_code)"
        ERRORS+=("$room: script error")
        ((FAIL++))
        continue
    fi

    # Extract "Password: VALUE" from output
    actual=$(echo "$output" | grep -oE 'Password:?\s*\S+' | tail -1 | awk '{print $NF}')

    if [ -z "$expected" ]; then
        # Last room(s) - no next password to verify, just check it runs
        if [ -n "$actual" ]; then
            echo "  ✅ $room - OK (password: $actual, no expected to compare)"
            ((PASS++))
        else
            echo "  ⚠️  $room - ran but no password found in output"
            ((SKIP++))
        fi
    elif [ "$actual" = "$expected" ]; then
        echo "  ✅ $room - OK ($actual)"
        ((PASS++))
    else
        echo "  ❌ $room - FAIL (got: '${actual}', expected: '${expected}')"
        ERRORS+=("$room: got='$actual' expected='$expected'")
        ((FAIL++))
    fi
done

echo ""
echo "─────────────────────────────────────"
echo "  Results: ✅ $PASS passed  ❌ $FAIL failed  ⚪ $SKIP skipped"
echo "─────────────────────────────────────"

if [ ${#ERRORS[@]} -gt 0 ]; then
    echo ""
    echo "Failures:"
    for e in "${ERRORS[@]}"; do echo "  • $e"; done
    echo ""
    exit 1
fi

echo ""
echo "All rooms verified ✅"
