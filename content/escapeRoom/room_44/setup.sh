#!/bin/bash
mkdir -p source_archive mirror_archive

# Create 10 files in source_archive
for i in $(seq 1 10); do
    echo "source file $i" > "source_archive/file_$(printf '%02d' $i).txt"
done

# mirror_archive starts with only 5 matching files
for i in $(seq 1 5); do
    echo "source file $i" > "mirror_archive/file_$(printf '%02d' $i).txt"
done

# Add 3 stale files in mirror that are NOT in source (will be deleted with --delete)
echo "stale data 1" > mirror_archive/stale_a.txt
echo "stale data 2" > mirror_archive/stale_b.txt
echo "stale data 3" > mirror_archive/stale_c.txt
