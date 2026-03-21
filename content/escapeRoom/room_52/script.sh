#!/bin/bash
source ../_utils.sh

# Check ownership of all required files
PASS=1

check_owner() {
    local file=$1
    local expected_user=$2
    local expected_group=$3
    local actual_user actual_group
    actual_user=$(stat -c "%U" "$file" 2>/dev/null)
    actual_group=$(stat -c "%G" "$file" 2>/dev/null)
    if [ "$actual_user" != "$expected_user" ] || [ "$actual_group" != "$expected_group" ]; then
        echo -e "${BRed}FAIL${NO_COLOR}: $file should be ${expected_user}:${expected_group}, got ${actual_user}:${actual_group}"
        PASS=0
    else
        echo -e "${BGreen}OK${NO_COLOR}: $file is ${actual_user}:${actual_group}"
    fi
}

echo "Checking ownership requirements..."
check_owner "vault/access.key" "escape" "escape"
check_owner "vault/config.cfg" "escape" "escape"
check_owner "vault/secret.dat" "escape" "escape"

if [ "$PASS" = "1" ]; then
    echo ""
    echo -e "${BGreen}OWNERSHIP VAULT UNLOCKED!${NO_COLOR}"
    echo -e "${BYELLOW}All ownership conditions satisfied!${NO_COLOR}"
    echo ""
    echo -e "The password for Room 53 is: ${BYELLOW}netprobe${NO_COLOR}"
    echo ""
else
    echo ""
    echo -e "${BRed}Some ownership conditions not met. Fix them and retry.${NO_COLOR}"
    echo "Hint: chown escape:escape vault/access.key vault/config.cfg vault/secret.dat"
fi
