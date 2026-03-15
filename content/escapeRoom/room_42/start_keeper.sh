#!/bin/bash
# Create files for the lsof challenge
echo "openfd" > password.txt

# Open secret_key.txt and password.txt on file descriptors 3 and 4
exec 3< secret_key.txt
exec 4< password.txt
echo "Keeper running. PID: $$"
echo "Use: lsof -p $$ | grep password"
sleep 300
