#!/bin/bash

source ../_utils.sh

ERRORS=0

# Check LAB_KEY
if [ "$LAB_KEY" != "42" ]; then
    echo -e "${BRed}LAB_KEY is not set correctly (expected 42)${NO_COLOR}"
    ERRORS=$((ERRORS + 1))
else
    echo -e "${BGreen}LAB_KEY: OK${NO_COLOR}"
fi

# Check EXPERIMENT
if [ "$EXPERIMENT" != "active" ]; then
    echo -e "${BRed}EXPERIMENT is not set correctly (expected 'active')${NO_COLOR}"
    ERRORS=$((ERRORS + 1))
else
    echo -e "${BGreen}EXPERIMENT: OK${NO_COLOR}"
fi

# Check SCIENTIST
if [ "$SCIENTIST" != "darwin" ]; then
    echo -e "${BRed}SCIENTIST is not set correctly (expected 'darwin')${NO_COLOR}"
    ERRORS=$((ERRORS + 1))
else
    echo -e "${BGreen}SCIENTIST: OK${NO_COLOR}"
fi

# Check alias
ALIAS_OUTPUT=$(labstatus 2>/dev/null)
if [ "$ALIAS_OUTPUT" != "ready" ]; then
    echo -e "${BRed}Alias 'labstatus' not set correctly (should echo 'ready')${NO_COLOR}"
    ERRORS=$((ERRORS + 1))
else
    echo -e "${BGreen}labstatus alias: OK${NO_COLOR}"
fi

if [ $ERRORS -eq 0 ]; then
    echo ""
    echo -e "${BGreen}Environment configured correctly!${NO_COLOR}"
    echo -e "The password for the next room is: ${BYELLOW}export99${NO_COLOR}"
    echo ""
else
    echo ""
    echo -e "${BRed}$ERRORS check(s) failed. Fix your environment!${NO_COLOR}"
fi
