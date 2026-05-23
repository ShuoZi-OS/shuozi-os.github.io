# ShuoZi OS

> 不是聊天机器人。不是 Linux 发行版。  
> 一个全新的 AI-native 操作系统，从第一性原理构建。

---

## 这是什么

ShuoZi OS 是为 AI agent 设计的操作系统。

传统 OS 的设计中心是进程——执行中的程序，通过文件系统读写数据，通过系统调用请求服务。  
ShuoZi OS 的设计中心是 **agent**——能理解上下文、使用工具、自主规划执行任务的 AI 实体。

```
程序的操作系统：      进程 → 文件 → 系统调用
AI 的操作系统：       agent → tool → context
```

---

## ⚠ 当前状态

**正在开发内核。Phase 0，Step 1。**

这是一个从裸机启动开始的 OS 项目。当前没有可用版本，没有安装包，不面向普通用户。

`prototype/` 目录存放了架构设计的概念验证代码（Python），仅作设计参考——不是 ShuoZi OS 本身。

---

## 核心理念

- **从第一性原理出发。** 不抄 Linux。每个子系统重新设计。
- **内核优先。** 先有能启动的内核，才有上面的一切。
- **工具化架构。** 系统能力通过 tool 暴露，不是通过 GUI 菜单。
- **双盘存储。** 工作盘 + 备份盘。删除不传备份。误删零损失。
- **安全是结构性的。** 从 bootloader 到 syscall，每一层都自带安全检查。

---

## 文档

| 文档 | 内容 |
|------|------|
| [VISION.md](VISION.md) | 10 年愿景 |
| [ROADMAP.md](ROADMAP.md) | 100 步路线图 |
| [ARCHITECTURE_PRINCIPLES.md](ARCHITECTURE_PRINCIPLES.md) | 设计宪章 |
| [RUNTIME_RULES.md](RUNTIME_RULES.md) | 系统铁律 |
| [CODING_STANDARDS.md](CODING_STANDARDS.md) | 编码规范 |
| [DEV_LOG.md](DEV_LOG.md) | 开发日志 |
| [prototype/README.md](prototype/README.md) | 原型归档说明 |
| [docs/design/](docs/design/) | 架构设计文档 |

---

## 技术栈

- **内核:** C + 少量汇编（x86-64）
- **构建:** Make + GCC cross-compiler
- **模拟:** QEMU
- **参考设计:** `prototype/` Python 代码

---

## 许可证

Copyright © 2026 ShuoZi Labs. All rights reserved.
