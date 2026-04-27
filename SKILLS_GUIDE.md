# Claude Code Skills Guide / Claude Code 技能集指南

An embedded-oriented skill collection for Claude Code, built on [obra/superpowers](https://github.com/obra/superpowers) as the foundation, enhanced with safety guardrails from [garrytan/gstack](https://github.com/garrytan/gstack), supplementary skills from [stellarlinkco/myclaude](https://github.com/stellarlinkco/myclaude) and others, plus an original MCU selection skill — forming an engineered workflow for embedded software development.

以 [obra/superpowers](https://github.com/obra/superpowers) 为蓝本的嵌入式开发技能集。因作者为嵌入式软件工程师，吸收了 [garrytan/gstack](https://github.com/garrytan/gstack) 的 freeze 和 careful 安全护栏，补充了 [stellarlinkco/myclaude](https://github.com/stellarlinkco/myclaude) 等项目的单功能加强 skills，以及自研的 mcu-selection，形成一套初步的嵌入式软件开发工程化约束 skill 流程。

## Sources / 来源

| Source | Count / 数量 | Skills |
|--------|------|--------|
| [obra/superpowers](https://github.com/obra/superpowers) | 14 | brainstorming, dispatching-parallel-agents, executing-plans, finishing-a-development-branch, receiving-code-review, requesting-code-review, subagent-driven-development, systematic-debugging, test-driven-development, using-git-worktrees, using-superpowers, verification-before-completion, writing-plans, writing-skills |
| [garrytan/gstack](https://github.com/garrytan/gstack) | 2 | careful, freeze |
| [forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills) | 1 | karpathy-guidelines |
| [stellarlinkco/myclaude](https://github.com/stellarlinkco/myclaude) | 4 | product-requirements, test-cases, skill-install, sparv |
| [anthropics/skills](https://github.com/anthropics/skills) | 1 | skill-creator |
| [vercel-labs/skills](https://github.com/vercel-labs/skills) | 1 | find-skills |
| **Original / 原创** | 1 | mcu-selection |

---

## Skill Categories / 技能分类

### 1. Entry Point / 入口

| Skill | Description | 说明 | Source |
|-------|-------------|------|--------|
| **using-superpowers** | Session entry point and skill router. Routes to appropriate skills based on task type. | 会话入口和技能路由器。根据任务类型路由到对应技能。 | [obra/superpowers](https://github.com/obra/superpowers) |

### 2. Requirements & Design / 需求与设计

| Skill | Description | 说明 | Source |
|-------|-------------|------|--------|
| **product-requirements** | Interactive Product Owner with 100-point quality scoring. Generates PRD at score ≥90. | 交互式产品负责人，100 分制质量评分，≥90 分生成 PRD。 | [stellarlinkco/myclaude](https://github.com/stellarlinkco/myclaude/tree/master/skills/product-requirements) |
| **brainstorming** | Collaborative design exploration. One question at a time, proposes 2-3 approaches. HARD GATE: no code before design approval. | 协作式设计探索。逐个提问，提出 2-3 种方案。硬性门槛：设计批准前不写代码。 | [obra/superpowers](https://github.com/obra/superpowers) |
| **mcu-selection** | MCU selection from 284+ database (SiLabs, GigaDevice, Fudan Micro, WCH, XHSC). | 从 284+ 数据库中选择 MCU（芯科、兆易创新、复旦微、沁恒、小华）。 | **Original / 原创** |

### 3. Planning / 规划

| Skill | Description | 说明 | Source |
|-------|-------------|------|--------|
| **writing-plans** | Converts specifications into step-by-step implementation plans with 2-5 min tasks. | 将规格说明转换为逐步实施计划，每项任务 2-5 分钟。 | [obra/superpowers](https://github.com/obra/superpowers) |
| **test-cases** | Generates structured test cases from PRD/requirements. Bridges requirements → testing. | 从 PRD/需求生成结构化测试用例。连接需求与测试。 | [stellarlinkco/myclaude](https://github.com/stellarlinkco/myclaude/tree/master/skills/test-cases) |

### 4. Execution / 执行

| Skill | Description | 说明 | Source |
|-------|-------------|------|--------|
| **subagent-driven-development** | Executes plans with fresh subagent per task + two-stage review (spec compliance + code quality). | 每个任务委派新子代理执行，双重审查（规格合规 + 代码质量）。 | [obra/superpowers](https://github.com/obra/superpowers) |
| **executing-plans** | Alternative inline execution with batch checkpoints. Lighter weight than SDD. | 替代的内联执行方式，带批量检查点。比子代理驱动更轻量。 | [obra/superpowers](https://github.com/obra/superpowers) |
| **dispatching-parallel-agents** | Runs 2+ independent tasks in parallel with separate subagents. | 使用独立子代理并行运行 2+ 个独立任务。 | [obra/superpowers](https://github.com/obra/superpowers) |

### 5. Testing / 测试

| Skill | Description | 说明 | Source |
|-------|-------------|------|--------|
| **test-driven-development** | RED → GREEN → REFACTOR. Iron Law: no code without failing test first. | 红→绿→重构。铁律：没有失败测试就不写代码。 | [obra/superpowers](https://github.com/obra/superpowers) |
| **verification-before-completion** | MANDATORY before claiming done. Runs verification commands and confirms output. | 完成前强制验证。运行验证命令并确认输出。 | [obra/superpowers](https://github.com/obra/superpowers) |

### 6. Quality Assurance / 质量保证

| Skill | Description | 说明 | Source |
|-------|-------------|------|--------|
| **karpathy-guidelines** | Coding quality: think before code, simplicity, surgical changes, verifiable criteria. | 编码质量：先思考后编码，简洁，精准修改，可验证的标准。 | [forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills) |
| **requesting-code-review** | Gets code review before merging. Works with subagent-driven per-task review. | 合并前获取代码审查。配合子代理驱动的逐任务审查。 | [obra/superpowers](https://github.com/obra/superpowers) |
| **receiving-code-review** | Processes code review feedback with technical rigor before implementing. | 在实施前以技术严谨性处理代码审查反馈。 | [obra/superpowers](https://github.com/obra/superpowers) |
| **careful** | Safety guardrails for destructive commands. Signals: flash, erase, fuse, force-push. | 破坏性命令的安全护栏。信号词：烧录、擦除、熔丝、强制推送。 | [garrytan/gstack](https://github.com/garrytan/gstack) |
| **freeze** | Restricts file edits to a specific directory. Especially valuable in embedded debugging. | 将文件编辑限制在特定目录。在嵌入式调试中特别有价值。 | [garrytan/gstack](https://github.com/garrytan/gstack) |

### 7. Debugging / 调试

| Skill | Description | 说明 | Source |
|-------|-------------|------|--------|
| **systematic-debugging** | Structured bug investigation: freeze scope → careful → TDD → verify. NEVER skip on bugs. | 结构化缺陷调查：锁定范围→谨慎→TDD→验证。遇到缺陷绝不跳过。 | [obra/superpowers](https://github.com/obra/superpowers) |

### 8. Delivery / 交付

| Skill | Description | 说明 | Source |
|-------|-------------|------|--------|
| **using-git-worktrees** | Creates isolated git worktrees for feature work. Required before SDD or executing-plans. | 为功能开发创建隔离的 git 工作树。SDD 和执行计划的前置要求。 | [obra/superpowers](https://github.com/obra/superpowers) |
| **finishing-a-development-branch** | Implementation done → verify tests → present merge/PR options → clean up. | 实现完成→验证测试→提供合并/PR 选项→清理。 | [obra/superpowers](https://github.com/obra/superpowers) |

### 9. Skill Development / 技能开发

| Skill | Description | 说明 | Source |
|-------|-------------|------|--------|
| **writing-skills** | TDD for process docs: write failing test → write skill → refactor. | 过程文档的 TDD：写失败测试→写技能→重构。 | [obra/superpowers](https://github.com/obra/superpowers) |
| **skill-creator** | Create, evaluate, benchmark, and optimize skills. Complements writing-skills. | 创建、评估、基准测试和优化技能。与 writing-skills 互补。 | [anthropics/skills](https://github.com/anthropics/skills) |
| **skill-install** | Install skills from GitHub with automated security scanning. | 从 GitHub 安装技能，带自动安全扫描。 | [stellarlinkco/myclaude](https://github.com/stellarlinkco/myclaude/tree/master/skills/skill-install) |
| **find-skills** | Discover and install new skills from the open skills ecosystem. | 从开放技能生态中发现和安装新技能。 | [vercel-labs/skills](https://github.com/vercel-labs/skills) |

### 10. Workflow / 工作流

| Skill | Description | 说明 | Source |
|-------|-------------|------|--------|
| **sparv** | SPARV: Specify → Plan → Act → Review → Vault. Structured task execution with journaling. | SPARV：指定→计划→行动→审查→归档。带日志的结构化任务执行。 | [stellarlinkco/myclaude](https://github.com/stellarlinkco/myclaude/tree/master/skills/sparv) |

---

## Workflow Diagram / 工作流程图

```mermaid
flowchart TD
    subgraph Entry["Entry / 入口"]
        US[using-superpowers<br/>技能路由]
    end

    subgraph Requirements["Requirements & Design / 需求与设计"]
        PR[product-requirements<br/>产品需求 PRD]
        BS[brainstorming<br/>设计探索]
        MCU[mcu-selection<br/>MCU选型 🏷️原创]
    end

    subgraph Planning["Planning / 规划"]
        WP[writing-plans<br/>编写计划]
        TC[test-cases<br/>测试用例]
    end

    subgraph Execution["Execution / 执行"]
        UGW[using-git-worktrees<br/>工作树隔离]
        SDD[subagent-driven-development<br/>子代理驱动开发]
        EP[executing-plans<br/>内联执行计划]
        DPA[dispatching-parallel-agents<br/>并行代理调度]
    end

    subgraph Testing["Testing / 测试"]
        TDD[test-driven-development<br/>测试驱动开发]
        VBC[verification-before-completion<br/>完成前验证]
    end

    subgraph Quality["Quality / 质量"]
        KG[karpathy-guidelines<br/>编码准则]
        RCR[requesting-code-review<br/>请求代码审查]
        RCVD[receiving-code-review<br/>接收代码审查]
        CARE[careful<br/>安全护栏]
        FRZ[freeze<br/>编辑范围锁定]
    end

    subgraph Debug["Debugging / 调试"]
        SD[systematic-debugging<br/>系统化调试]
    end

    subgraph Delivery["Delivery / 交付"]
        FD[finishing-a-development-branch<br/>完成开发分支]
    end

    subgraph Meta["Skill Development / 技能开发"]
        WS[writing-skills<br/>编写技能]
        SC[skill-creator<br/>技能评估优化]
        SI[skill-install<br/>安装技能]
        FS[find-skills<br/>发现技能]
    end

    subgraph Workflow["Standalone Workflow / 独立工作流"]
        SP[SPARV<br/>指定→计划→行动→审查→归档]
    end

    %% Main flow
    US -->|"new project / 新项目"| PR
    US -->|"feature / 功能"| BS
    US -->|"bug / 缺陷"| SD
    US -->|"embedded / 嵌入式"| MCU
    US -->|"traceability / 可追溯"| SP

    %% Requirements flow
    PR --> BS
    PR --> MCU
    MCU -->|"MCU constrains design<br/>MCU约束设计"| BS
    BS -->|"design approved<br/>设计批准"| WP

    %% Planning flow
    WP --> TC
    WP --> UGW

    %% Execution flow
    UGW --> SDD
    UGW --> EP
    WP --> DPA

    %% Quality during execution
    SDD -.-> KG
    SDD -.-> CARE
    SDD -.-> FRZ
    SDD -.-> TDD
    SDD -.-> RCR
    SDD -.-> VBC
    EP -.-> KG
    EP -.-> CARE
    EP -.-> FRZ

    %% Code review
    RCR --> RCVD

    %% Debugging flow
    SD --> FRZ
    SD --> CARE
    SD --> TDD
    SD --> VBC

    %% Delivery
    SDD --> FD
    EP --> FD
    FD --> VBC
    FD --> RCR

    %% Meta skills
    WS --> SC
    FS --> SI

    %% Styling
    classDef entry fill:#4A90D9,stroke:#2C5F8A,color:#fff
    classDef req fill:#7B68EE,stroke:#4B3BAE,color:#fff
    classDef original fill:#E74C3C,stroke:#A83325,color:#fff
    classDef plan fill:#2ECC71,stroke:#1A8B4C,color:#fff
    classDef exec fill:#E67E22,stroke:#A85C18,color:#fff
    classDef test fill:#9B59B3,stroke:#6C3483,color:#fff
    classDef qual fill:#F39C12,stroke:#A86C0C,color:#fff
    classDef debug fill:#9B59B6,stroke:#6C3483,color:#fff
    classDef deliver fill:#1ABC9C,stroke:#117A65,color:#fff
    classDef meta fill:#95A5A6,stroke:#6C7A7D,color:#fff
    classDef workflow fill:#34495E,stroke:#1C2833,color:#fff

    class US entry
    class PR,BS req
    class MCU original
    class WP,TC plan
    class UGW,SDD,EP,DPA exec
    class TDD,VBC test
    class KG,RCR,RCVD,CARE,FRZ qual
    class SD debug
    class FD deliver
    class WS,SC,SI,FS meta
    class SP workflow
```

> **Node colors / 节点颜色：** Red = original work (mcu-selection). Orange = quality guardrails from gstack (freeze, careful). Other colors = categories, see legend above.
> 红色 = 原创（mcu-selection）。橙色中 freeze 和 careful 来自 gstack 安全护栏。其余颜色代表类别，见上方图例。

---

## Workflow Routes / 工作流路径

### Route 1: New Project / 新项目（完整流程）

```
using-superpowers → product-requirements → brainstorming (+ mcu-selection if embedded)
→ writing-plans → test-cases → using-git-worktrees → subagent-driven-development
→ requesting-code-review → finishing-a-development-branch
```

### Route 2: Feature Development / 功能开发

```
using-superpowers → brainstorming → writing-plans → using-git-worktrees
→ subagent-driven-development → finishing-a-development-branch
```

### Route 3: Bug Fix / 缺陷修复

```
using-superpowers → systematic-debugging (→ freeze → careful)
→ test-driven-development → verification-before-completion
```

### Route 4: Embedded Project / 嵌入式项目

```
using-superpowers → product-requirements → mcu-selection → brainstorming
→ writing-plans → subagent-driven-development (with careful + freeze)
→ finishing-a-development-branch
```

### Route 5: Quick Traceability / 快速追溯

```
/sparv → Specify → Plan → Act → Review → Vault
```

---

## Cross-Cutting Skills / 横切技能

These skills are invoked by other skills at specific points, not triggered directly:

以下技能在特定场景下被其他技能调用，不直接触发：

| Skill | Invoked By | When / 何时调用 | Source |
|-------|-----------|----------------|--------|
| **freeze** | systematic-debugging, subagent-driven-development, executing-plans | Before editing — lock scope to fault module or task directory / 编辑前锁定范围到故障模块或任务目录 | [garrytan/gstack](https://github.com/garrytan/gstack) |
| **careful** | systematic-debugging, subagent-driven-development, finishing-a-development-branch | Before destructive ops: flash, erase, fuse, force-push / 破坏性操作前：烧录、擦除、熔丝、强制推送 | [garrytan/gstack](https://github.com/garrytan/gstack) |
| **karpathy-guidelines** | subagent-driven-development, executing-plans, systematic-debugging | During implementation — ensures quality principles / 实现过程中确保质量准则 | [forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills) |
| **verification-before-completion** | TDD, systematic-debugging, subagent-driven-development, finishing-a-development-branch | Before claiming done/fixed/passing / 完成前必须验证 | [obra/superpowers](https://github.com/obra/superpowers) |
| **requesting-code-review** | subagent-driven-development (per task), finishing-a-development-branch | After implementation, before merge / 实现后合并前 | [obra/superpowers](https://github.com/obra/superpowers) |
| **test-driven-development** | systematic-debugging (Phase 4), subagent-driven-development | Writing fix or feature code / 编写修复或功能代码 | [obra/superpowers](https://github.com/obra/superpowers) |

---

## Acknowledgments / 致谢

- [obra/superpowers](https://github.com/obra/superpowers) — Core workflow foundation (14 skills)
- [garrytan/gstack](https://github.com/garrytan/gstack) — Embedded safety guardrails: freeze, careful
- [forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills) — karpathy-guidelines
- [stellarlinkco/myclaude](https://github.com/stellarlinkco/myclaude) — product-requirements, test-cases, skill-install, sparv
- [anthropics/skills](https://github.com/anthropics/skills) — skill-creator
- [vercel-labs/skills](https://github.com/vercel-labs/skills) — find-skills
