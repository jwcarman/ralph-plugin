---
description: "Scaffold the Ralph Loop into the current git repo"
---

# Ralph Init

Scaffold the Ralph Loop into the current directory.

1. Check if `loop.sh` already exists — if so, warn the user and stop
2. Download the latest ralph files from `https://raw.githubusercontent.com/jwcarman/ralph/main/`:
   - `loop.sh`
   - `CLAUDE.md`
   - `PRD.example.md`
   - `specs/000-spec-template.md.example`
3. Create directories: `specs/`, `specs/done/`, `specs/backlog/`
4. Create `progress.txt` with initial state:
   ```
   LAST_RUN: never
   ITERATION: 0
   SPEC_COMPLETED: none
   WHAT_WAS_DONE: initial setup
   VERIFICATION: n/a
   STATUS: MORE_WORK
   NEXT_SPEC: first file in specs/
   NOTES: First run. Read CLAUDE.md and PRD.md fully before doing anything.
   ```
5. Add `logs/` to `.gitignore` if not already present
6. Make `loop.sh` executable: `chmod +x loop.sh`
7. Tell the user: copy `PRD.example.md` to `PRD.md` and fill it out, then run `/ralph-spec` to write their first spec
