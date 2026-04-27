# Claude Code Skills

A curated collection of 24 skills for Claude Code, assembled from multiple open-source projects and original work. Plugin framework removed — works directly with `~/.claude/skills/`.

从多个开源项目和个人原创整合的 24 个 Claude Code 技能集，移除了插件框架，直接放入 `~/.claude/skills/` 即可使用。

## What's Included

- **24 skills** in `skills/` — brainstorming, MCU selection, systematic debugging, TDD, etc.
- **Hooks** in `hooks/` — SessionStart hook for auto-loading `using-superpowers`

## Quick Install

```bash
git clone https://github.com/shenqipeng/claude-skills.git
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

- `settings.json.example` — Global settings template (fill in your API keys and model names)
- `settings.local.json.example` — Permissions template

These are starting points. The installer will not overwrite your existing settings files.

## Skills List

| Skill | Description | Source |
|-------|-------------|--------|
| brainstorming | Collaborative design exploration | [obra/superpowers](https://github.com/obra/superpowers) |
| careful | Safety guardrails for destructive commands | [obra/superpowers](https://github.com/obra/superpowers) |
| dispatching-parallel-agents | Run independent tasks in parallel | [obra/superpowers](https://github.com/obra/superpowers) |
| executing-plans | Execute implementation plans | [obra/superpowers](https://github.com/obra/superpowers) |
| find-skills | Discover and install new skills | [vercel-labs/skills](https://github.com/vercel-labs/skills) |
| finishing-a-development-branch | Merge/integrate completed work | [obra/superpowers](https://github.com/obra/superpowers) |
| freeze | Restrict file edits to a directory | [obra/superpowers](https://github.com/obra/superpowers) |
| karpathy-guidelines | Coding quality principles | [obra/superpowers](https://github.com/obra/superpowers) |
| mcu-selection | MCU selection from 284+ database | **Original** |
| product-requirements | Generate PRD with quality scoring | [stellarlinkco/myclaude](https://github.com/stellarlinkco/myclaude/tree/master/skills/product-requirements) |
| receiving-code-review | Process code review feedback | [obra/superpowers](https://github.com/obra/superpowers) |
| requesting-code-review | Get code review before merging | [obra/superpowers](https://github.com/obra/superpowers) |
| skill-creator | Create/evaluate/optimize skills | [anthropics/skills](https://github.com/anthropics/skills) |
| skill-install | Install skills from GitHub | [stellarlinkco/myclaude](https://github.com/stellarlinkco/myclaude/tree/master/skills/skill-install) |
| sparv | SPARV workflow (Specify→Plan→Act→Review→Vault) | [stellarlinkco/myclaude](https://github.com/stellarlinkco/myclaude/tree/master/skills/sparv) |
| subagent-driven-development | Execute plan with fresh subagent per task | [obra/superpowers](https://github.com/obra/superpowers) |
| systematic-debugging | Structured bug investigation | [obra/superpowers](https://github.com/obra/superpowers) |
| test-cases | Generate test cases from requirements | [stellarlinkco/myclaude](https://github.com/stellarlinkco/myclaude/tree/master/skills/test-cases) |
| test-driven-development | RED→GREEN→REFACTOR | [obra/superpowers](https://github.com/obra/superpowers) |
| using-git-worktrees | Isolated git worktrees for feature work | [obra/superpowers](https://github.com/obra/superpowers) |
| using-superpowers | Entry point / skill router | [obra/superpowers](https://github.com/obra/superpowers) |
| verification-before-completion | Verify before claiming done | [obra/superpowers](https://github.com/obra/superpowers) |
| writing-plans | Convert specs to implementation plans | [obra/superpowers](https://github.com/obra/superpowers) |
| writing-skills | TDD for process docs | [obra/superpowers](https://github.com/obra/superpowers) |

### Source Summary / 来源统计

| Source | Count | Skills |
|--------|-------|--------|
| [obra/superpowers](https://github.com/obra/superpowers) | 17 | brainstorming, careful, dispatching-parallel-agents, executing-plans, finishing-a-development-branch, freeze, karpathy-guidelines, receiving-code-review, requesting-code-review, subagent-driven-development, systematic-debugging, test-driven-development, using-git-worktrees, using-superpowers, verification-before-completion, writing-plans, writing-skills |
| [stellarlinkco/myclaude](https://github.com/stellarlinkco/myclaude) | 3 | product-requirements, test-cases, skill-install, sparv |
| [anthropics/skills](https://github.com/anthropics/skills) | 1 | skill-creator |
| [vercel-labs/skills](https://github.com/vercel-labs/skills) | 1 | find-skills |
| **Original / 原创** | 1 | mcu-selection |
