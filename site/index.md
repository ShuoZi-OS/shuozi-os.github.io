---
title: ShuoZi OS
layout: default
---

<div class="hero">
  <h1>ShuoZi OS</h1>
  <p class="tagline">
    不是聊天机器人。不是 Linux 发行版。<br>
    一个全新的 AI-native 操作系统，从第一性原理构建。
  </p>
</div>

---

## 这是什么

ShuoZi OS 是为 AI agent 设计的操作系统。

传统 OS 的设计中心是进程——一个执行中的程序，通过文件系统读写数据，通过系统调用请求服务。这个模型为 1970 年代的计算而优化。

**ShuoZi OS 的设计中心是 agent**——一个能理解上下文、使用工具、自主规划执行任务的 AI 实体。agent 需要的不是 `fork()` 和 `read()`，而是结构化 tool call、持久化上下文、capability-based 权限模型。

> 程序的操作系统：进程 → 文件 → 系统调用  
> AI 的操作系统：agent → tool → context

---

## 当前阶段

我们正在构建 ShuoZi OS 的第一个原型。

- 实现核心 tool 系统：`run_shell`、`fs.read`、`fs.ls`、`system.info`
- 建立 AI → Linux 的意图执行管道
- 定义架构原则和运行时规则

[查看完整路线图 →](/roadmap)

---

## 核心理念

- **CLI 优先，永不做 GUI 优先。** 系统能力通过命令行、API、IPC 暴露。
- **工具化架构。** 每个能力封装为独立的、可组合的 tool。
- **能力抽象，非应用抽象。** 系统提供"做什么"，不是"打开哪个软件"。
- **权限是能力令牌。** 安全从第一天内建于架构，不是事后补丁。
- **AI 是头等用户。** 所有接口对 AI agent 和人类 CLI 用户完全平等。

---

## 联系我们

- GitHub: [github.com/ShuoZi-OS](https://github.com/ShuoZi-OS)
