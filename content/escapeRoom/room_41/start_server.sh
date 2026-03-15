#!/bin/bash
# Start a simple netcat server that responds to the magic word
PORT=4444
echo "Starting secret server on port $PORT..."
echo "Connect with: echo 'OPEN' | nc localhost $PORT"

# Listen for one connection; if it sends OPEN, reply with the password
while true; do
    RESPONSE=$(nc -l -p $PORT 2>/dev/null || nc -l $PORT 2>/dev/null)
    if echo "$RESPONSE" | grep -q "OPEN"; then
        echo "ncat7" | (nc -l -p $PORT 2>/dev/null || nc -l $PORT 2>/dev/null)
        break
    fi
done
