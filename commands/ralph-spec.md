---
description: "Guided brainstorming to write a new Ralph Loop spec"
---

# Ralph Spec

Guide the user through brainstorming a new spec, then write the file.

1. Check that `PRD.md` exists — if not, tell the user to run `/ralph-init` first
2. Read `PRD.md` to understand the project
3. Read `progress.txt` and `ls specs/` to understand current state
4. Ask questions one at a time (multiple choice preferred) to understand:
   - What feature or behavior to build
   - Acceptance criteria (machine-checkable preferred)
   - Any implementation notes or constraints
5. Determine the next available spec number from `ls specs/`
6. Write the spec to `specs/NNN-slug.md` using the template in `specs/000-spec-template.md.example`
7. Confirm the file was written and show the user the acceptance criteria
