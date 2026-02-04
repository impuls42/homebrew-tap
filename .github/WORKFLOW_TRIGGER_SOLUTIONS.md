# GitHub Actions Workflow Trigger Solutions

## Problem Statement

When GitHub Actions workflows use `GITHUB_TOKEN` to create or update pull requests, those PRs don't trigger other workflows. This is a security feature to prevent infinite workflow loops.

**The Issue:** The `Auto-Update` workflow creates PRs but the `PR Auto-Merge` workflow doesn't trigger, breaking the automation chain.

## Implemented Solution: workflow_run Trigger

**Status:** ✅ Implemented in this repository

The `workflow_run` trigger is designed specifically for chaining workflows and bypasses the `GITHUB_TOKEN` limitation.

### How it works:
1. `Auto-Update` workflow creates/updates PRs
2. When `Auto-Update` completes, GitHub automatically triggers `PR Auto-Merge`
3. `PR Auto-Merge` processes all open PRs with the "automatic" label

### Advantages:
- ✅ No additional setup required
- ✅ No secrets to manage
- ✅ Works with default `GITHUB_TOKEN`
- ✅ Native GitHub feature, reliable
- ✅ No external services needed

### Disadvantages:
- ⚠️ Slightly more complex workflow logic (handled with matrix strategy)
- ⚠️ Processes all automatic PRs at once (but this is actually beneficial)

### Implementation:
```yaml
on:
  workflow_run:
    workflows: ["Auto-Update"]
    types:
      - completed
```

See `.github/workflows/pr-auto-merge.yml` for full implementation.

---

## Alternative Solutions (Not Implemented)

### Option 1: Personal Access Token (PAT)

Create a PAT with `repo` permissions and use it instead of `GITHUB_TOKEN`.

**Advantages:**
- ✅ Simple to implement
- ✅ Reliable workflow triggering

**Disadvantages:**
- ❌ Requires manual token creation and rotation
- ❌ Token expires (classic PATs: 1-90 days, fine-grained: up to 1 year)
- ❌ Security risk if token is leaked
- ❌ PRs show as created by the token owner, not github-actions[bot]

**Implementation:**
1. Create PAT at: https://github.com/settings/tokens
2. Add as repository secret: `Settings → Secrets → Actions → PAT_TOKEN`
3. Update workflow to use `${{ secrets.PAT_TOKEN }}` instead of `${{ github.token }}`

### Option 2: GitHub App

Create a GitHub App with appropriate permissions and use it to authenticate.

**Advantages:**
- ✅ More secure than PAT (scoped to repository)
- ✅ Better audit trail
- ✅ Token auto-refreshes
- ✅ Can have custom bot name/avatar

**Disadvantages:**
- ❌ Complex initial setup
- ❌ Requires installing app to repository
- ❌ Need to manage app credentials (App ID, private key)
- ❌ Overkill for single repository

**Implementation:**
1. Create GitHub App: https://github.com/settings/apps/new
2. Generate private key
3. Install app to repository
4. Store App ID and private key as secrets
5. Use action like `tibdex/github-app-token@v2` to generate tokens

### Option 3: Repository Dispatch Event

Use `repository_dispatch` to manually trigger workflows.

**Advantages:**
- ✅ Explicit control over when workflows trigger
- ✅ Can pass custom data

**Disadvantages:**
- ❌ Requires modifying both workflows
- ❌ More complex logic
- ❌ Still requires PAT or GitHub App to send dispatch event
- ❌ Doesn't solve the underlying authentication issue

**Implementation:**
```yaml
# In Auto-Update workflow
- name: Trigger validation
  run: |
    gh api repos/${{ github.repository }}/dispatches \
      -f event_type=pr-created \
      -f client_payload[pr_number]=$PR_NUMBER

# In PR Auto-Merge workflow
on:
  repository_dispatch:
    types: [pr-created]
```

### Option 4: Scheduled Workflow for PR Processing

Run a scheduled workflow that processes open PRs with the "automatic" label.

**Advantages:**
- ✅ Simple implementation
- ✅ Works with default `GITHUB_TOKEN`
- ✅ No additional secrets

**Disadvantages:**
- ❌ Delayed processing (depends on schedule frequency)
- ❌ Not responsive to PR creation
- ❌ Unnecessary runs when no PRs exist
- ❌ Less efficient resource usage

**Implementation:**
```yaml
on:
  schedule:
    - cron: '*/15 * * * *'  # Every 15 minutes
```

### Option 5: Webhooks with External Service

Set up an external service (AWS Lambda, Vercel, etc.) to receive webhooks and trigger workflows.

**Advantages:**
- ✅ Maximum flexibility
- ✅ Can implement custom logic

**Disadvantages:**
- ❌ Requires external infrastructure
- ❌ Additional costs
- ❌ More points of failure
- ❌ Complex setup and maintenance
- ❌ Security concerns (webhook secrets, endpoint security)
- ❌ Massive overkill for this use case

---

## Why workflow_run is the Best Choice

For this repository's use case, `workflow_run` is the optimal solution because:

1. **Zero Configuration:** Works out of the box with no secrets to manage
2. **Secure:** Uses GitHub's native authentication
3. **Reliable:** Official GitHub feature, well-tested and supported
4. **Immediate:** Triggers as soon as the parent workflow completes
5. **Efficient:** Only runs when needed
6. **Maintainable:** Clear cause-and-effect relationship between workflows

The additional workflow complexity is minimal and well worth the benefits.

## References

- [GitHub Actions: Events that trigger workflows](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#workflow_run)
- [GitHub Actions: Triggering a workflow from a workflow](https://docs.github.com/en/actions/using-workflows/triggering-a-workflow#triggering-a-workflow-from-a-workflow)
- [GitHub Community: Workflow not triggering on PR created by GITHUB_TOKEN](https://github.com/orgs/community/discussions/25702)
