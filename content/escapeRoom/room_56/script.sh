#!/bin/bash
source ../_utils.sh

# Check if all agent processes are stopped
KEEPER_RUNNING=$(pgrep -f "agent_keeper.sh" 2>/dev/null | wc -l)
WORKERS_RUNNING=$(pgrep -f "agent_worker" 2>/dev/null | wc -l)

if [ "$KEEPER_RUNNING" -gt 0 ] || [ "$WORKERS_RUNNING" -gt 0 ]; then
    echo -e "${BRed}Agents still running!${NO_COLOR}"
    echo "Keeper processes: $KEEPER_RUNNING"
    echo "Worker processes: $WORKERS_RUNNING"
    echo "Hint: pkill -f agent_keeper.sh && pkill -f agent_worker"
    exit 1
fi

echo ""
echo -e "${BGreen}ALL AGENTS TERMINATED!${NO_COLOR}"
echo -e "${BYELLOW}Process control mastered!${NO_COLOR}"
echo ""
echo -e "The bonus track completion code is: ${BYELLOW}allclear${NO_COLOR}"
echo ""
echo -e "${BGreen}=== BONUS TRACK COMPLETE ===${NO_COLOR}"
echo -e "You have mastered all 56 rooms + bonus track!"
echo -e "Use ${BYELLOW}masterkey${NO_COLOR} to access the Exit Exam (room_99)."
echo ""
