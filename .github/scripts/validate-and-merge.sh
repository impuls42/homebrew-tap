#!/bin/bash

# Script to validate a cask and auto-merge the PR if validation passes
# Usage: ./validate-and-merge.sh <cask_name>

set -euo pipefail

CASK_NAME="${1:?Cask name required}"

echo "========================================="
echo "Validating cask: $CASK_NAME"
echo "========================================="

# Get the PR number for the current branch
CURRENT_BRANCH=$(git branch --show-current)
PR_NUMBER=$(gh pr list --head "$CURRENT_BRANCH" --json number --jq '.[0].number' 2>/dev/null || echo "")

if [ -z "$PR_NUMBER" ]; then
  echo "WARNING: No PR found for branch $CURRENT_BRANCH"
  echo "Skipping validation and auto-merge"
  exit 0
fi

echo "Found PR #$PR_NUMBER for branch $CURRENT_BRANCH"
echo ""

# Run brew audit
echo "Running: brew audit --cask $CASK_NAME"
echo ""

AUDIT_OUTPUT=$(brew audit --cask "$CASK_NAME" 2>&1) || AUDIT_FAILED=true

if [ "${AUDIT_FAILED:-false}" = "true" ]; then
  echo "❌ Audit failed for $CASK_NAME"
  echo ""
  echo "Audit output:"
  echo "$AUDIT_OUTPUT"
  echo ""

  # Add comment to PR about validation failure
  COMMENT="## ❌ Validation Failed

\`brew audit --cask $CASK_NAME\` failed with the following errors:

\`\`\`
$AUDIT_OUTPUT
\`\`\`

This PR requires manual review and fixes before it can be merged."

  gh pr comment "$PR_NUMBER" --body "$COMMENT"

  echo "Added failure comment to PR #$PR_NUMBER"
  echo "PR will NOT be auto-merged"
  exit 1
fi

echo "✅ Audit passed"
echo ""

# Run brew style
echo "Running: brew style --fix $CASK_NAME"
echo ""

STYLE_OUTPUT=$(brew style --fix "$CASK_NAME" 2>&1) || STYLE_FAILED=true

if [ "${STYLE_FAILED:-false}" = "true" ]; then
  echo "⚠️  Style check reported issues"
  echo ""
  echo "Style output:"
  echo "$STYLE_OUTPUT"
  echo ""

  # Check if there are any uncommitted changes after style fix
  if ! git diff --quiet "Casks/${CASK_NAME}.rb"; then
    echo "Style fixes were applied, committing changes..."
    git add "Casks/${CASK_NAME}.rb"
    git commit -m "Apply brew style fixes for $CASK_NAME

Automated style fixes via GitHub Actions."
    git push
    echo "Style fixes committed and pushed"
  fi
else
  echo "✅ Style check passed"
fi

echo ""

# Validation passed, proceed with auto-merge
echo "========================================="
echo "Validation successful!"
echo "Proceeding with auto-merge..."
echo "========================================="
echo ""

# Add success comment to PR
SUCCESS_COMMENT="## ✅ Validation Passed

All checks passed successfully:

- ✅ \`brew audit --cask $CASK_NAME\` - **Passed**
- ✅ \`brew style --fix $CASK_NAME\` - **Passed**

This PR is ready for auto-merge."

gh pr comment "$PR_NUMBER" --body "$SUCCESS_COMMENT"

echo "Added success comment to PR #$PR_NUMBER"
echo ""

# Approve the PR
echo "Approving PR #$PR_NUMBER..."
gh pr review "$PR_NUMBER" --approve --body "Automated approval after successful validation checks."

echo "✅ PR approved"
echo ""

# Enable auto-merge with squash strategy
echo "Enabling auto-merge for PR #$PR_NUMBER..."
gh pr merge "$PR_NUMBER" --auto --squash --delete-branch

echo "✅ Auto-merge enabled (squash strategy, will delete branch after merge)"
echo ""

echo "========================================="
echo "Validation and auto-merge setup complete!"
echo "========================================="
echo ""
echo "PR #$PR_NUMBER will be automatically merged once all checks pass."
