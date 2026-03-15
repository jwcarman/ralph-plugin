---
description: "Execute one Ralph Loop iteration"
---

# Ralph Run — Single Iteration

Execute one iteration of the Ralph Loop. Pick one spec, do the work, verify it passes, and update `progress.txt`. Then stop — the loop runner will restart for the next iteration.

## Narration

As you work, write brief progress lines so the human can follow along in the log. Output one line at each major step — do not wait until the end. Use this format:

```
▸ Reading spec: 003-add-search.md
▸ Reading PRD.md
▸ Exploring codebase
▸ Planning approach
▸ Implementing
▸ Running tests
▸ Tests passed — moving spec to done/
▸ Done. Next: 004-pagination.md
```

Keep each line short. One line per step. If tests fail and you're iterating, say so:
```
▸ Tests failed — fixing
▸ Running tests again
```

## Before starting

Run these commands to orient yourself:

```bash
cat progress.txt
ls specs/
```

## Picking a spec

Work through `specs/` in filename order (numerically prefixed). Pick the lowest-numbered spec that exists. Do not skip specs. Do not work on more than one spec per iteration.

## The work loop

1. **Read** the spec fully
2. **Read** `PRD.md` for project context, tech stack, test commands, and conventions
3. **Explore** the codebase — understand what exists before writing anything
4. **Plan** — think through the approach before coding
5. **Implement** — write the code
6. **Verify** — run the test/build/lint commands defined in `PRD.md`
7. **Read the output** — if anything fails, fix it and verify again
8. **Repeat** until all acceptance criteria pass
9. **Move** the completed spec to `specs/done/`
10. **Update** `progress.txt`

Do not mark a spec done until its acceptance criteria are machine-verified passing. "It looks right" is not verification. Run the commands.

## Superpowers integration (optional)

If the `superpowers` skills are installed, invoke them at the appropriate steps to reinforce discipline. If they are not installed, the built-in steps above provide equivalent guidance.

| Step | Skill to invoke |
|------|----------------|
| Before step 4 (Plan) | `superpowers:brainstorming` |
| Before step 5 (Implement) | `superpowers:test-driven-development` |
| When step 7 reveals persistent failures | `superpowers:systematic-debugging` |
| Before step 9 (moving spec to done/) | `superpowers:verification-before-completion` |

## Verification discipline

The test/build output is your source of truth. Not your judgment about whether the code looks correct. Run the commands, read every line of output, fix what fails.

If the same test keeps failing after 5 genuine attempts with different approaches, write `STATUS: NEEDS_HUMAN` to `progress.txt` with a full explanation. Do not loop indefinitely on the same failure.

## Code quality

- Write code that a senior engineer would not be embarrassed by
- Match the conventions already in the codebase — don't introduce a new style
- Do not comment obvious things; comment non-obvious decisions
- Do not leave debug prints, commented-out code, or TODOs unless the spec calls for them
- Small focused functions. If a function is getting long, it's doing too much.

## progress.txt format

Overwrite the entire file at the end of every iteration:

```
LAST_RUN: [ISO timestamp]
ITERATION: [number]
SPEC_COMPLETED: [filename or "none"]
WHAT_WAS_DONE: [one clear sentence]
VERIFICATION: [what commands ran and what they returned — pass/fail]
STATUS: [MORE_WORK | DONE | NEEDS_HUMAN]
NEXT_SPEC: [filename of next spec to work on, or "none"]
NOTES: [anything the next iteration needs to know — assumptions made, gotchas found]
```

If `STATUS: NEEDS_HUMAN`, also include:
```
REASON: [exactly what you need and why you can't proceed without it]
ATTEMPTS: [what you already tried]
```

## What you must not do

- Do not make commits — the loop runner handles all git operations
- Do not install packages not already in the project's dependency manifest without noting it in `progress.txt`
- Do not modify files in `specs/done/`
- Do not modify `ralph-loop.sh` or `PRD.md`
- Do not add new specs to `specs/` — the human does that (backlog items go in `specs/backlog/`)
- Do not call external APIs or services unless the spec explicitly requires it and `PRD.md` provides credentials/config
- Do not delete code that isn't directly replaced by the current spec — note it in `progress.txt` and let the human decide
