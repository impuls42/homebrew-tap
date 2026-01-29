#!/bin/bash

# Script to parse brew livecheck JSON output and extract outdated casks/formulas
# Usage: ./check-outdated.sh "<livecheck_json_output>"
# Output: JSON array with name and type for each outdated item

set -euo pipefail

LIVECHECK_OUTPUT="${1:-}"

if [ -z "$LIVECHECK_OUTPUT" ]; then
  echo "[]"
  exit 0
fi

# Strip ANSI escape codes first (they can interfere with pattern matching)
# Use $'...' syntax to properly interpret the escape character
CLEAN_OUTPUT=$(echo "$LIVECHECK_OUTPUT" | sed $'s/\x1b\\[[0-9;]*m//g')

# Extract JSON array from output (livecheck may include warnings/gem install text)
# Look for lines starting with [ or whitespace followed by JSON content
JSON_CONTENT=$(echo "$CLEAN_OUTPUT" | sed -n '/^[[:space:]]*\[/,/^[[:space:]]*\]/p')

if [ -z "$JSON_CONTENT" ]; then
  echo "[]"
  exit 0
fi

# Parse JSON and extract items where version.outdated is true
# Returns array of objects with name and type
# Casks have "cask" field, formulas have "formula" field
OUTDATED_ITEMS=$(echo "$JSON_CONTENT" | jq -r '
  [
    .[] |
    select(.version.outdated == true) |
    if .cask then
      {name: .cask, type: "cask"}
    else
      {name: .formula, type: "formula"}
    end
  ] |
  unique_by(.name)
' 2>/dev/null || echo "[]")

# Fallback if jq parsing fails
if [ -z "$OUTDATED_ITEMS" ] || [ "$OUTDATED_ITEMS" = "null" ]; then
  OUTDATED_ITEMS="[]"
fi

echo "$OUTDATED_ITEMS"
