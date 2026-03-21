#!/bin/bash
mkdir -p parts/alpha parts/beta parts/gamma

# Create 7 part files with fixed values summing to 777
printf "VALUE=100\n" > parts/alpha/part_01.part
printf "VALUE=200\n" > parts/alpha/part_02.part
printf "VALUE=150\n" > parts/beta/part_03.part
printf "VALUE=127\n" > parts/beta/part_04.part
printf "VALUE=50\n"  > parts/gamma/part_05.part
printf "VALUE=75\n"  > parts/gamma/part_06.part
printf "VALUE=75\n"  > parts/gamma/part_07.part

# Decoy files (not .part, will be ignored by find)
printf "DECOY=999\n" > parts/alpha/noise.txt
printf "DECOY=888\n" > parts/beta/ignore.dat

chmod -R 644 parts/
