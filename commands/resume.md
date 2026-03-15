---
description: "Resolve a NEEDS_HUMAN blocker and prepare Ralph to continue"
allowed-tools: ["Read", "Write", "Bash"]
---

# Ralph Resume

Guide the human through resolving a `NEEDS_HUMAN` blocker and reset `progress.txt` so the loop can restart.

## Steps

1. **Read `progress.txt`**
   - If `STATUS` is not `NEEDS_HUMAN`, tell the user there is no active blocker and suggest running `./ralph-loop.sh` directly. Stop here.
   - Display the `REASON` and `ATTEMPTS` fields clearly so the user has full context on why Ralph stopped.

2. **Assess the current spec state**
   - Run `ls specs/*.md 2>/dev/null` to see what specs are active.
   - Note whether any specs appear to have changed since the blocker was set (the user may have rewritten them).

3. **Ask what changed**
   - Ask the user one question: "What did you do to resolve this blocker?" (free-form answer)
   - Wait for their response before proceeding.

4. **Rewrite `progress.txt`**
   - Preserve `ITERATION` (do not increment it).
   - Set `LAST_RUN` to the current timestamp.
   - Set `SPEC_COMPLETED: none`
   - Set `WHAT_WAS_DONE: Human resolved blocker — [one-sentence summary of what they said]`
   - Set `VERIFICATION: n/a`
   - Set `STATUS: MORE_WORK`
   - Set `NEXT_SPEC: [lowest-numbered spec in specs/, or "none" if empty]`
   - Set `NOTES: [full context from user's answer — what was broken, what changed, any assumptions or gotchas Ralph should know going into the next iteration]`
   - Remove `REASON` and `ATTEMPTS` fields entirely.

5. **Confirm**
   - Tell the user: "Ralph is ready to continue. Run `./ralph-loop.sh` to restart."
