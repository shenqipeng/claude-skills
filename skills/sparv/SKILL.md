---
name: sparv
description: Use this skill when you see `/sparv`. Minimal SPARV workflow (Specify→Plan→Act→Review→Vault) with 10-point spec gate, unified journal, 2-action saves, 3-failure protocol, and EHRB risk detection. Triggers on '/sparv' command. Provides structured task execution with spec scoring, journaling, failure recovery, and knowledge archival.
---

# SPARV

Five-phase workflow: **S**pecify → **P**lan → **A**ct → **R**eview → **V**ault.

Goal: Complete "requirements → verifiable delivery" in one pass, recording key decisions in external memory instead of relying on assumptions.

## Core Rules (Mandatory)

- **10-Point Spec Gate**: Spec score `0–10`; must be `≥9` to enter Plan.
- **2-Action Save**: Append an entry to `.sparv/journal.md` every 2 tool calls.
- **3-Failure Protocol**: Stop and escalate to user after 3 consecutive failures.
- **EHRB**: Require explicit user confirmation when high-risk detected (production/sensitive data/destructive/billing API/security-critical).
- **Fixed Phase Names**: `specify|plan|act|review|vault` (stored in `.sparv/state.yaml:current_phase`).

## Enhanced Rules (v1.1)

### Uncertainty Declaration (G3)

When any Specify dimension scores < 2:
- Declare: `UNCERTAINTY: <what> | ASSUMPTION: <fallback>`
- List all assumptions in journal before Plan
- Offer 2–3 options for ambiguous requirements

Example:
```
UNCERTAINTY: deployment target | ASSUMPTION: Docker container
UNCERTAINTY: auth method | OPTIONS: JWT / OAuth2 / Session
```

### Requirement Routing

| Mode | Condition | Flow |
|------|-----------|------|
| **Quick** | score ≥ 9 AND ≤ 3 files AND no EHRB | Specify → Act → Review |
| **Full** | otherwise | Specify → Plan → Act → Review → Vault |

Quick mode skips formal Plan phase but still requires:
- Completion promise written to journal
- 2-action save rule applies
- Review phase mandatory

### Context Acquisition (Optional)

Before Specify scoring:
1. Check `.sparv/kb.md` for existing patterns/decisions
2. If insufficient, scan codebase for relevant files
3. Document findings in journal under `## Context`

Skip if user explicitly provides full context.

### Knowledge Base Maintenance

During Vault phase, update `.sparv/kb.md`:
- **Patterns**: Reusable code patterns discovered
- **Decisions**: Architectural choices + rationale
- **Gotchas**: Common pitfalls + solutions

### CHANGELOG Update

Use during Review or Vault phase for non-trivial changes:
```bash
~/.claude/skills/sparv/scripts/changelog-update.sh --type <Added|Changed|Fixed|Removed> --desc "..."
```

## External Memory (Two Files)

Initialize (run in project root):

```bash
~/.claude/skills/sparv/scripts/init-session.sh --force
```

File conventions:

- `.sparv/state.yaml`: State machine (minimum fields: `session_id/current_phase/action_count/consecutive_failures`)
- `.sparv/journal.md`: Unified log (Plan/Progress/Findings all go here)
- `.sparv/history/<session_id>/`: Archive directory

## Phase 1: Specify (10-Point Scale)

Each item scores 0/1/2, total 0–10:

1) **Value**: Why do it, are benefits/metrics verifiable
2) **Scope**: MVP + what's out of scope
3) **Acceptance**: Testable acceptance criteria
4) **Boundaries**: Error/performance/compatibility/security critical boundaries
5) **Risk**: EHRB/dependencies/unknowns + handling approach

`score < 9`: Keep asking questions; do not enter Plan.
`score ≥ 9`: Write spec summary to journal, proceed.

## Phase 2: Plan

Produce a step-by-step plan in journal:

```
## Plan: <title>
1. <step> → verify: <how>
2. <step> → verify: <how>
3. <step> → verify: <how>
```

Each step must have a verification method. For EHRB items, mark: `⚠️ EHRB: <reason>`.

## Phase 3: Act

Execute the plan. Rules:

- **2-Action Save**: After every 2 tool calls, append progress to journal
- **Failure handling**: On failure, record in journal; increment `consecutive_failures`
  - 1 failure: Retry with adjusted approach
  - 2 failures: Try alternative approach
  - 3 failures: **STOP** → escalate to user with summary
- **EHRB**: Before any destructive/production/sensitive action, ask user: "This will <action>. Proceed?"

## Phase 4: Review

Check against acceptance criteria from Specify:

1. Run all verification methods from Plan
2. Record results in journal
3. If any fail → back to Act with specific fix
4. If all pass → proceed to Vault

## Phase 5: Vault

Finalize session:

1. Update `.sparv/kb.md` with patterns/decisions/gotchas
2. Run changelog update if changes were non-trivial
3. Archive session: `~/.claude/skills/sparv/scripts/archive-session.sh`
4. Mark `state.yaml: current_phase: vault`

## Quick Reference

When user types `/sparv`, parse the subcommand:

| Subcommand | Example | Action |
|---|---|---|
| `/sparv <task>` | `/sparv add email verification` | Start full SPARV workflow for the task |
| `/sparv status` | `/sparv status` | Read `.sparv/state.yaml` + `.sparv/journal.md`, show current phase & progress |
| `/sparv journal` | `/sparv journal` | Read and display `.sparv/journal.md` |
| `/sparv kb` | `/sparv kb` | Read and display `.sparv/kb.md` |

**If no `.sparv/` directory exists**, auto-initialize first (create `.sparv/`, `state.yaml`, `journal.md`, `kb.md`).

**If user just types `/sparv` without subcommand**, ask what task they want to run through SPARV.

## Journal Format

```markdown
## [TIMESTAMP] Phase: <phase> | Action #<n>

<div class="headingDiv">
### What
<what was done>

### Why
<rationale>

### Result
<outcome>

### Next
<what comes next>
</div>
```
