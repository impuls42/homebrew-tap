# impuls42/homebrew-tap

Homebrew tap for custom formulae and casks.

## Automated Version Updates

This tap uses GitHub Actions to automatically check for new versions, create pull requests, validate changes, and merge updates without manual intervention.

### How It Works

1. **Daily Version Check** (6 AM UTC)
   - Runs `brew livecheck` to detect outdated packages
   - Creates/updates PRs for new versions
   - PRs are automatically labeled with "automatic"

2. **Automatic Validation** (Triggered after Auto-Update completes)
   - Runs `brew audit` to check for issues
   - Runs `brew style` to ensure code quality
   - Downloads binaries and verifies checksums

3. **Automatic Approval & Merge**
   - If validation passes: PR is approved and merged automatically
   - If validation fails: Repository owner is notified for manual review

### Technical Details

The automation uses a `workflow_run` trigger to chain the workflows together:
- The `Auto-Update` workflow creates/updates PRs
- When `Auto-Update` completes, it automatically triggers `PR Auto-Merge`
- This solves GitHub's limitation where `GITHUB_TOKEN` cannot trigger workflows on PRs it creates

### Setup Requirements

For full automation, ensure these repository settings are configured:

#### 1. Enable GitHub Actions PR Permissions
**Settings → Actions → General → Workflow permissions:**
- ✅ Enable "Allow GitHub Actions to create and approve pull requests"

#### 2. Enable Auto-Merge
**Settings → General → Pull Requests:**
- ✅ Enable "Allow auto-merge"

#### 3. Branch Protection (Optional)
If you have branch protection enabled on `main`:
- Set "Required approvals" to 0 (or don't require reviews)
- Enable "Require status checks to pass before merging"

### Manual Triggers

You can manually trigger the update workflow:
1. Go to Actions tab
2. Select "Auto-Update" workflow
3. Click "Run workflow"

## Installation

```bash
brew tap impuls42/tap
brew install <package-name>
```

## Packages

- **mcp-router** - Desktop application for managing Model Context Protocol (MCP) servers
- **toolhive-studio** - ToolHive Studio application
- **sdrangel** - SDR software
- **krokiet** - Messaging application
- **firefox-webserial** - Native messaging host for WebSerial API polyfill for Firefox
  - Available as a cask (prebuilt binaries): `brew install --cask firefox-webserial`
  - Available as a formula (build from source): `brew install firefox-webserial`
- **spotctl** - CLI tool for managing Rackspace Spot resources

## Contributing

This tap is primarily automated. If you notice issues:
1. Check the Actions tab for recent workflow runs
2. Review validation logs for failures
3. Submit an issue if you find a problem

## License

See individual package licenses in their respective cask files.
