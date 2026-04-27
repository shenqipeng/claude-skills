# Superpowers + Independent Skills Workflow Graph

This file defines the complete workflow linkage between all installed skills. Referenced by `using-superpowers`.

## Primary Workflow (New Project / Major Feature)

```
product-requirements ──(PRD)──► brainstorming ──(design)──► writing-plans ──(plan)──┐
         │                         │                              │                  │
         │                    mcu-selection                       │                  │
         │                   (if embedded)                        │                  │
         │                                                         │                  │
         └──(acceptance criteria)──► test-cases ◄─────────────────┘                  │
                                          │                                        │
                                          ▼                                        ▼
                               subagent-driven-development               executing-plans
                               (recommended, same-session)               (alternative, separate-session)
                                          │                                        │
                                    ┌─────┼─────┐                          ┌─────┼─────┐
                                    ▼     ▼     ▼                          ▼     ▼     ▼
                              worktrees careful freeze                worktrees careful freeze
                                    │     │     │                          │     │     │
                                    │ karpathy   │                          │ karpathy   │
                                    │ guidelines │                          │ guidelines │
                                    │     │     │                          │     │     │
                                    ▼     ▼     ▼                          ▼     ▼     ▼
                                    TDD ◄─test-cases                     TDD ◄─test-cases
                                    │                                        │
                                    ▼                                        ▼
                              verification ◄── careful (embedded)      verification ◄── careful
                                    │                                        │
                                    ▼                                        ▼
                              requesting-code-review                requesting-code-review
                                    │                                        │
                                    ▼                                        ▼
                              receiving-code-review                receiving-code-review
                                    │                                        │
                                    ▼                                        ▼
                              finishing-a-development-branch ◄── careful (force-push)
                                    │
                                    └── cleanup worktree
```

## Debugging Branch (Independent Trigger)

```
systematic-debugging (on any bug/failure)
     │
     ├── freeze (lock scope to fault module FIRST)
     ├── careful (if hw register / flash operations)
     │
     ▼ Phase 1-3: Root cause investigation
     │
     ▼ Phase 4: Implementation
     ├── TDD (create failing test)
     │     └── test-cases (if available, use as RED input)
     └── verification (confirm fix)
```

## Test Chain (Requirements → Verification)

```
product-requirements
     │ (acceptance criteria)
     ▼
test-cases (generate structured test cases)
     │ (test case list)
     ├──► TDD (RED: use as first failing tests)
     └──► verification-before-completion (GREEN: all must pass)
```

## Skill Development Branch

```
writing-skills (TDD for process docs) ◄──► skill-creator (evaluate, benchmark, optimize)
```

## Parallel Agent Branch

```
dispatching-parallel-agents (2+ independent problem domains)
     └── verification-before-completion (verify each agent's result)
```

## Entry Routing Decision

| User says / Task type | Route to | Skip condition |
|----------------------|----------|----------------|
| New project from scratch, unclear requirements | `product-requirements` | Skip if task scope ≤3 files AND no new hardware |
| Feature to add, requirements clear | `brainstorming` | Skip if change is mechanical (rename, config) |
| Bug / test failure / unexpected behavior | `systematic-debugging` + `freeze` | Never skip |
| Embedded/hardware project | `mcu-selection` during `brainstorming` | Skip if MCU already chosen |
| Small task, need state tracking | `sparv` | Skip if task fits superpowers chain |
| Need new capability | `find-skills` → `skill-install` | N/A |
| Create/edit a skill | `writing-skills` → `skill-creator` | N/A |

## sparv vs superpowers Routing

| Condition | Use | Reason |
|-----------|-----|--------|
| High-risk / compliance / safety-critical | `sparv` | 10-point gate, 3-failure protocol, EHRB detection |
| Small well-defined task needing traceability | `sparv` | Journal + state tracking |
| Normal feature development | superpowers chain | Faster iteration, brainstorming-first |
| Bug fix with traceability requirement | `sparv` with `systematic-debugging` + `freeze` embedded | Combine strict process with debugging discipline |

## Skill Trigger Signals

| Skill | Trigger signals (in user message or context) | Skip signals |
|-------|---------------------------------------------|-------------|
| **careful** | `make flash`, `openocd`, `erase`, `fuse`, `reset --hard`, `push --force`, shared repo | One-off script, personal sandbox |
| **freeze** | Debugging firmware, HAL layer work, "don't touch other modules" | Single-file change, greenfield |
| **mcu-selection** | "MCU", "microcontroller", "firmware", "embedded", chip names (GD32, STM32, EFR32, CH32) | MCU already selected, software-only change |
| **product-requirements** | New project, unclear scope, stakeholder needs | ≤3 files, no new hardware, mechanical change |
| **test-cases** | PRD exists, acceptance criteria defined, "test coverage" | Quick hotfix, no PRD |
| **karpathy-guidelines** | Any code writing/review/refactoring | N/A (always applicable, lightweight) |
