# ralph-plugin

A [Claude Code](https://docs.anthropic.com/en/docs/claude-code) plugin that turns any git repo into an autonomous AI development loop. Claude implements specs one at a time, runs the tests, and commits — you review and queue more work.

---

## How it works

```
┌─────────────────────────────────────────────────┐
│                 ralph-loop.sh                    │
│                                                  │
│   while specs/ is not empty:                     │
│     claude --print "/ralph-run"  (fresh session) │
│       ↓                                          │
│     reads PRD.md for project context             │
│     picks lowest-numbered spec                   │
│     writes code, runs tests, fixes failures      │
│     moves spec → specs/done/                     │
│     writes progress.txt                          │
│       ↓                                          │
│     bash commits all changes                     │
│     bash pauses, then spawns next session        │
└─────────────────────────────────────────────────┘
```

Every Claude session starts with a clean context window. Files and git history are the only memory. Tests are the judge. No human checkpoints unless the agent gets stuck.

---

## Installation

Add the marketplace (one-time setup):

```
/plugin marketplace add jwcarman/jwcarman-marketplace
```

Then install the plugin:

```
/plugin install ralph-plugin@jwcarman-marketplace
```

---

## Quickstart

### 1. Initialize a repo

Open Claude Code in any git repo and run:

```
/ralph-plugin:init
```

This will:
- Install `ralph-loop.sh` into your project
- Explore your codebase (package.json, pom.xml, README, test configs, etc.)
- Ask you questions one at a time to understand your project
- Write a complete `PRD.md` tailored to your project — no placeholders

### 2. Write your first spec

```
/ralph-plugin:ralph-spec
```

Guided brainstorming — Claude asks what to build, what the acceptance criteria are, and writes the spec file to `specs/001-your-feature.md`.

### 3. Start the loop

```bash
# Run in a tmux session so it keeps going after you close the terminal
tmux new-session -s ralph
./ralph-loop.sh

# Detach: Ctrl+B D    Reattach: tmux attach -t ralph
```

The loop runs until all specs are done or it hits something it can't resolve.

---

## Commands

| Command | What it does |
|---------|-------------|
| `/ralph-plugin:init` | Scaffold Ralph Loop + guided PRD setup |
| `/ralph-plugin:spec` | Write a new spec with guided brainstorming |
| `/ralph-plugin:run` | Execute one iteration (used by `ralph-loop.sh`) |
| `/ralph-plugin:status` | Show progress, remaining specs, recent commits |
| `/ralph-plugin:promote` | Promote `specs/backlog/` items to the active queue |
| `/ralph-plugin:update` | Update `ralph-loop.sh` and other plugin-managed assets to the latest versions |

---

## Managing the loop

### Check what's happening

```bash
# Live log output
tail -f logs/loop-*.log

# Last iteration summary
cat progress.txt

# Remaining work
ls specs/

# Completed specs
ls specs/done/

# Git history
git log --oneline
```

### Run the loop

```bash
./ralph-loop.sh                    # run until done or NEEDS_HUMAN
./ralph-loop.sh --once             # single iteration
./ralph-loop.sh --dry-run          # preview without executing
MAX_ITERATIONS=20 ./ralph-loop.sh  # cap total iterations
PAUSE_SECONDS=30 ./ralph-loop.sh   # slow down between iterations
```

### Emergency controls

```bash
# Stop immediately
Ctrl+C

# Undo last iteration
git reset --hard HEAD~1

# Undo last N iterations
git reset --hard HEAD~N
```

---

## Adding specs

Specs are Markdown files in `specs/` with a numeric prefix. Lower number = picked first.

```bash
# Use the guided command
/ralph-plugin:ralph-spec

# Or copy the template manually
cp specs/000-spec-template.md.example specs/005-add-search.md
# Fill it out, the loop picks it up on the next iteration
```

**Keep specs small.** One focused feature per spec. The agent won't mark a spec done until its acceptance criteria are machine-verified passing.

### Backlog

If the agent discovers work that's out of scope for the current spec, it writes new specs to `specs/backlog/`. These are not picked up automatically — review them and promote the ones you want:

```
/ralph-plugin:ralph-promote
```

---

## When the loop stops itself

If the loop writes `STATUS: NEEDS_HUMAN` to `progress.txt`, read the `REASON:` and `ATTEMPTS:` fields to understand what happened.

To resume:
1. Resolve the blocker
2. Edit `progress.txt` — change `STATUS: NEEDS_HUMAN` to `STATUS: MORE_WORK`
3. Restart `./ralph-loop.sh`

---

## Tuning

The agent uses `PRD.md` to make every judgment call it encounters. When the loop does something wrong, that's a signal to add a rule to `PRD.md` so it never happens again.

Common additions:
- A pattern it keeps getting wrong → **Coding conventions**
- A file it shouldn't touch → **Constraints and guardrails**
- A test command it's running incorrectly → **How to run tests**

The PRD gets sharper over time.

---

## Security

`ralph-loop.sh` uses `--dangerously-skip-permissions`. This is required for autonomous operation — permission prompts would break the loop. It means Claude can read and write anything your user account can access.

- Never put production credentials in the project directory while the loop is running
- Use environment variables for secrets, and confirm your `.env` is in `.gitignore`
- Run in a dedicated tmux session so you can monitor and interrupt if needed

---

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed and authenticated
- A Claude Max subscription (recommended — runs against your subscription, not API credits)
- Git
