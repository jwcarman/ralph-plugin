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
   mkdir -p specs
   cp "${CLAUDE_PLUGIN_ROOT}/assets/specs/000-spec-template.md.example" \
     ./specs/000-spec-template.md.example
   ```

3. Tell the user which files were updated:
   - `ralph-loop.sh`
   - `PRD.example.md`
   - `specs/000-spec-template.md.example`

4. Remind them: "You may want to commit these changes."
