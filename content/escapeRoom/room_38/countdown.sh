#!/bin/bash
echo "COUNTDOWN: Starting..."
echo "STATUS: initializing" >> progress.log
sleep 1
echo "STATUS: running" >> progress.log
echo "NOISE: $(date)" >> progress.log
sleep 1
echo "BOMB_CODE=timeout3" >> progress.log
echo "STATUS: encoding" >> progress.log
sleep 1
echo "NOISE: checksum_9821" >> progress.log
sleep 1
echo "STATUS: almost done" >> progress.log
sleep 100
echo "STATUS: complete" >> progress.log
