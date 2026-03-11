---
description: "Show Ralph Loop progress: current state, remaining specs, completed specs, recent commits"
---

# Ralph Status

Show the current state of the Ralph Loop.

1. Show `progress.txt`
2. Show remaining specs: `ls specs/*.md 2>/dev/null`
3. Show completed specs: `ls specs/done/ 2>/dev/null`
4. Show recent commits: `git log --oneline -5`
5. If `specs/backlog/` has items, highlight them and suggest running `/ralph-promote`
