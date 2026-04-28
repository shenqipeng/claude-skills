# MCU Ironclad

**Ironclad workflow skills for MCU engineering.**

<details>
<summary><strong>English</strong></summary>

---

Ironclad workflow skills for MCU engineering — built on [obra/superpowers](https://github.com/obra/superpowers) as the foundation, enhanced with safety guardrails from [garrytan/gstack](https://github.com/garrytan/gstack), supplementary skills from [stellarlinkco/myclaude](https://github.com/stellarlinkco/myclaude) and others, plus an original MCU selection skill — forming a rigorously gated workflow for embedded software development.

### What's Included

- **25 skills** in `skills/` — brainstorming, MCU selection, systematic debugging, TDD, fact-forcing gates, etc.
- **Hooks** in `hooks/` — SessionStart hook for Claude Code
- **Plugin** in `.opencode/plugins/` — OpenCode plugin with auto-discovery and health checks

### Quick Install — Claude Code

```bash
git clone https://github.com/shenqipeng/mcu-ironclad.git
cd mcu-ironclad
bash install.sh
```

Then edit `~/.claude/settings.json` to fill in your API keys.

### Quick Install — OpenCode

**Linux/macOS:**
```bash
git clone https://github.com/shenqipeng/mcu-ironclad.git
cd mcu-ironclad
bash install-opencode.sh
```

**Windows PowerShell:**
```powershell
git clone https://github.com/shenqipeng/mcu-ironclad.git
cd mcu-ironclad
.\install-opencode.ps1
```

The installer adds the repo as a local plugin in `opencode.json`. The plugin auto-discovers all 25 skills, injects the superpowers bootstrap, and runs health checks on startup.

### Update

**Claude Code:**
```bash
cd mcu-ironclad && git pull && bash install.sh
```

**OpenCode:**
```bash
cd mcu-ironclad && git pull
```
(OpenCode reads skills directly from the repo — no re-install needed after pull.)

### Settings (Claude Code)

- `settings.json.example` — Global settings template (fill in your API keys and model names)
- `settings.local.json.example` — Permissions template

These are starting points. The installer will not overwrite your existing settings files.

### Settings (OpenCode)

OpenCode reads configuration from `~/.config/opencode/opencode.json`. The installer adds the repo path to the `plugin` array. No additional settings files are needed — skill discovery, bootstrap injection, and health checks are handled by the plugin automatically.

### Skills List

| Skill | Description | Source |
|-------|-------------|--------|
| brainstorming | Collaborative design exploration | [obra/superpowers](https://github.com/obra/superpowers) |
| careful | Safety guardrails for destructive commands | [garrytan/gstack](https://github.com/garrytan/gstack) |
| dispatching-parallel-agents | Run independent tasks in parallel | [obra/superpowers](https://github.com/obra/superpowers) |
| executing-plans | Execute implementation plans | [obra/superpowers](https://github.com/obra/superpowers) |
| find-skills | Discover and install new skills | [vercel-labs/skills](https://github.com/vercel-labs/skills) |
| finishing-a-development-branch | Merge/integrate completed work | [obra/superpowers](https://github.com/obra/superpowers) |
| freeze | Restrict file edits to a directory | [garrytan/gstack](https://github.com/garrytan/gstack) |
| gateguard | Fact-forcing gate: investigate before editing | [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code) |
| karpathy-guidelines | Coding quality principles | [forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills) |
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

#### Source Summary

| Source | Count | Skills |
|--------|-------|--------|
| [obra/superpowers](https://github.com/obra/superpowers) | 14 | brainstorming, dispatching-parallel-agents, executing-plans, finishing-a-development-branch, receiving-code-review, requesting-code-review, subagent-driven-development, systematic-debugging, test-driven-development, using-git-worktrees, using-superpowers, verification-before-completion, writing-plans, writing-skills |
| [garrytan/gstack](https://github.com/garrytan/gstack) | 2 | careful, freeze |
| [forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills) | 1 | karpathy-guidelines |
| [stellarlinkco/myclaude](https://github.com/stellarlinkco/myclaude) | 4 | product-requirements, test-cases, skill-install, sparv |
| [anthropics/skills](https://github.com/anthropics/skills) | 1 | skill-creator |
| [vercel-labs/skills](https://github.com/vercel-labs/skills) | 1 | find-skills |
| [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code) | 1 | gateguard (adapted with embedded-specific checks) |
| **Original** | 1 | mcu-selection |

### Enforced Workflow Example

A real embedded project walkthrough showing how the skills enforce discipline at every step. Hard gates (BLOCKERS) prevent skipping phases. Cross-cutting skills (freeze, careful, verification) insert automatically at risk points.

**Scenario:** Develop a UART communication module for a GD32E230-based data acquisition board.

```
Phase 1 — Requirements [product-requirements]
├── Interactive PRD generation with 100-point scoring
├── 🔒 BLOCKER: PRD score must reach ≥90 to proceed
└── Output: docs/uart-comm-prd.md (score: 92) ✓

Phase 2 — MCU Selection [mcu-selection]
├── Parse PRD hardware requirements (UART, DMA, Flash, RAM, package)
├── Query 284+ MCU database, rank candidates
├── 🔒 BLOCKER: User must confirm MCU choice
└── Output: GD32E230F8P6 confirmed ✓

Phase 3 — Design [brainstorming]
├── One question at a time, propose 2-3 architecture approaches
│   Option A: Polling UART + ring buffer (simple, no DMA)
│   Option B: Interrupt-driven + DMA (recommended)
│   Option C: RTOS queue-based (overkill for this scope)
├── 🔒 BLOCKER: No code until design approved by user
└── Output: docs/specs/2026-04-27-uart-comm-design.md ✓

Phase 4 — Test Cases [test-cases]
├── Generate test cases from PRD acceptance criteria
│   TC-001: Normal data reception at 115200 baud
│   TC-002: Buffer overflow under continuous stream
│   TC-003: Framing error recovery
│   TC-004: DMA half-transfer interrupt handling
└── Output: docs/test-cases/uart-comm-tests.md ✓

Phase 5 — Implementation Plan [writing-plans]
├── Break design into 2-5 min tasks with zero-context assumption
│   Task 1: UART GPIO and clock configuration
│   Task 2: UART init with interrupt setup
│   Task 3: Ring buffer implementation
│   Task 4: DMA circular mode integration
│   Task 5: Error handling and recovery
│   Task 6: Integration test harness
├── 🔒 BLOCKER: Plan must exist before execution
└── Output: docs/plans/2026-04-27-uart-comm-plan.md ✓

Phase 6 — Isolated Workspace [using-git-worktrees]
├── Create isolated git worktree for feature
└── Working in: ~/projects/daq-board/.worktrees/uart-comm/ ✓

Phase 7 — Execution [subagent-driven-development]
├── Fresh subagent per task, two-stage review after each
│
│   Task 1: UART GPIO and clock config
│   ├── 🛡️ [freeze] Lock edits to drivers/uart/ only
│   ├── 🛡️ [gateguard] DENY first edit → list importers, public interface, hw context → ALLOW
│   ├── 🛡️ [karpathy-guidelines] Think first, surgical changes
│   ├── 🛡️ [careful] Check: no flash erase in this task
│   ├── [TDD] Write test → RED → implement → GREEN
│   ├── [requesting-code-review] Subagent review → pass
│   └── [verification-before-completion] Build succeeds, test green ✓
│
│   Task 2: UART init with interrupt setup
│   ├── 🛡️ [freeze] Still locked to drivers/uart/
│   ├── [TDD] Write test for baud/config → RED → GREEN
│   ├── [requesting-code-review] Found: missing NVIC priority group
│   │   └── [receiving-code-review] Verify fix technically → implemented
│   └── [verification-before-completion] ✓
│
│   Task 4: DMA circular mode
│   ├── 🛡️ [freeze] Lock edits to drivers/uart/ + drivers/dma/
│   ├── 🛡️ [careful] ACTIVE: DMA register writes detected
│   │   └── ⚠️ "Writing DMA channel config registers. Confirm? [y/N]"
│   ├── [TDD] Half-transfer + full-transfer test → GREEN
│   └── [verification-before-completion] ✓
│
│   ... remaining tasks similarly guarded ...
│
└── All tasks complete ✓

Phase 8 — Delivery [finishing-a-development-branch]
├── [verification-before-completion] Run ALL tests: 6/6 pass ✓
├── [requesting-code-review] Full module review → pass
├── 🛡️ [careful] Check: no force-push needed
├── Present options: merge / PR / keep
└── User chooses: create PR → merged ✓

Phase 9 — Cleanup
└── [using-git-worktrees] Remove worktree ✓
```

**Enforcement summary for this project:**

| Enforcement Point | Skill | Where It Triggered |
|---|---|---|
| PRD quality gate (score ≥ 90) | product-requirements | Phase 1 |
| MCU choice must be explicit | mcu-selection | Phase 2 |
| No code before design approval | brainstorming | Phase 3 |
| Test cases from requirements | test-cases | Phase 4 |
| Plan must exist before coding | writing-plans | Phase 5 |
| Isolated workspace | using-git-worktrees | Phase 6 |
| File edit scope locked | freeze | Every task (Task 1-6) |
| Investigate before editing | gateguard | First edit per file (Task 1) |
| Destructive operation confirmation | careful | DMA writes (Task 4) |
| Test first, then code | test-driven-development | Every task |
| Code review after each task | requesting-code-review | Every task |
| Review feedback verified | receiving-code-review | Task 2 fix |
| No "done" without evidence | verification-before-completion | Every task + Phase 8 |
| Think before code | karpathy-guidelines | Every task |

</details>

<details>
<summary><strong>中文</strong></summary>

---

**MCU 工程型开发强约束流程 skill 集。**

以 [obra/superpowers](https://github.com/obra/superpowers) 为蓝本。因作者为嵌入式软件工程师，吸收了 [garrytan/gstack](https://github.com/garrytan/gstack) 的 freeze 和 careful 安全护栏，补充了 [stellarlinkco/myclaude](https://github.com/stellarlinkco/myclaude) 等项目的单功能加强 skills，以及自研的 mcu-selection，形成一套 MCU 工程型开发的强约束 skill 流程。

### 包含内容

- **25 个 skills** 位于 `skills/` — 设计探索、MCU选型、系统化调试、TDD、事实强制门 等
- **Hooks** 位于 `hooks/` — Claude Code 的 SessionStart 钩子
- **Plugin** 位于 `.opencode/plugins/` — OpenCode 插件，自动发现技能和健康检查

### 快速安装 — Claude Code

```bash
git clone https://github.com/shenqipeng/mcu-ironclad.git
cd mcu-ironclad
bash install.sh
```

然后编辑 `~/.claude/settings.json` 填入你的 API 密钥。

### 快速安装 — OpenCode

**Linux/macOS:**
```bash
git clone https://github.com/shenqipeng/mcu-ironclad.git
cd mcu-ironclad
bash install-opencode.sh
```

**Windows PowerShell:**
```powershell
git clone https://github.com/shenqipeng/mcu-ironclad.git
cd mcu-ironclad
.\install-opencode.ps1
```

安装脚本将仓库路径添加为 `opencode.json` 中的本地插件。插件自动发现全部 25 个技能、注入 superpowers 引导上下文、并启动时运行健康检查。

### 更新

**Claude Code:**
```bash
cd mcu-ironclad && git pull && bash install.sh
```

**OpenCode:**
```bash
cd mcu-ironclad && git pull
```
（OpenCode 直接从仓库读取技能，pull 后无需重新安装。）

### 配置说明 (Claude Code)

- `settings.json.example` — 全局配置模板（需填入 API 密钥和模型名称）
- `settings.local.json.example` — 权限配置模板

以上为初始模板，安装脚本不会覆盖已有配置文件。

### 配置说明 (OpenCode)

OpenCode 从 `~/.config/opencode/opencode.json` 读取配置。安装脚本将仓库路径添加到 `plugin` 数组。无需额外配置文件——技能发现、引导注入和健康检查均由插件自动处理。

### 技能列表

| Skill | 说明 | 来源 |
|-------|------|------|
| brainstorming | 协作式设计探索 | [obra/superpowers](https://github.com/obra/superpowers) |
| careful | 破坏性命令的安全护栏 | [garrytan/gstack](https://github.com/garrytan/gstack) |
| dispatching-parallel-agents | 并行运行独立任务 | [obra/superpowers](https://github.com/obra/superpowers) |
| executing-plans | 执行实施计划 | [obra/superpowers](https://github.com/obra/superpowers) |
| find-skills | 发现和安装新技能 | [vercel-labs/skills](https://github.com/vercel-labs/skills) |
| finishing-a-development-branch | 合并/集成已完成的工作 | [obra/superpowers](https://github.com/obra/superpowers) |
| freeze | 将文件编辑限制在指定目录 | [garrytan/gstack](https://github.com/garrytan/gstack) |
| gateguard | 事实强制门：编辑前必须调查 | [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code) |
| karpathy-guidelines | 编码质量准则 | [forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills) |
| mcu-selection | 从 284+ 数据库中选择 MCU | **原创** |
| product-requirements | 生成交互式 PRD（100分制评分） | [stellarlinkco/myclaude](https://github.com/stellarlinkco/myclaude/tree/master/skills/product-requirements) |
| receiving-code-review | 处理代码审查反馈 | [obra/superpowers](https://github.com/obra/superpowers) |
| requesting-code-review | 合并前获取代码审查 | [obra/superpowers](https://github.com/obra/superpowers) |
| skill-creator | 创建/评估/优化技能 | [anthropics/skills](https://github.com/anthropics/skills) |
| skill-install | 从 GitHub 安装技能（带安全扫描） | [stellarlinkco/myclaude](https://github.com/stellarlinkco/myclaude/tree/master/skills/skill-install) |
| sparv | SPARV 工作流（指定→计划→行动→审查→归档） | [stellarlinkco/myclaude](https://github.com/stellarlinkco/myclaude/tree/master/skills/sparv) |
| subagent-driven-development | 每个任务委派新子代理执行 | [obra/superpowers](https://github.com/obra/superpowers) |
| systematic-debugging | 结构化缺陷调查 | [obra/superpowers](https://github.com/obra/superpowers) |
| test-cases | 从需求生成结构化测试用例 | [stellarlinkco/myclaude](https://github.com/stellarlinkco/myclaude/tree/master/skills/test-cases) |
| test-driven-development | 红→绿→重构 | [obra/superpowers](https://github.com/obra/superpowers) |
| using-git-worktrees | 隔离的 git 工作树 | [obra/superpowers](https://github.com/obra/superpowers) |
| using-superpowers | 入口 / 技能路由器 | [obra/superpowers](https://github.com/obra/superpowers) |
| verification-before-completion | 完成前强制验证 | [obra/superpowers](https://github.com/obra/superpowers) |
| writing-plans | 将规格说明转换为实施计划 | [obra/superpowers](https://github.com/obra/superpowers) |
| writing-skills | 过程文档的 TDD | [obra/superpowers](https://github.com/obra/superpowers) |

#### 来源统计

| 来源 | 数量 | Skills |
|------|------|--------|
| [obra/superpowers](https://github.com/obra/superpowers) | 14 | brainstorming, dispatching-parallel-agents, executing-plans, finishing-a-development-branch, receiving-code-review, requesting-code-review, subagent-driven-development, systematic-debugging, test-driven-development, using-git-worktrees, using-superpowers, verification-before-completion, writing-plans, writing-skills |
| [garrytan/gstack](https://github.com/garrytan/gstack) | 2 | careful, freeze |
| [forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills) | 1 | karpathy-guidelines |
| [stellarlinkco/myclaude](https://github.com/stellarlinkco/myclaude) | 4 | product-requirements, test-cases, skill-install, sparv |
| [anthropics/skills](https://github.com/anthropics/skills) | 1 | skill-creator |
| [vercel-labs/skills](https://github.com/vercel-labs/skills) | 1 | find-skills |
| [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code) | 1 | gateguard（含嵌入式专项检查） |
| **原创** | 1 | mcu-selection |

### 强约束工作流案例

展示一个真实嵌入式项目中，skill 如何在每个步骤强制约束。硬性门槛（BLOCKER）阻止跳过阶段，横切技能（freeze、careful、verification）在风险点自动介入。

**场景：** 为 GD32E230 数据采集板开发 UART 通讯模块。

```
阶段 1 — 需求 [product-requirements]
├── 交互式 PRD 生成，100 分制质量评分
├── 🔒 硬性门槛：PRD 评分必须 ≥90 才能继续
└── 输出：docs/uart-comm-prd.md（评分：92）✓

阶段 2 — 芯片选型 [mcu-selection]
├── 解析 PRD 硬件需求（UART、DMA、Flash、RAM、封装）
├── 查询 284+ MCU 数据库，排列候选
├── 🔒 硬性门槛：用户必须确认 MCU 选择
└── 输出：确认 GD32E230F8P6 ✓

阶段 3 — 设计 [brainstorming]
├── 逐个提问，提出 2-3 种架构方案
│   方案 A：轮询 UART + 环形缓冲区（简单，无 DMA）
│   方案 B：中断驱动 + DMA（推荐）
│   方案 C：RTOS 队列模式（对当前范围过重）
├── 🔒 硬性门槛：设计经用户批准前不写代码
└── 输出：docs/specs/2026-04-27-uart-comm-design.md ✓

阶段 4 — 测试用例 [test-cases]
├── 从 PRD 验收标准生成测试用例
│   TC-001：115200 波特率下正常数据接收
│   TC-002：连续数据流下的缓冲区溢出
│   TC-003：帧错误恢复
│   TC-004：DMA 半传输中断处理
└── 输出：docs/test-cases/uart-comm-tests.md ✓

阶段 5 — 实施计划 [writing-plans]
├── 将设计分解为 2-5 分钟零上下文任务
│   任务 1：UART GPIO 和时钟配置
│   任务 2：UART 初始化及中断设置
│   任务 3：环形缓冲区实现
│   任务 4：DMA 循环模式集成
│   任务 5：错误处理与恢复
│   任务 6：集成测试框架
├── 🔒 硬性门槛：必须先有计划才能执行
└── 输出：docs/plans/2026-04-27-uart-comm-plan.md ✓

阶段 6 — 隔离工作区 [using-git-worktrees]
├── 为功能创建隔离的 git 工作树
└── 工作目录：~/projects/daq-board/.worktrees/uart-comm/ ✓

阶段 7 — 执行 [subagent-driven-development]
├── 每个任务委派新子代理，完成后双重审查
│
│   任务 1：UART GPIO 和时钟配置
│   ├── 🛡️ [freeze] 锁定编辑范围为 drivers/uart/
│   ├── 🛡️ [gateguard] 首次编辑被拒绝 → 列出导入者、公共接口、硬件上下文 → 允许
│   ├── 🛡️ [karpathy-guidelines] 先思考，精准修改
│   ├── 🛡️ [careful] 检查：本任务无 flash 擦除操作
│   ├── [TDD] 编写测试 → 红 → 实现 → 绿
│   ├── [requesting-code-review] 子代理审查 → 通过
│   └── [verification-before-completion] 编译成功，测试通过 ✓
│
│   任务 2：UART 初始化及中断设置
│   ├── 🛡️ [freeze] 仍锁定在 drivers/uart/
│   ├── [TDD] 编写波特率/配置测试 → 红 → 绿
│   ├── [requesting-code-review] 发现：缺少 NVIC 优先级分组
│   │   └── [receiving-code-review] 技术验证后实施修复
│   └── [verification-before-completion] ✓
│
│   任务 4：DMA 循环模式
│   ├── 🛡️ [freeze] 锁定范围为 drivers/uart/ + drivers/dma/
│   ├── 🛡️ [careful] 已激活：检测到 DMA 寄存器写入
│   │   └── ⚠️ "即将写入 DMA 通道配置寄存器，确认？[y/N]"
│   ├── [TDD] 半传输+全传输测试 → 绿
│   └── [verification-before-completion] ✓
│
│   ... 后续任务同样受约束 ...
│
└── 所有任务完成 ✓

阶段 8 — 交付 [finishing-a-development-branch]
├── [verification-before-completion] 运行全部测试：6/6 通过 ✓
├── [requesting-code-review] 全模块审查 → 通过
├── 🛡️ [careful] 检查：无需 force-push
├── 提供选项：合并 / PR / 保留
└── 用户选择：创建 PR → 合并 ✓

阶段 9 — 清理
└── [using-git-worktrees] 移除工作树 ✓
```

**本项目的约束执行总结：**

| 约束点 | 技能 | 触发位置 |
|--------|------|----------|
| PRD 质量门槛（评分 ≥ 90） | product-requirements | 阶段 1 |
| 必须明确选择 MCU | mcu-selection | 阶段 2 |
| 设计批准前禁止写代码 | brainstorming | 阶段 3 |
| 从需求生成测试用例 | test-cases | 阶段 4 |
| 编码前必须有计划 | writing-plans | 阶段 5 |
| 隔离工作区 | using-git-worktrees | 阶段 6 |
| 文件编辑范围锁定 | freeze | 每个任务（任务 1-6） |
| 编辑前必须调查 | gateguard | 每个文件首次编辑（任务 1） |
| 破坏性操作确认 | careful | DMA 寄存器写入（任务 4） |
| 先写测试再写代码 | test-driven-development | 每个任务 |
| 每个任务后代码审查 | requesting-code-review | 每个任务 |
| 审查反馈技术验证 | receiving-code-review | 任务 2 修复 |
| 无证据不能声称完成 | verification-before-completion | 每个任务 + 阶段 8 |
| 先思考再编码 | karpathy-guidelines | 每个任务 |

</details>

---

## Changelog

### 2026-04-28

- **Added OpenCode support** — full platform parity with Claude Code
  - `.opencode/plugins/superpowers.js` — OpenCode plugin: auto-discovers all 25 skills from a single `skills/` directory, injects `using-superpowers` bootstrap, validates skill graph health on startup
  - `install-opencode.sh` — one-command installer for Linux/macOS
  - `install-opencode.ps1` — one-command installer for Windows PowerShell
  - Updated README with bilingual OpenCode installation, update, and configuration sections
  - Design principle: single `skills/` source shared by both platforms, zero duplication
- **Synced all 25 skills** with latest improvements:
  - Added **Workflow Linkage** sections to 6 skills (brainstorming, using-superpowers, verification-before-completion, writing-plans, writing-skills, systematic-debugging)
  - Added **description chain encoding** to skill frontmatter for crop-resistant workflow discovery
  - Updated `using-superpowers` with Extended Workflow Linkage: entry routing table, sparv vs superpowers decision guide, key cross-links
  - Updated `workflow-graph.md`: expanded with sparv routing, parallel agent branch, trigger signal table
- **Added gateguard skill** — fact-forcing pre-action gate (DENY→FORCE→ALLOW), adapted from [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code) with embedded-specific checks (register shadow, clock dependency, interrupt state, DMA conflict, pin mux)
- **Installed context7 MCP** — real-time library/framework documentation lookup
- Skills count: 24 → 25
- Sources count: 7 → 8 (added ECC)
- Updated SKILLS_GUIDE.md: Mermaid workflow diagram, cross-cutting skills table, acknowledgments

### 2026-04-27

- **Renamed project**: `claude-skills` → `mcu-ironclad`
- Tagline: **Ironclad workflow skills for MCU engineering** / **MCU 工程型开发强约束流程 skill 集**
- Added bilingual `<details>` tab navigation (EN/CN)
- Added enforced workflow example (GD32E230 UART module)
- Fixed source attributions:
  - `karpathy-guidelines` → [forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills)
  - `careful`, `freeze` → [garrytan/gstack](https://github.com/garrytan/gstack)
- Corrected superpowers skill count: 17 → 14
- Added SKILLS_GUIDE.md with Mermaid workflow diagram and cross-cutting skill relationships

### 2026-04-27 (Initial)

- Initial release: 24 skills assembled from 5 sources + 1 original
- `install.sh` one-click installer
- Settings templates (`settings.json.example`, `settings.local.json.example`)
- SessionStart hook for auto-loading `using-superpowers`
