---
name: release
description: Cut a new versioned release of ralph-plugin and sync the marketplace. Use when ready to publish changes to jwcarman-marketplace.
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
user-invocable: true
---

# Release ralph-plugin

Cut a new versioned release and publish it to the marketplace.

## Steps

### 1. Verify clean state

Run `git status` and `git diff`. If there are uncommitted changes, stop and tell the user to commit or stash them first.

### 2. Show what's changed since the last release

Run:
```bash
git log $(git describe --tags --abbrev=0)..HEAD --oneline
```

Display the output so the user can see what's going into this release.

### 3. Determine the new version

- Read the current version from `.claude-plugin/plugin.json`
- Based on the changes shown, suggest a semver bump:
  - **patch** (x.y.Z) — bug fixes only
  - **minor** (x.Y.0) — new features, backwards compatible
  - **major** (X.0.0) — breaking changes
- Ask the user: "Suggested version is X.Y.Z — confirm or enter a different version?"
- Wait for their response.

### 4. Update plugin.json

Edit `.claude-plugin/plugin.json` — update the `version` field to the new version.

### 5. Commit the version bump

```bash
git add .claude-plugin/plugin.json
git commit -m "chore: bump version to X.Y.Z"
```

### 6. Tag and push

```bash
git tag vX.Y.Z
git push origin main
git push origin vX.Y.Z
```

### 7. Update the marketplace

- Edit `../jwcarman-marketplace/.claude-plugin/marketplace.json`
- Find the `ralph-plugin` entry and update its `version` field to match.

Then commit and push:
```bash
cd ../jwcarman-marketplace
git add .claude-plugin/marketplace.json
git commit -m "chore: update ralph-plugin to vX.Y.Z"
git push origin main
```

### 8. Confirm

Tell the user:
- The tag that was pushed (`vX.Y.Z`)
- That the marketplace has been updated
- That users running `/plugin install ralph-plugin@jwcarman-marketplace` will now get the new version
