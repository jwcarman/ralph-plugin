---
name: ralph-loop
description: This skill should be used when the user asks to "set up ralph", "init ralph", "write a spec", "start the loop", "check ralph status", "promote backlog", or mentions the Ralph Loop workflow.
---

# Ralph Loop

Ralph is an autonomous spec-by-spec development loop. Bash controls the outer loop. Claude executes one iteration at a time. Tests are the judge.

## Commands

| Command | What it does |
|---------|-------------|
| `/ralph-init` | Scaffold the Ralph Loop into the current git repo |
| `/ralph-spec` | Guided brainstorming to write a new spec |
| `/ralph-run` | Execute one iteration (pick spec → implement → verify → update progress) |
| `/ralph-status` | Show progress, remaining specs, recent commits |
| `/ralph-promote` | Promote `specs/backlog/` items to the active queue |

## How the loop works

```
loop.sh (bash)
  └── calls: claude --dangerously-skip-permissions --print "/ralph-run"
        └── picks lowest-numbered spec in specs/
        └── implements, verifies, moves to specs/done/
        └── updates progress.txt
        └── exits
  └── commits changes
  └── checks STATUS in progress.txt
  └── loops or stops
```

## Notes

- Never run without a `PRD.md` — the agent will have no project context
- Keep specs small — one focused feature per spec
- The loop commits after every iteration — git history is the audit trail
- If `STATUS: NEEDS_HUMAN` appears in `progress.txt`, read `REASON:` and resolve before restarting
- Agent-discovered work goes in `specs/backlog/` — run `/ralph-promote` to queue it
