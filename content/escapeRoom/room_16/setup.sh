#!/bin/bash
# Create station directories with different sizes
mkdir -p station/reactor station/cargo station/living station/engine station/labs

# Make reactor the largest by filling it with data
dd if=/dev/urandom bs=1K count=500 2>/dev/null | base64 > station/reactor/core_data.bin
dd if=/dev/urandom bs=1K count=50 2>/dev/null | base64 > station/cargo/manifest.bin
dd if=/dev/urandom bs=1K count=30 2>/dev/null | base64 > station/living/records.bin
dd if=/dev/urandom bs=1K count=20 2>/dev/null | base64 > station/engine/logs.bin
dd if=/dev/urandom bs=1K count=10 2>/dev/null | base64 > station/labs/data.bin
