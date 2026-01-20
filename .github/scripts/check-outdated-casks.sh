#!/bin/bash

# Script to parse brew livecheck JSON output and extract outdated casks
# Usage: ./check-outdated-casks.sh "<livecheck_json_output>"

set -euo pipefail

LIVECHECK_OUTPUT="${1:-}"

if [ -z "$LIVECHECK_OUTPUT" ]; then
  echo "[]"
  exit 0
fi

# Parse JSON and extract cask names where version.outdated is true
# Expected format from brew livecheck --json:
# [
#   {
#     "formula": "krokiet",
#     "version": {
#       "current": "10.0.0",
#       "latest": "10.1.0",
#       "outdated": true
#     }
#   }
# ]

OUTDATED_CASKS=$(echo "$LIVECHECK_OUTPUT" | jq -r '
  [
    .[] |
    select(.version.outdated == true) |
    .formula
  ] |
  unique
' 2>/dev/null || echo "[]")

# Fallback if jq parsing fails
if [ -z "$OUTDATED_CASKS" ] || [ "$OUTDATED_CASKS" = "null" ]; then
  OUTDATED_CASKS="[]"
fi

echo "$OUTDATED_CASKS"
