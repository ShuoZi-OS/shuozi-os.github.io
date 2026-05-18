# ShuoZi OS — Dev Log

## 2026-05-17: Phase 1 完成

### 完成了什么

从零开始搭建了 ShuoZi OS 的第一个可运行原型。Phase 1 的 10 步全部覆盖：

| # | 任务 | 状态 | 产出 |
|---|------|------|------|
| 1 | 安装 Linux (WSL2) | ✅ | Ubuntu 22.04 运行中 |
| 2 | 安装工具链 | ✅ | Git, Python 3, Node, Docker |
| 3 | GitHub 仓库 | ✅ | ShuoZi-OS/shuozi-os.github.io |
| 4 | 统一品牌 | ✅ | ShuoZi OS / ShuoZi Labs |
| 5 | 核心文档 | ✅ | README, VISION, ROADMAP |
| 6 | 系统哲学 | ✅ | 架构原则 + 运行时规则 + ADR |
| 7 | Shell 基础 | ✅ | 原理已掌握 |
| 8 | Python subprocess | ✅ | 原理已掌握 |
| 9 | run_shell() | ✅ | 代码完成 + 自测通过 |
| 10 | AI → Linux 原型 | ✅ | 代码完成 + 自测通过 |

### 写了什么代码

```
prototype/
├── run_shell.py       核心：subprocess.run() 的结构化封装
│                     双模式：列表（安全）/ 字符串（功能全）
│                     输出：ShellResult（6 字段 + JSON）
│                     自测：6 组，全部通过
│
├── ai_linux.py        原型：意图 → tool call → 结果
│                     已注册 4 个 tool：
│                       shell.run   — 执行 shell 命令
│                       fs.read     — 读取文件
│                       fs.ls       — 列出目录
│                       system.info — 系统信息
│                     agent_execute() 规则匹配意图 → 调 tool
│
├── shell_cli.py       CLI 图形化模式（人类用）
│                     彩色 ✓/✗/⏰、表格汇总、交互式 Shell
│
├── shell_ai.py        全 AI 模式（agent 用）
│                     JSON envelope、结构化错误、tool schema
│
└── main.py            统一入口
                      --mode human → 交互式 CLI
                      --mode ai    → JSON 输出
```

### 写了什么文档

```
E:\ShuoZi OS (1)\
├── README.md                    项目介绍
├── VISION.md                    10 年愿景
├── ROADMAP.md                   100 步路线图
├── ARCHITECTURE_PRINCIPLES.md   7 大架构原则
├── RUNTIME_RULES.md             12 条系统铁律
├── CODING_STANDARDS.md          C + Rust + AI 编码规范
├── CONTRIBUTING.md              贡献指南（人类 + AI agent）
├── docs/
│   ├── learning/
│   │   ├── shell-basics.md      Shell 实操速成
│   │   └── python-subprocess.md subprocess 手把手
│   └── architecture/
│       └── decisions/
│           ├── README.md        ADR 索引
│           ├── ADR-TEMPLATE.md  决策记录模板
│           └── ADR-0000-...     为什么从零造 OS
└── site/                        GitHub Pages 网站源文件
```

### 验证了什么

- `run_shell()` 在 WSL2 Ubuntu 上 6/6 自测通过
- 列表模式 `_irreversible: false`（安全标记正确）
- 字符串模式 `_irreversible: true`（不可逆标记正确）
- 超时 5000ms 触发正确（`sleep 10` → 5 秒超时）
- 命令不存在 → `exit_code: 127`，stderr 被捕获
- AI 模式 JSON 输出格式完整（`ok / data / error / meta`）
- CLI 模式彩色交互 Shell 可用

### 核心架构决策

1. **tool 是第一公民。** 系统能力通过 tool 暴露，不是通过 GUI 菜单。
2. **双消费模式。** 同一个 tool 给人类彩色 CLI，给 AI 纯 JSON——接口相同，呈现不同。
3. **安全从列表模式开始。** `shell=True` 是过渡方案，长期方向是把管道/通配符拆成独立 tool。
4. **结构化错误。** 不给字符串错误，给 `{code, detail, hint}` 让 AI agent 能程序化决策。

### 下次优化清单

- [ ] 本地 git remote 修复 + push 原型代码上 GitHub
- [ ] `run_shell()` 列表模式补 Windows 兼容
- [ ] 错误彻底结构化（Phase 3 前置）
- [ ] 添加 `fs.write` tool
- [ ] README 更新 Phase 1 完成状态
- [ ] v0.1 发布
- [ ] 开始 Phase 2: 公开 Dev Log
