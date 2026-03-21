#!/bin/bash
source ../_utils.sh

TOTAL_MEM=$1
LOAD1=$2
RUNNING=$3

if [ -z "$TOTAL_MEM" ] || [ -z "$LOAD1" ] || [ -z "$RUNNING" ]; then
    echo "Usage: ./getKey.sh <total_mem_mb> <load1_avg> <running_procs>"
    echo "Example: ./getKey.sh 2048 0.42 2"
    echo "Hint: Parse system_snapshot.txt with grep and awk"
    exit 1
fi

if [ "$TOTAL_MEM" = "2048" ] && [ "$LOAD1" = "0.42" ] && [ "$RUNNING" = "2" ]; then
    echo ""
    echo -e "${BGreen}SYSTEM MONITOR UNLOCKED!${NO_COLOR}"
    echo -e "${BYELLOW}Resource anomaly identified and neutralized!${NO_COLOR}"
    echo ""
    echo -e "The password for Room 55 is: ${BYELLOW}sysinfo9${NO_COLOR}"
    echo ""
else
    echo -e "${BRed}Incorrect values. Check the system_snapshot.txt more carefully.${NO_COLOR}"
    echo "Hint: grep 'Mem:' system_snapshot.txt | awk '{print \$2}'"
    echo "Hint: grep 'load average' system_snapshot.txt | awk -F': ' '{print \$2}' | cut -d, -f1 | xargs"
    echo "Hint: grep 'running' system_snapshot.txt | awk '{print \$4}'"
fi
