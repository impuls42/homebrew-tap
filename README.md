# impuls42/homebrew-tap

A Homebrew tap providing formulae and casks that are not available in the official Homebrew repositories.

## Quick Start

```bash
brew tap impuls42/tap
```

Then install any package listed below.

---

## Packages

### Casks (macOS applications)

| Cask | Description | Install |
|------|-------------|---------|
| **mcp-router** | Desktop app for managing Model Context Protocol (MCP) servers | `brew install --cask mcp-router` |
| **toolhive-studio** | Install, manage and run MCP servers and connect them to AI agents | `brew install --cask toolhive-studio` |
| **openchamber** | Desktop and web interface for OpenCode AI agent | `brew install --cask openchamber` |
| **sdrangel** | SDR Rx/Tx software for Airspy, BladeRF, HackRF, LimeSDR, RTL-SDR | `brew install --cask sdrangel` |
| **krokiet** | Czkawka frontend written in Slint (arm64 only) | `brew install --cask krokiet` |
| **firefox-webserial** | Native messaging host for WebSerial API polyfill for Firefox | `brew install --cask firefox-webserial` |
| **murus** | Firewall app for macOS | `brew install --cask murus` |
| **xpra** | Screen and application forwarding system (arm64 only) | `brew install --cask xpra` |

### Formulae (CLI tools)

| Formula | Description | Install |
|---------|-------------|---------|
| **dagger** | Integrated platform to orchestrate the delivery of applications | `brew install impuls42/tap/dagger` |
| **spotctl** | CLI tool for managing Rackspace Spot resources | `brew install impuls42/tap/spotctl` |
| **mux** | Desktop app for isolated, parallel agentic development — installs the upstream AppImage (Linux x86_64/arm64 only) | `brew install impuls42/tap/mux` |

---

## Automated Version Updates

This tap uses GitHub Actions to keep packages up to date automatically.

### Workflow

1. **Daily Version Check** — runs `brew livecheck` at 6 AM UTC, opens or updates a PR for any new version found, and labels it `automatic`.
2. **Validation** — triggered when the update PR is opened; runs `brew audit`, `brew style`, and verifies checksums.
3. **Auto-Merge** — if all checks pass the PR is approved and merged automatically; otherwise the repository owner is notified for manual review.

> The workflows use a `workflow_run` trigger to chain steps together, working around the GitHub limitation where `GITHUB_TOKEN` cannot trigger follow-on workflows on PRs it creates.

### Manual Trigger

1. Go to the **Actions** tab.
2. Select the **Auto-Update** workflow.
3. Click **Run workflow**.

### Repository Settings Required

| Setting | Location | Value |
|---------|----------|-------|
| Allow Actions to create and approve PRs | Settings → Actions → General → Workflow permissions | ✅ Enabled |
| Allow auto-merge | Settings → General → Pull Requests | ✅ Enabled |

---

## Contributing

This tap is primarily maintained through automation. If you notice a problem:

1. Check the **Actions** tab for recent workflow run logs.
2. Open an issue describing the problem.

---

## License

Each package is distributed under its own upstream license. See the individual formula or cask file for details.
