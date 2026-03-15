#!/usr/bin/env bash
set -euo pipefail

expected="welldone"

# Test for room_01: compute the hidden message by
# 1) listing files (including hidden) in descending size order
# 2) ignoring any *.txt files (filter-out step)
# 3) taking the first letter of each filename (ignoring a leading dot)
# 4) concatenating, lowercasing, and comparing to expected secret

ROOM_DIR="$(git rev-parse --show-toplevel)/content/escapeRoom/room_01"
FILES_DIR="$ROOM_DIR/room_files"

if [ ! -d "$FILES_DIR" ]; then
  echo "room_files directory not found: $FILES_DIR" >&2
  exit 2
fi

cd "$FILES_DIR"

# Get list of files including hidden ones, sorted by size (descending).
# Use ls -1AS which lists one entry per line, includes hidden files (-A), and
# sorts by size (-S). This is simple and works on macOS / BSD ls.
mapfile -t names < <(ls -1AS 2>/dev/null || true)

if [ ${#names[@]} -eq 0 ]; then
  echo "No files found in $FILES_DIR" >&2
  exit 3
fi

secret=""
for name in "${names[@]}"; do
  # filter out files with .txt extension as per room instructions
  case "$name" in
    *.txt) continue ;;
  esac

  # remove leading dot for hidden files when taking the first letter
  bare_name="${name#.}"
  first_char="${bare_name:0:1}"
  secret+="$first_char"
done

secret_lower="$(printf '%s' "$secret" | tr '[:upper:]' '[:lower:]')"
if [ "$secret_lower" = "$expected" ]; then
  echo "PASS: discovered secret '$secret_lower' matches expected '$expected'"
  exit 0
else
  echo "FAIL: discovered secret '$secret_lower' does not match expected '$expected'" >&2
  echo "Computed sequence of filenames (top-to-bottom):" >&2
  printf '%s\n' "${names[@]}" >&2
  exit 1
fi
