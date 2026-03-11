---
description: "Promote specs from specs/backlog/ into the active queue with a numeric prefix"
---

# Ralph Promote

Promote items from `specs/backlog/` to the active queue.

1. List all files in `specs/backlog/`
2. If empty, tell the user there is nothing to promote
3. Ask the user which ones to promote (show the list, allow "all" or individual selection)
4. For each selected item:
   - Determine the next available spec number from `ls specs/`
   - Move the file to `specs/NNN-original-name.md`
5. Confirm what was promoted and what number each received
