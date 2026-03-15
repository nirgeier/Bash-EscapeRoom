#!/bin/bash
mkdir -p final_challenge

# Numeric values: 100, 200, 300, 400 (sum = 1000)
printf "100\n" | base64 > final_challenge/alpha.key
printf "200\n" | base64 > final_challenge/beta.key
printf "300\n" | base64 > final_challenge/gamma.key
printf "400\n" | base64 > final_challenge/delta.key

# Non-numeric decoys - will be filtered out by grep -E '^[0-9]+$'
printf "decoy_alpha\n" | base64 > final_challenge/noise1.key
printf "IGNORE_ME\n"   | base64 > final_challenge/noise2.key
