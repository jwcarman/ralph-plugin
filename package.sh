#!/usr/bin/env bash
# Package the ralph skill as a ZIP for distribution via Claude's skill installer
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT="$SCRIPT_DIR/ralph-skill.zip"

rm -f "$OUTPUT"
cd "$SCRIPT_DIR"

zip -r "$OUTPUT" ralph-skill/ 2>/dev/null || (
  # Create the correctly-named directory structure on the fly
  TMP=$(mktemp -d)
  mkdir -p "$TMP/ralph-skill"
  cp Skill.md "$TMP/ralph-skill/"
  cd "$TMP"
  zip -r "$OUTPUT" ralph-skill/
  rm -rf "$TMP"
)

echo "Packaged: $OUTPUT"
echo "Install: open Claude > Customize > Skills > Add skill > upload ralph-skill.zip"
