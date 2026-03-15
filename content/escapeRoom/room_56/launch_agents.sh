#!/bin/bash
echo "Launching rogue agents..."

# Agent keeper - writes key to log
cat > /tmp/agent_keeper.sh << 'AGENT'
#!/bin/bash
echo "KEEPER_KEY=allclear" > /tmp/agent_keeper.log
while true; do sleep 5; done
AGENT
chmod +x /tmp/agent_keeper.sh
nohup /tmp/agent_keeper.sh > /dev/null 2>&1 &

# Worker agents - decoys
for i in 1 2 3; do
    cat > /tmp/agent_worker_$i.sh << 'WORKER'
#!/bin/bash
while true; do sleep 3; done
WORKER
    chmod +x /tmp/agent_worker_$i.sh
    nohup bash /tmp/agent_worker_$i.sh > /dev/null 2>&1 &
done

echo "Agents launched. Use: pgrep -a agent"
