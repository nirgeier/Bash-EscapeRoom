#!/bin/bash
# Create door_log.txt with exactly 100 OPEN doors out of 200 total
{
  for i in $(seq 1 100); do
    echo "door_$(printf '%03d' $i) OPEN"
  done
  for i in $(seq 101 200); do
    echo "door_$(printf '%03d' $i) CLOSED"
  done
} | shuf > door_log.txt
