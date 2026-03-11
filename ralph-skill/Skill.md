---
name: Ralph Loop
description: Manage Ralph Loop projects. Commands: init (scaffold into repo), spec (write a new spec), run (start the loop), status (check progress), promote (promote backlog items).
---

# Ralph Loop

## Overview

Ralph is an autonomous software evolution loop. Bash controls the loop. Claude writes and verifies the code. Tests are the judge.

Read the args the user passed to determine which command to run.

## Commands

### `init`

Scaffold the Ralph Loop into the current git repo.

1. Check if `loop.sh` already exists — if so, warn and stop
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
6. Make `loop.sh` executable (`chmod +x loop.sh`)
7. Tell the user: copy `PRD.example.md` to `PRD.md` and fill it out, then run `/ralph spec` to write their first spec

### `spec`

Guide the user through brainstorming a new spec, then write the file.

1. Read `PRD.md` to understand the project
2. Read `progress.txt` and `ls specs/` to understand current state
3. Ask questions one at a time (multiple choice preferred) to understand:
   - What feature or behavior to build
   - Acceptance criteria (machine-checkable preferred)
   - Any implementation notes or constraints
4. Determine the next available spec number from `ls specs/`
5. Write the spec to `specs/NNN-slug.md` using the template in `specs/000-spec-template.md.example`
6. Confirm the file was written and show the user the acceptance criteria

### `run`

Start the loop.

1. Check that `PRD.md` exists — if not, tell the user to run `/ralph init` first
2. Check that at least one spec exists in `specs/` — if not, tell the user to run `/ralph spec` first
3. Run `./loop.sh` (pass any additional args the user provided, e.g. `--once`)

### `status`

Show the current state of the loop.

1. Show `progress.txt`
2. Show remaining specs: `ls specs/*.md`
3. Show completed specs: `ls specs/done/`
4. Show recent commits: `git log --oneline -5`
5. If `specs/backlog/` has items, highlight them and suggest running `/ralph promote`

### `promote`

Promote items from `specs/backlog/` to the active queue.

1. List all files in `specs/backlog/`
2. Ask the user which ones to promote
3. For each selected item:
   - Determine the next available spec number
   - Move the file to `specs/NNN-original-name.md`
4. Confirm what was promoted and what number each received

## Notes

- Never run the loop without a `PRD.md` — the agent will have no context
- Keep specs small — one focused feature per spec
- The loop commits after every iteration — git history is the audit trail
- If the loop writes `STATUS: NEEDS_HUMAN` to `progress.txt`, read the `REASON:` field and resolve the blocker before restarting
