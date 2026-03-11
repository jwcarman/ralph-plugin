# Ralph Update Command Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Add a `/ralph-plugin:update` command that overwrites all plugin-managed assets in the current project.

**Architecture:** Single new command file `commands/update.md`. No code changes — just a skill instruction file following the same pattern as `commands/init.md`.

**Tech Stack:** Claude Code skill (markdown), Bash tools

---

### Task 1: Create `commands/update.md`

**Files:**
- Create: `commands/update.md`

**Step 1: Write the file**

```markdown
---
description: "Update Ralph Loop assets in the current repo"
allowed-tools: ["Bash", "Read"]
---

# Ralph Update

Update all plugin-managed assets in the current directory by overwriting them
with the latest versions from the plugin.

## Steps

1. Check that `ralph-loop.sh` exists in the current directory. If not, stop:
   > "Ralph is not initialized here. Run `/ralph-plugin:init` first."

2. Copy all assets from `${CLAUDE_PLUGIN_ROOT}/assets/`:
   ```bash
   cp "${CLAUDE_PLUGIN_ROOT}/assets/ralph-loop.sh" ./ralph-loop.sh
   chmod +x ./ralph-loop.sh
   cp "${CLAUDE_PLUGIN_ROOT}/assets/PRD.example.md" ./PRD.example.md
   cp "${CLAUDE_PLUGIN_ROOT}/assets/specs/000-spec-template.md.example" \
     ./specs/000-spec-template.md.example
   ```

3. Tell the user which files were updated:
   - `ralph-loop.sh`
   - `PRD.example.md`
   - `specs/000-spec-template.md.example`

4. Remind them: "You may want to commit these changes."
```

**Step 2: Verify file exists and is valid**

```bash
cat commands/update.md
```

Expected: file prints without error, frontmatter is well-formed.

**Step 3: Commit**

```bash
git add commands/update.md docs/plans/2026-03-10-update-command.md
git commit -m "feat: add ralph-plugin:update command"
```
