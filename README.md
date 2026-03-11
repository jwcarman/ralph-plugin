# ralph-skill

A [Claude Code](https://docs.anthropic.com/en/docs/claude-code) skill for managing [Ralph Loop](https://github.com/jwcarman/ralph) projects.

## What it does

Adds a `/ralph` command to Claude Code with subcommands for the full Ralph Loop workflow:

| Command | What it does |
|---------|-------------|
| `/ralph init` | Scaffold the Ralph Loop into any git repo |
| `/ralph spec` | Guided brainstorming to write a new spec |
| `/ralph run` | Start the loop (`./loop.sh`) |
| `/ralph status` | Show progress, remaining specs, recent commits |
| `/ralph promote` | Promote `specs/backlog/` items to the active queue |

## Installation

```bash
git clone https://github.com/jwcarman/ralph-skill.git
cd ralph-skill
chmod +x install.sh
./install.sh
```

That's it. The skill is installed to `~/.claude/skills/ralph/` and immediately available in Claude Code.

## Usage

Open Claude Code in any git repo and type:

```
/ralph init
```

Follow the prompts to set up the Ralph Loop, write your first spec, and start the loop.

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed and authenticated
- A Claude Max subscription (recommended — runs against your subscription, not API credits)
- Git

## Related

- [ralph](https://github.com/jwcarman/ralph) — the Ralph Loop template (loop.sh, CLAUDE.md, PRD.example.md)
