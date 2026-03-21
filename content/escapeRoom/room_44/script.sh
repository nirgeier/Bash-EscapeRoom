#!/bin/bash
source ../_utils.sh

COUNT=$(find mirror_archive/ -type f 2>/dev/null | wc -l | tr -d ' ')

if [ "$COUNT" -eq 10 ]; then
    echo ""
    echo -e "${BGreen}Perfect sync! $COUNT files in mirror_archive/${NO_COLOR}"
    echo -e "The password for the next room is: ${BYELLOW}synced${NO_COLOR}"
    echo ""
else
    echo -e "${BRed}Not synced correctly. Found $COUNT files, expected 10.${NO_COLOR}"
    echo "Hint: rsync -av --delete source_archive/ mirror_archive/"
fi
