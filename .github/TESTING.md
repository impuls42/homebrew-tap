# Testing the Workflow_Run Trigger Fix

## What Was Changed

The PR Auto-Merge workflow has been updated to use the `workflow_run` trigger, which solves the issue where PRs created by `GITHUB_TOKEN` don't trigger other workflows.

### Key Changes:

1. **Added `workflow_run` trigger** in `.github/workflows/pr-auto-merge.yml`
   - Triggers automatically when the `Auto-Update` workflow completes
   - Processes all open PRs with the "automatic" label

2. **Removed ineffective workaround** from `.github/scripts/create-update-pr.sh`
   - Removed the label toggle workaround (it didn't work anyway)
   - Simplified the script

3. **Updated workflow logic** to handle two trigger types:
   - `workflow_run`: Finds and processes all automatic PRs
   - `pull_request`: Handles manual triggers (labeled, opened, synchronize events)

## How to Test

### Automatic Test (Recommended)
Wait for the next scheduled Auto-Update run (daily at 6 AM UTC) or trigger it manually:

1. Go to: https://github.com/impuls42/homebrew-tap/actions/workflows/auto-update.yml
2. Click "Run workflow"
3. Wait for it to complete
4. Observe that PR Auto-Merge workflow automatically starts processing any automatic PRs

### Manual Test
You can also test by manually triggering the PR Auto-Merge workflow on an existing PR:

1. Ensure PR #2 has the "automatic" label
2. Push a new commit to PR #2 or add/remove/re-add the label
3. The workflow should trigger via the `pull_request` event

## Verification Steps

Once a test runs:

1. **Check workflow triggered:**
   - Go to: https://github.com/impuls42/homebrew-tap/actions/workflows/pr-auto-merge.yml
   - Verify the workflow ran after Auto-Update completed
   - Check the "triggered by" should show "workflow_run"

2. **Check PRs processed:**
   - Open PRs with "automatic" label should show:
     - Validation comment from the bot
     - Approval (if validation passed)
     - Auto-merge enabled

3. **Check logs:**
   - Review the "Find PRs to Process" job logs
   - Verify it found the correct PRs
   - Check the "Validate and Auto-Merge" job processed them

## Expected Behavior

### When Auto-Update Creates/Updates a PR:

1. Auto-Update workflow runs (manually triggered or scheduled)
2. Creates or updates PRs with "automatic" label
3. **Auto-Update completes**
4. **PR Auto-Merge workflow automatically triggers** ← This is the fix!
5. PR Auto-Merge finds all "automatic" PRs
6. Validates each PR (brew audit, brew style)
7. If validation passes:
   - Adds success comment
   - Approves the PR
   - Enables auto-merge
   - PR merges automatically
8. If validation fails:
   - Adds failure comment
   - Requests review from repository owner

### Differences from Before:

**Before (Broken):**
- Auto-Update creates PR
- Tries to trigger PR Auto-Merge by toggling label
- **Doesn't work** - label changes by GITHUB_TOKEN don't trigger workflows
- PR sits there waiting for manual intervention

**After (Fixed):**
- Auto-Update creates PR
- Auto-Update completes
- **workflow_run trigger fires automatically** ✅
- PR Auto-Merge processes the PR
- PR gets validated and merged automatically

## Troubleshooting

If the workflow doesn't trigger:

1. **Check workflow_run trigger:**
   ```bash
   # View the workflow file
   cat .github/workflows/pr-auto-merge.yml | grep -A 5 "workflow_run:"
   ```
   Should show: `workflows: ["Auto-Update"]`

2. **Check Auto-Update workflow name:**
   ```bash
   # Verify the name matches
   grep "^name:" .github/workflows/auto-update.yml
   ```
   Should show: `name: Auto-Update`

3. **Check PRs have the label:**
   - PRs must have the "automatic" label
   - The label must be added before or during PR creation

4. **Check workflow permissions:**
   - Go to Settings → Actions → General
   - Verify "Allow GitHub Actions to create and approve pull requests" is enabled

## Additional Resources

- See `.github/WORKFLOW_TRIGGER_SOLUTIONS.md` for detailed explanation of all solutions
- See GitHub Actions workflow runs: https://github.com/impuls42/homebrew-tap/actions
- See open PRs: https://github.com/impuls42/homebrew-tap/pulls

## Next Steps

After merging this PR:
1. The fix will be active
2. Next Auto-Update run will use the new workflow_run trigger
3. Verify PRs are automatically processed and merged
4. No more manual intervention needed! 🎉
