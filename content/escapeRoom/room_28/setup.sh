#!/bin/bash
mkdir -p chambers
# Create 50 chamber files each containing 1 - total sum = 50
for i in $(seq -w 1 50); do
    echo 1 > "chambers/chamber_${i}.txt"
done
