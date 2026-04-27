---
name: freeze
description: |
  Restrict file edits to a specific directory. Chain: triggered by→systematic-debugging(lock scope→fault module FIRST), subagent-driven-development(task scope), executing-plans(per-step scope). Signals: "freeze", "restrict edits", "only edit this folder", "lock down edits", debugging firmware, "don't touch other modules"
---

# /freeze — Restrict Edits to a Directory

Lock file edits to a specific directory. Any Edit or Write operation targeting
a file outside the allowed path will be **blocked**.

## Setup

Ask the user which directory to restrict edits to:

- Question: "Which directory should I restrict edits to? Files outside this path will be blocked from editing."
- Wait for the user to provide a path.

Once the user provides a directory path:

1. Resolve it to an absolute path
2. Save the freeze boundary to state file:
   - State dir: `${HOME}/.gstack/`
   - State file: `freeze-dir.txt`
3. Tell the user: "Edits are now restricted to `<path>/`. Any Edit or Write outside this directory will be blocked. To change the boundary, run `/freeze` again. To remove it, run `/unfreeze` or end the session."

## How it works

Before every Edit or Write operation, check whether the target `file_path` starts
with the freeze directory. If not, block the operation with a message:

> [freeze] Blocked: `<file_path>` is outside the freeze boundary (`<freeze_dir>`).
> Only edits within the frozen directory are allowed.

The freeze boundary persists for the session via the state file.

## Notes

- The trailing `/` on the freeze directory prevents `/src` from matching `/src-old`
- Freeze applies to Edit and Write tools only — Read, Bash, Glob, Grep are unaffected
- This prevents accidental edits, not a security boundary — Bash commands like `sed` can still modify files outside the boundary
- To deactivate, run `/unfreeze` or end the conversation

## Embedded use cases

- Freeze to `drivers/uart/` when debugging UART — prevents accidentally changing SPI or I2C drivers
- Freeze to `src/` when implementing features — protects `lib/` and `middleware/`
- Freeze to a single `.c` file's directory during hotfix — no scope creep

## Workflow Linkage

**Position in superpowers workflow:** Scope control tool, primarily used during debugging and execution.

**Triggered by:**
- `superpowers:systematic-debugging` — At Phase 1 (Root Cause Investigation), freeze edits to the suspected fault module. Critical in embedded projects with layered HAL/Peripheral code. Release freeze after root cause is confirmed.
- `superpowers:subagent-driven-development` — Lock subagent edits to the task's specific directories.
- `superpowers:executing-plans` — Scope execution to relevant directories per plan step.

**Decision rule:** In embedded projects, freeze is especially valuable when debugging hardware abstraction layers where a change to one peripheral driver can cascade. Always invoke freeze before starting systematic-debugging in firmware codebases.
