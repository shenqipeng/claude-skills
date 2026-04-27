# Claude Code Skills

My personal Claude Code skills collection (forked from [obra/superpowers](https://github.com/obra/superpowers)), without the plugin framework.

## What's Included

- **24 skills** in `skills/` - brainstorming, MCU selection, systematic debugging, TDD, etc.
- **Hooks** in `hooks/` - SessionStart hook for auto-loading `using-superpowers`

## Quick Install

```bash
git clone https://github.com/YOUR_USERNAME/claude-skills.git
cd claude-skills
bash install.sh
```

Then edit `~/.claude/settings.json` to fill in your API keys.

## Update

```bash
cd claude-skills
git pull
bash install.sh
```

## Settings

- `settings.json.example` - Global settings template (fill in your API keys and model names)
- `settings.local.json.example` - Permissions template

These are starting points. The installer will not overwrite your existing settings files.

## Skills List

| Skill | Description |
|-------|-------------|
| brainstorming | Collaborative design exploration |
| careful | Safety guardrails for destructive commands |
| dispatching-parallel-agents | Run independent tasks in parallel |
| executing-plans | Execute implementation plans |
| find-skills | Discover and install new skills |
| finishing-a-development-branch | Merge/integrate completed work |
| freeze | Restrict file edits to a directory |
| karpathy-guidelines | Coding quality principles |
| mcu-selection | MCU selection from 284+ database |
| product-requirements | Generate PRD with quality scoring |
| receiving-code-review | Process code review feedback |
| requesting-code-review | Get code review before merging |
| skill-creator | Create/evaluate/optimize skills |
| skill-install | Install skills from GitHub |
| sparv | SPARV workflow (Specify→Plan→Act→Review→Vault) |
| subagent-driven-development | Execute plan with fresh subagent per task |
| systematic-debugging | Structured bug investigation |
| test-cases | Generate test cases from requirements |
| test-driven-development | RED→GREEN→REFACTOR |
| using-git-worktrees | Isolated git worktrees for feature work |
| using-superpowers | Entry point / skill router |
| verification-before-completion | Verify before claiming done |
| writing-plans | Convert specs to implementation plans |
| writing-skills | TDD for process docs |
