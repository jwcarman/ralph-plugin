---
description: "Scaffold the Ralph Loop into the current git repo"
---

# Ralph Init

Scaffold the Ralph Loop into the current directory.

1. Check if `ralph-loop.sh` already exists — if so, warn the user and stop
2. Copy files from the plugin's `assets/` directory into the current project:
   ```bash
   cp "${CLAUDE_PLUGIN_ROOT}/assets/ralph-loop.sh" ./ralph-loop.sh
   cp "${CLAUDE_PLUGIN_ROOT}/assets/PRD.example.md" ./PRD.example.md
   mkdir -p specs
   cp "${CLAUDE_PLUGIN_ROOT}/assets/specs/000-spec-template.md.example" ./specs/000-spec-template.md.example
   ```
3. Create directories: `specs/done/`, `specs/backlog/`
4. Create `progress.txt` with initial state:
   ```
   LAST_RUN: never
   ITERATION: 0
   SPEC_COMPLETED: none
   WHAT_WAS_DONE: initial setup
   VERIFICATION: n/a
   STATUS: MORE_WORK
   NEXT_SPEC: first file in specs/
   NOTES: First run. Read PRD.md fully before doing anything.
   ```
5. Add `logs/` to `.gitignore` if not already present
6. Make `ralph-loop.sh` executable: `chmod +x ralph-loop.sh`
7. Tell the user: copy `PRD.example.md` to `PRD.md` and fill it out, then run `/ralph-spec` to write their first spec
