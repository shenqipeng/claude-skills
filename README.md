# Claude Code Skills

An embedded-oriented skill collection for Claude Code, built on [obra/superpowers](https://github.com/obra/superpowers) as the foundation, enhanced with safety guardrails from [garrytan/gstack](https://github.com/garrytan/gstack), supplementary skills from [stellarlinkco/myclaude](https://github.com/stellarlinkco/myclaude) and others, plus an original MCU selection skill — forming an engineered workflow for embedded software development.

以 [obra/superpowers](https://github.com/obra/superpowers) 为蓝本的嵌入式开发技能集。因作者为嵌入式软件工程师，吸收了 [garrytan/gstack](https://github.com/garrytan/gstack) 的 freeze 和 careful 安全护栏，补充了 [stellarlinkco/myclaude](https://github.com/stellarlinkco/myclaude) 等项目的单功能加强 skills，以及自研的 mcu-selection，形成一套初步的嵌入式软件开发工程化约束 skill 流程。

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
| careful | Safety guardrails for destructive commands | [garrytan/gstack](https://github.com/garrytan/gstack) |
| dispatching-parallel-agents | Run independent tasks in parallel | [obra/superpowers](https://github.com/obra/superpowers) |
| executing-plans | Execute implementation plans | [obra/superpowers](https://github.com/obra/superpowers) |
| find-skills | Discover and install new skills | [vercel-labs/skills](https://github.com/vercel-labs/skills) |
| finishing-a-development-branch | Merge/integrate completed work | [obra/superpowers](https://github.com/obra/superpowers) |
| freeze | Restrict file edits to a directory | [garrytan/gstack](https://github.com/garrytan/gstack) |
| karpathy-guidelines | Coding quality principles | [forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills) |
| mcu-selection | MCU selection from 284+ database | **Original / 原创** |
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
| [obra/superpowers](https://github.com/obra/superpowers) | 14 | brainstorming, dispatching-parallel-agents, executing-plans, finishing-a-development-branch, receiving-code-review, requesting-code-review, subagent-driven-development, systematic-debugging, test-driven-development, using-git-worktrees, using-superpowers, verification-before-completion, writing-plans, writing-skills |
| [garrytan/gstack](https://github.com/garrytan/gstack) | 2 | careful, freeze |
| [forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills) | 1 | karpathy-guidelines |
| [stellarlinkco/myclaude](https://github.com/stellarlinkco/myclaude) | 4 | product-requirements, test-cases, skill-install, sparv |
| [anthropics/skills](https://github.com/anthropics/skills) | 1 | skill-creator |
| [vercel-labs/skills](https://github.com/vercel-labs/skills) | 1 | find-skills |
| **Original / 原创** | 1 | mcu-selection |
