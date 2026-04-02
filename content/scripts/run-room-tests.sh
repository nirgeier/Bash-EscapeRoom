#!/bin/bash
# =============================================================================
# run-room-tests.sh
# Triggers the "Test All Rooms" GitHub Actions workflow and displays
# a per-room pass/fail summary when it completes.
# =============================================================================

WORKFLOW="test-rooms.yml"
REPO="nirgeier/Bash-EscapeRoom"

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

echo -e "${CYAN}${BOLD}Triggering 'Test All Rooms' workflow...${RESET}"
gh workflow run "$WORKFLOW" --repo "$REPO" --ref main

# Wait a moment for GitHub to register the run
sleep 5

# Get the run ID of the run we just triggered (most recent)
RUN_ID=$(gh run list --workflow="$WORKFLOW" --repo "$REPO" --limit=1 --json databaseId -q '.[0].databaseId')
echo -e "${CYAN}Run ID: ${RUN_ID}${RESET}"
echo -e "${CYAN}Waiting for run to complete...${RESET}"

# Poll until the run is no longer in_progress / queued
while true; do
    STATUS=$(gh run view "$RUN_ID" --repo "$REPO" --json status -q '.status')
    if [[ "$STATUS" == "completed" ]]; then
        break
    fi
    echo -ne "\r  status: ${YELLOW}${STATUS}${RESET}   "
    sleep 10
done
echo ""

# Fetch all job results
JOBS=$(gh run view "$RUN_ID" --repo "$REPO" --json jobs -q '.jobs[] | "\(.conclusion)|\(.name)"')

# Display results table
echo ""
echo -e "${BOLD}${CYAN}╔══════════════════════════════════╗${RESET}"
echo -e "${BOLD}${CYAN}║      Room Test Results           ║${RESET}"
echo -e "${BOLD}${CYAN}╚══════════════════════════════════╝${RESET}"
echo ""

PASS=0
FAIL=0
SKIP=0

# Sort by room number
while IFS='|' read -r conclusion name; do
    room_num=$(echo "$name" | grep -oE '[0-9]+')
    case "$conclusion" in
        success)
            echo -e "  ${GREEN}✔${RESET}  Room ${room_num}"
            ((PASS++))
            ;;
        failure)
            echo -e "  ${RED}✘${RESET}  Room ${room_num}"
            ((FAIL++))
            ;;
        skipped|cancelled)
            echo -e "  ${YELLOW}−${RESET}  Room ${room_num} (${conclusion})"
            ((SKIP++))
            ;;
        *)
            echo -e "  ${YELLOW}?${RESET}  Room ${room_num} (${conclusion:-unknown})"
            ((SKIP++))
            ;;
    esac
done < <(echo "$JOBS" | sort -t'|' -k2 -V)

echo ""
echo -e "${BOLD}  Summary: ${GREEN}${PASS} passed${RESET}  ${RED}${FAIL} failed${RESET}  ${YELLOW}${SKIP} skipped${RESET}"
echo ""

# Link to the run
echo -e "  Full details: ${CYAN}https://github.com/${REPO}/actions/runs/${RUN_ID}${RESET}"
echo ""

# Exit with failure if any rooms failed
[ "$FAIL" -eq 0 ]
