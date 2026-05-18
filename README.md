# ShuoZi OS

> 不是聊天机器人。不是 Linux 发行版。  
> 一个全新的 AI-native 操作系统，从第一性原理构建。

---

## 这是什么

ShuoZi OS 是为 AI agent 设计的操作系统。

传统 OS 的设计中心是**进程**——执行中的程序，通过文件系统读写数据，通过系统调用请求服务。  
ShuoZi OS 的设计中心是 **agent**——能理解上下文、使用工具、自主规划执行任务的 AI 实体。

```
程序的操作系统：      进程 → 文件 → 系统调用
AI 的操作系统：       agent → tool → context
```

---

## 当前阶段

**Phase 1: 起步** — 搭建环境、学习系统编程、实现最小原型。

- [x] 核心文档（README / VISION / ROADMAP）
- [x] 架构原则 + 运行时规则
- [x] `run_shell()` — AI 调用 shell 的结构化接口
- [x] AI → Linux 原型
- [x] 公开 Dev Log
- [x] 公开 GitHub 仓库
- [ ] v0.1 发布（下一步）

---

## 核心理念

- **CLI 优先，永不做 GUI 优先。** 系统能力通过命令行、API、IPC 暴露。
- **工具化架构。** 每个能力封装为独立的、可组合的 tool。
- **能力抽象，非应用抽象。** 暴露"做什么"而非"打开哪个应用"。
- **权限是能力令牌。** 安全从第一天内建于架构。
- **AI 是头等用户。** agent 和人类通过同一套结构化接口操作系统。

---

## 文档

| 文档 | 内容 |
|------|------|
| [VISION.md](VISION.md) | 10 年愿景 |
| [ROADMAP.md](ROADMAP.md) | 100 步路线图 |
| [ARCHITECTURE_PRINCIPLES.md](ARCHITECTURE_PRINCIPLES.md) | 设计宪章 |

---

## 网站

[shuozi-os.github.io](https://shuozi-os.github.io)

---

## 许可证

Copyright © 2026 ShuoZi Labs. All rights reserved.
