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

1. Download [`ralph-skill.zip`](https://github.com/jwcarman/ralph-skill/releases/latest/download/ralph-skill.zip)
2. Open Claude → **Customize → Skills → Add skill**
3. Upload `ralph-skill.zip`

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

## Building from source

```bash
git clone https://github.com/jwcarman/ralph-skill.git
cd ralph-skill
chmod +x package.sh
./package.sh
# Upload the generated ralph-skill.zip via Claude > Customize > Skills
```

## Related

- [ralph](https://github.com/jwcarman/ralph) — the Ralph Loop template (loop.sh, CLAUDE.md, PRD.example.md)
