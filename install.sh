#!/usr/bin/env bash
# Install the ralph skill for Claude Code
set -euo pipefail

SKILL_DIR="${HOME}/.claude/skills/ralph"

mkdir -p "$SKILL_DIR"
cp "$(dirname "$0")/SKILL.md" "$SKILL_DIR/SKILL.md"

echo "ralph skill installed to $SKILL_DIR"
echo "Invoke it with: /ralph init, /ralph spec, /ralph run, /ralph status, /ralph promote"
