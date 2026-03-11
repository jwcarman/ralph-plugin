---
description: "Scaffold Ralph Loop into the current git repo"
allowed-tools: ["Bash", "Read", "Write", "Glob"]
---

# Ralph Init

Scaffold the Ralph Loop into the current directory, then guide the user through creating a complete `PRD.md`.

## Phase 1: Scaffold

1. Check if `ralph-loop.sh` already exists — if so, warn the user and stop
2. Copy files from the plugin's `assets/` directory:
   ```bash
   cp "${CLAUDE_PLUGIN_ROOT}/assets/ralph-loop.sh" ./ralph-loop.sh
   cp "${CLAUDE_PLUGIN_ROOT}/assets/PRD.example.md" ./PRD.example.md
   mkdir -p specs/done specs/backlog
   cp "${CLAUDE_PLUGIN_ROOT}/assets/specs/000-spec-template.md.example" ./specs/000-spec-template.md.example
   ```
3. Create `progress.txt`:
   ```
   LAST_RUN: never
   ITERATION: 0
   SPEC_COMPLETED: none
   WHAT_WAS_DONE: initial setup
   VERIFICATION: n/a
   STATUS: MORE_WORK
   NEXT_SPEC: first file in specs/
   NOTES: First run. Read PRD.md fully before doing anything.
   ```
4. Add `logs/` to `.gitignore` if not already present
5. Run `chmod +x ralph-loop.sh`
6. Tell the user scaffolding is done, and that you'll now help them write their `PRD.md`

## Phase 2: Explore the Project

Before asking any questions, explore the codebase to infer as much as possible:

- Look for `package.json`, `pom.xml`, `build.gradle`, `Cargo.toml`, `go.mod`, `pyproject.toml`, `requirements.txt` — identify language, framework, package manager
- Look for test config files (`vitest.config.*`, `jest.config.*`, `pytest.ini`, `build.gradle`) — identify test runner and commands
- Look for lint/format config (`.eslintrc`, `prettier.config.*`, `checkstyle.xml`, `spotless`, `.golangci.yml`) — identify lint commands
- Read `README.md` if it exists — it often has run/test commands
- Scan top-level directory structure to understand the project layout
- Check for `.env.example` or `application.properties` — identify environment variables

Use what you find to pre-fill answers. Only ask about things you couldn't determine.

## Phase 3: PRD Interrogation

Ask questions **one at a time**. Wait for the answer before asking the next. Use multiple choice where possible. Skip questions you already have confident answers to from Phase 2 — confirm those instead.

### Questions to cover (in order):

1. **Project description** — "What does this project do, and who uses it?" (open-ended, 2-3 sentences)

2. **Tech stack** — Show what you inferred and ask to confirm or correct:
   > "I can see this is a [language/framework] project using [package manager]. Is that right, or should I update anything?"

3. **Test command** — Show what you inferred (if anything) or ask:
   > "What command runs all the tests? (e.g. `pnpm test --run`, `./mvnw test`, `pytest`)"
   Also ask: "What does passing output look like? Paste a line or two."

4. **Lint/typecheck command** — Show what you inferred or ask:
   > "What command runs linting and type checking? (e.g. `pnpm lint && pnpm typecheck`)"

5. **Coding conventions** — Ask for 3-5 bullet points:
   > "Any conventions the agent must follow? e.g. named exports only, no default exports; DTOs as record classes; service layer pattern. What are the non-negotiables?"

6. **Hard constraints** — Ask:
   > "Anything the agent must never do? e.g. never modify the DB schema directly, never change public API shape without a spec."

7. **Environment variables** — Show what you found in `.env.example` etc. or ask:
   > "What environment variables does the project need? (name and where they come from — no actual values)"

8. **Definition of done** — Ask:
   > "What must be true before a spec is considered complete? I'll start with the defaults — let me know what to add or change:
   > - All existing tests pass
   > - New tests cover the new behavior
   > - Linting passes
   > - No debug code left in
   > - progress.txt updated"

## Phase 4: Write PRD.md

Using `PRD.example.md` as the template structure, write a fully filled-out `PRD.md` with all the answers from Phase 3. Replace every placeholder — no `[COMMAND]` or `[DESCRIBE]` left behind.

Confirm with the user: show a brief summary of what you wrote and ask if anything needs adjusting.

## Phase 5: Wrap Up

Tell the user:
- ✅ `ralph-loop.sh` installed
- ✅ `PRD.md` written
- ✅ Spec template ready at `specs/000-spec-template.md.example`
- Next step: run `/ralph-spec` to write your first spec, then `./ralph-loop.sh` to start the loop
