---
name: careful
description: |
  Safety guardrails for destructive commands. Chain: triggered by→subagent-driven-development(before flash erase/fuse write), systematic-debugging(hw register ops), finishing-a-development-branch(force-push). Signals: make flash, openocd, erase, fuse, reset --hard, push --force, "be careful", "safety mode"
---

# /careful — Destructive Command Guardrails

Safety mode is now **active**. Every bash command will be checked for destructive
patterns before running. If a destructive command is detected, you'll be warned
and can choose to proceed or cancel.

## What's protected

| Pattern | Example | Risk |
|---------|---------|------|
| `rm -rf` / `rm -r` / `rm --recursive` | `rm -rf /var/data` | Recursive delete |
| `git push --force` / `-f` | `git push -f origin main` | History rewrite |
| `git reset --hard` | `git reset --hard HEAD~3` | Uncommitted work loss |
| `git checkout .` / `git restore .` | `git checkout .` | Uncommitted work loss |
| `kubectl delete` | `kubectl delete pod` | Production impact |
| `docker rm -f` / `docker system prune` | `docker system prune -a` | Container/image loss |
| Flash erase commands | `STM32_Programmer_CLI -c -e all` | Firmware erase |

## Safe exceptions

These patterns are allowed without warning:
- `rm -rf node_modules` / `.next` / `dist` / `__pycache__` / `.cache` / `build` / `.turbo` / `coverage`

## How it works

Before executing any Bash command, check it against the destructive patterns above.
If a match is found, warn the user and ask for confirmation before proceeding.

To deactivate, end the conversation or start a new one.

## Embedded-specific protections

When working on embedded projects, also warn before:
- Any command that erases Flash memory (`-e all`, `--mass-erase`, `nrfjprog --eraseall`)
- Any command that writes fuses/option bytes
- `make flash` or `make upload` without prior review

## Workflow Linkage

**Position in superpowers workflow:** Cross-cutting safety guardrail, embedded in execution and debugging phases.

**Triggered by:**
- `superpowers:subagent-driven-development` — Before subagent performs destructive ops (flash erase, fuse write, force-push)
- `superpowers:executing-plans` — Before execution steps involving destructive commands
- `superpowers:systematic-debugging` — When debugging involves hardware register writes or flash operations
- `superpowers:finishing-a-development-branch` — When merge involves force-push or destructive git operations

**Decision rule:** Activate careful mode automatically when ANY of these signals appear: `make flash`, `openocd`, `stm32flash`, `erase`, `fuse`, `reset --hard`, `push --force`, or when working in a shared/production codebase.
