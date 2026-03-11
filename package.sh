#!/usr/bin/env bash
# Package the ralph-loop skill as a ZIP for distribution via Claude's skill installer
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT="$SCRIPT_DIR/ralph-skill.zip"

rm -f "$OUTPUT"
cd "$SCRIPT_DIR"

zip -r "$OUTPUT" ralph-loop/

echo "Packaged: $OUTPUT"
echo "Install: open Claude > Customize > Skills > Add skill > upload ralph-skill.zip"
