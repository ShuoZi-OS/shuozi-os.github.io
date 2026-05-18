# ShuoZi OS — 路线图

> 100 步，10 个阶段，1 个目标：AI-native 操作系统。

---

## 总览

```
Phase 1     Phase 2     Phase 3     Phase 4     Phase 5
起步        Build       Tool        Linux       硬件层
(1-10)      in Public   Runtime     深入         (41-50)
            (11-20)     (21-30)     (31-40)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Phase 6     Phase 7     Phase 8     Phase 9     Phase 10
社区启动    Context     Workflow    Multi-      生态与融资
(51-60)     Engine      Engine      Agent        (91-100)
            (61-70)     (71-80)     (81-90)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

每个阶段结束时有一次版本发布。

---

## Phase 1: 起步（1-10）

**目标:** 搭建环境，学习基础，写出第一个 AI→Linux 原型。

| # | 任务 | 状态 |
|---|------|------|
| 1 | 安装 Linux (Ubuntu/WSL2) | ✅ |
| 2 | 安装 Git / Python / Node.js / Docker | ✅ |
| 3 | 创建 GitHub: `ShuoZi-OS` | ✅ |
| 4 | 统一品牌: ShuoZi OS / ShuoZi Labs | ✅ |
| 5 | 建立 README / VISION / ROADMAP | ✅ |
| 6 | 写系统哲学第一版 | ✅ |
| 7 | 学习 Shell 基础 | ✅ |
| 8 | 学习 Python subprocess | ✅ |
| 9 | 实现 `run_shell()` | ✅ |
| 10 | 第一次 AI → Linux 原型 | ✅ |

**产出版本:** `ShuoZi Runtime v0.1`

---

## Phase 2: Build in Public（11-20）

**目标:** 建立公开存在，培养持续输出习惯。

| # | 任务 |
|---|------|
| 11 | 注册 X/Twitter + GitHub 统一名 |
| 12 | 开始写 Dev Log |
| 13 | 第一次公开项目截图 |
| 14 | 建立开发日志文档 |
| 15 | 每天 commit |
| 16 | 学习 Git Flow |
| 17 | 建立项目目录结构 |
| 18 | 实现 `read_file` / `write_file` |
| 19 | 第一次录制 Demo 视频 |
| 20 | 发布 ShuoZi Runtime v0.1 |

---

## Phase 3: Tool Runtime（21-30）

**目标:** 构建结构化 tool calling 系统，这是 ShuoZi OS 的核心抽象。

| # | 任务 |
|---|------|
| 21 | 学习 Tool Calling 概念 |
| 22 | 设计 Tool Schema |
| 23 | 实现 Tool Router |
| 24 | 实现 JSON Tool Calls |
| 25 | 加入日志系统 |
| 26 | 加入错误处理 |
| 27 | 加入超时保护 |
| 28 | 实现文件系统工具 |
| 29 | 实现系统信息工具 |
| 30 | 发布 Tool Runtime v0.2 |

---

## Phase 4: Linux 深入（31-40）

**目标:** 深入理解 Linux 内核机制，为后续内核开发打基础。

| # | 任务 |
|---|------|
| 31 | 学习 `/dev`, `/proc`, `/sys` |
| 32 | 学习 systemd |
| 33 | 学习 DBus |
| 34 | 学习 Docker |
| 35 | 实现 Docker Tool |
| 36 | 实现 Process Manager |
| 37 | 实现 System Monitor |
| 38 | 实现 File Watcher |
| 39 | 写 Linux Runtime 文档 |
| 40 | 发布 Linux Runtime Alpha |

---

## Phase 5: 硬件层（41-50）

**目标:** AI 直接与硬件交互——USB、串口、Android、单片机。

| # | 任务 |
|---|------|
| 41 | 学习 USB 基础 |
| 42 | 学习 Serial 通信 |
| 43 | 实现 Serial Tool |
| 44 | 学习 ADB |
| 45 | 实现 adb shell / push / install |
| 46 | 实现 Android Screenshot Tool |
| 47 | 实现 Android Automation |
| 48 | 学习 ESP32 烧录 |
| 49 | 实现 AI 自动烧录 |
| 50 | 发布 Hardware Runtime v0.1 |

---

## Phase 6: 社区启动（51-60）

**目标:** 建立社区，开放贡献，形成第一批核心用户。

| # | 任务 |
|---|------|
| 51 | 建立 Discord / QQ群 |
| 52 | 开放 GitHub Issues |
| 53 | 第一次接收外部 PR |
| 54 | 开始写技术博客 |
| 55 | 发布系统架构图 |
| 56 | 建立官方网站 |
| 57 | 开始固定更新 |
| 58 | 开始积累邮件订阅 |
| 59 | 第一次小规模传播 |
| 60 | 形成第一批核心用户 |

---

## Phase 7: Context Engine（61-70）

**目标:** AI 的"内存管理系统"——持久化、可压缩、可恢复的上下文。

| # | 任务 |
|---|------|
| 61 | 学习 RAG |
| 62 | 实现短期记忆 |
| 63 | 实现长期记忆 |
| 64 | 实现 Context Compression |
| 65 | 实现任务历史系统 |
| 66 | 实现 Workspace Context |
| 67 | 实现 Tool History |
| 68 | 实现 Context Recovery |
| 69 | 实现 Runtime State |
| 70 | 发布 Context Engine Alpha |

---

## Phase 8: Workflow Engine（71-80）

**目标:** 任务规划、执行、失败恢复——AI 的"进程调度器"。

| # | 任务 |
|---|------|
| 71 | 学习 Task Planning |
| 72 | 实现 Planner |
| 73 | 实现 Task Queue |
| 74 | 实现 Workflow Graph |
| 75 | 实现自动重试 |
| 76 | 实现失败恢复 |
| 77 | 实现 Subtasks |
| 78 | 实现 Execution State |
| 79 | 实现 Workflow Memory |
| 80 | 发布 Workflow Runtime |

---

## Phase 9: Multi-Agent（81-90）

**目标:** 多 agent 协作——研究 agent、编码 agent、硬件 agent。

| # | 任务 |
|---|------|
| 81 | 学习 Subagents |
| 82 | 实现 Research Agent |
| 83 | 实现 Coding Agent |
| 84 | 实现 Hardware Agent |
| 85 | 实现 Planning Agent |
| 86 | 实现 Agent Router |
| 87 | 实现 Agent Communication |
| 88 | 实现 Agent Memory |
| 89 | 实现协同执行 |
| 90 | 发布 Multi-Agent Alpha |

---

## Phase 10: 生态与融资（91-100）

**目标:** 开放平台，建立开发者生态，启动公司化运营。

| # | 任务 |
|---|------|
| 91 | 开放 Plugin API |
| 92 | 开放 Tool SDK |
| 93 | 开放第三方工具接入 |
| 94 | 建立开发者文档 |
| 95 | 形成开发者生态 |
| 96 | 开始接触投资人 |
| 97 | 建立公司主体 |
| 98 | 保持控股结构 (目标 ≥70%) |
| 99 | 发布 ShuoZi OS Beta |
| 100 | 建立 AI Runtime Platform |

---

## 核心哲学

路线图里真正重要的不是哪个功能、融多少钱、做多大社群。

**真正的护城河 = 连续 10 年的系统积累。**

一个功能可以被模仿。10 年的内核代码、架构决策、tool 生态——无法被短期复制。

所以这个路线图的唯一 KPI 是：**不要停。**
