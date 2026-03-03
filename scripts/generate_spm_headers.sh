#!/bin/bash
#
# generate_spm_headers.sh
#
# Generates flat symlinks in Source/include/AsyncDisplayKit/ for all headers
# under Source/. This provides the flat header layout that SPM needs for
# angle-bracket imports like #import <AsyncDisplayKit/ASThread.h>.
#
# Run this script whenever headers are added, removed, or renamed.
#
# Usage:
#   bash scripts/generate_spm_headers.sh

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SOURCE_DIR="$REPO_ROOT/Source"
INCLUDE_DIR="$SOURCE_DIR/include"
HEADERS_DIR="$INCLUDE_DIR/AsyncDisplayKit"

# Create directories if needed
mkdir -p "$HEADERS_DIR"

# Remove existing symlinks (preserve module.modulemap)
find "$HEADERS_DIR" -type l -delete

# Find all .h files under Source/ (excluding include/ itself) and create symlinks
count=0
while IFS= read -r header; do
  filename="$(basename "$header")"
  # Compute relative path from AsyncDisplayKit/ to the header
  relpath="$(python3 -c "import os.path; print(os.path.relpath('$header', '$HEADERS_DIR'))")"
  ln -s "$relpath" "$HEADERS_DIR/$filename"
  count=$((count + 1))
done < <(find "$SOURCE_DIR" -name '*.h' -not -path "$INCLUDE_DIR/*" | sort)

echo "Created $count symlinks in Source/include/AsyncDisplayKit/"
