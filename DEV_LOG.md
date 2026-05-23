# ShuoZi OS — Dev Log

## 2026-05-20: 路线修正 — 从 Python 原型转向内核开发

### 关键决策

前 19 步的 Python 原型完成了架构验证（tool 系统、双盘、事件日志、TUI 命令面板）。但它们是设计稿，不是 OS。

决定：
- Python 代码归档为设计参考（`prototype/README.md`）
- v0.1 取消——OS 的第一个版本号应该给能启动的内核
- 路线图重写：100 步全部是内核/系统级大步，无填充项
- 从 Phase 0 Step 1 开始：MBR bootloader，512 字节，裸机

### 不改的东西

- 核心理念不变：agent → tool → context
- 双盘架构不变：工作盘 + 备份盘，删除不传备份
- 第一性原理不变：不抄 Linux
- 100 步 10 年不变：每一年的产出必须是系统代码

## 2026-05-19: Phase 2 过半 + 全代码审查优化

### 代码优化

逐文件审查了全部 5 个 Python 文件，清理了 12 处死 import / 死变量 / 无意义调用：

- `run_shell.py` — 删除 `sys`, `shlex` 死 import
- `shell_cli.py` — 删除 `time`, `shutil` 死 import，删除 `WHITE/GRAY/BG_RED` 死常量，修复 `c(DIM, "")` 包装空字符串
- `shell_ai.py` — 无问题，新增 Session 日志写入
- `ai_linux.py` — 完全重构：
  - 文件操作统一用 Python 原生 I/O（不再走 shell）
  - 新增 `fs.write` tool（覆盖 + 追加）
  - `fs.read` 改用 `open().read()`
  - `fs.ls` 改用 `os.listdir()` 返回结构化结果
  - 删除 `shlex`, `asdict`, `Optional`, `Any` 死 import
  - 意图匹配新增写文件支持

### 双终端架构

- 创建 `prototype/session.py` — 共享 Session 对象
  - CLI 终端和 AI 终端写入同一个 Session
  - 每条操作记录 source（cli/ai）、timestamp、结果
  - `summary()` 返回会话摘要
- `shell_cli.py` 和 `shell_ai.py` 都接入 Session
  - CLI 新增 `summary` 命令查看会话状态
  - AI 模式写的命令 CLI 通过 history 可见，反之亦然
- 编写 `docs/design/dual-terminal.md` 架构设计文档

### 项目规则

- `CODING_STANDARDS.md` 新增铁律 #6：先想后写，写后再想，然后优化。简洁就是好代码。
- 编写 `docs/learning/git-flow.md` — Git Flow 分支策略文档

### GitHub 进度

- 推送 6 次 commit（文档更新 + 优化 + 分支创建）
- 创建 `dev` 分支
- 公开发布 Phase 1 原型截图（Issue #1，标注为示例界面）
- README 链接截图、更新完成状态

### Phase 2 进度: 7/10

| # | 任务 | 状态 |
|---|------|------|
| 11 | X/Twitter | ⬜ 暂缓（手机验证） |
| 12 | Dev Log | ✅ |
| 13 | 公开截图 | ✅ |
| 14 | 开发日志文档 | ✅ |
| 15 | 每天 commit | ✅ |
| 16 | Git Flow | ✅ |
| 17 | 项目目录结构 | ✅ |
| 18 | read/write file | ✅ |
| 19 | Demo 视频 | ⬜ 明天 |
| 20 | v0.1 发布 | ⬜ |

---

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
