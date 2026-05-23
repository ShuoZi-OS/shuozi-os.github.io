# ShuoZi OS — 100 步路线图

> 2026-05-20 重写。每一步都是内核/系统级大步。没有"装工具""学概念"填充项。
> 当前 Python 原型归档为设计稿，不占版本号。

---

## Phase 0: 裸机与启动（1–10）

**目标：** CPU 通电后，执行到内核第一行 C 代码。GDT/IDT 就位，能往屏幕写字。

| # | 任务 |
|---|------|
| 1 | 写 MBR bootloader（512 字节，加载第二扇区） |
| 2 | 切实模式→保护模式（设 GDT，关中断，开 A20） |
| 3 | 进入 32 位代码段，设栈，跳 C 入口 |
| 4 | 设 IDT，注册异常处理函数（#DE, #PF, #GP 至少 6 个） |
| 5 | 写 VGA 文本驱动（0xB8000，彩色输出） |
| 6 | 物理内存探测（BIOS E820 / GRUB multiboot） |
| 7 | 切换到长模式（x86-64：设 PML4/PDPT/PD/PT，进 64 位） |
| 8 | 重定位内核到高地址（0xFFFF800000000000） |
| 9 | 设 GDT 64 位版，设 TSS |
| 10 | 内核 panic 机制：蓝屏/红屏，dump 寄存器，halt |

---

## Phase 1: 内存管理（11–20）

**目标：** 物理页分配器→虚拟内存→内核堆。从此不再硬编码地址。

| # | 任务 |
|---|------|
| 11 | 物理页帧分配器（bitmap + 空闲链表，4KB 页） |
| 12 | 虚拟地址空间初始化（PML4 自映射） |
| 13 | `map_page(vaddr, paddr, flags)` / `unmap_page(vaddr)` |
| 14 | 内核堆分配器（kmalloc/kfree，slab 或 buddy） |
| 15 | 写时复制（CoW）基础设施 |
| 16 | 内存映射文件基础（mmap 语义） |
| 17 | 物理内存压力测试 + OOM 处理 |
| 18 | 大页支持（2MB / 1GB pages） |
| 19 | 每 CPU 变量 + percpu 分配 |
| 20 | 内存统计接口（/proc/meminfo 等价物） |

---

## Phase 2: 中断与外设（21–30）

**目标：** 系统能响应外部事件。键盘能打字，时钟能滴答，硬盘能读写。

| # | 任务 |
|---|------|
| 21 | 8259 PIC 初始化 + IRQ 路由 |
| 22 | PIT 定时器（100Hz 滴答） |
| 23 | PS/2 键盘驱动（扫描码→ASCII） |
| 24 | 串口驱动（COM1, 115200 8N1） |
| 25 | APIC/IOAPIC 初始化和中断分发 |
| 26 | HPET 高精度定时器 |
| 27 | ATA PIO 磁盘读写 |
| 28 | AHCI SATA 驱动 |
| 29 | NVMe 驱动基础 |
| 30 | 中断负载统计 + IRQ 平衡 |

---

## Phase 3: Agent 模型（31–40）

**目标：** ShuoZi OS 的核心抽象。不是进程——是 Agent。调度、上下文、内存空间完整。

| # | 任务 |
|---|------|
| 31 | Agent 控制块（ACB）：ID、状态、页表、上下文、capabilities |
| 32 | 上下文切换（保存/恢复寄存器、页表切换） |
| 33 | Agent 创建/销毁（agent_spawn / agent_exit） |
| 34 | 抢占式调度器（基于时间片，CFS 简化版） |
| 35 | Agent 优先级 + 实时 Agent 调度 |
| 36 | 用户态切换（Ring 3 执行，SYSCALL/SYSRET） |
| 37 | Agent 间消息传递（IPC：共享内存 + 信号） |
| 38 | Agent 组（agent group：共享内存空间） |
| 39 | Agent 休眠/唤醒（等待队列） |
| 40 | Agent 状态转储（crash 时 dump ACB + 栈） |

---

## Phase 4: Tool 接口（41–50）

**目标：** 内核的系统调用层——ShuoZi OS 的"tool call"等价物。结构化，可组合，带权限。

| # | 任务 |
|---|------|
| 41 | Tool 注册表（内核态 tool schema 注册） |
| 42 | syscall 入口（解析 tool name + JSON params） |
| 43 | capability token 系统（签发/校验/撤销） |
| 44 | `tool "agent.spawn"` — 从内核启动新 agent |
| 45 | `tool "mem.alloc"` / `tool "mem.free"` |
| 46 | `tool "ipc.send"` / `tool "ipc.recv"` |
| 47 | `tool "time.now"` / `tool "time.sleep"` |
| 48 | Tool 调用日志（结构化事件流，写入备份盘） |
| 49 | Tool 超时 + 死锁检测 |
| 50 | Tool 权限沙箱（agent 只能调被授权的 tool） |

---

## Phase 5: 文件系统（51–60）

**目标：** VFS 层 + 至少一个真实文件系统。双盘架构（工作盘 + 备份盘）持久化。

| # | 任务 |
|---|------|
| 51 | VFS 核心：inode / dentry / file / superblock |
| 52 | `tool "fs.create"` / `tool "fs.read"` / `tool "fs.write"` |
| 53 | `tool "fs.delete"` — 删除事件不传备份盘 |
| 54 | tmpfs（内存文件系统，用于 /tmp） |
| 55 | ext2 读取支持 |
| 56 | ext2 写入支持 |
| 57 | 备份盘驱动：追加只写，压缩日志 |
| 58 | 备份恢复：从备份盘回滚文件 |
| 59 | 路径解析 + 目录缓存（dcache） |
| 60 | 文件权限模型（rwx + capability 集成） |

---

## Phase 6: 用户态与 Shell（61–70）

**目标：** 用户能登录、敲命令、跑程序。第一个真正的 ShuoZi OS Shell。

| # | 任务 |
|---|------|
| 61 | ELF64 加载器（解析 header，映射段，设入口） |
| 62 | 第一个用户态程序：init |
| 63 | 标准库雏形（libshuozi：printf, malloc, tool_call） |
| 64 | ShuoZi Shell（/ 命令面板，tool 调用，管道） |
| 65 | 环境变量 + PATH 解析 |
| 66 | 标准输入/输出/错误（fd 0/1/2，管道） |
| 67 | 脚本引擎（.sz 脚本：tool 调用序列） |
| 68 | 用户管理（user ID，home 目录） |
| 69 | 登录流程（getty → login → shell） |
| 70 | 与系统原生 Shell 的差异文档 |

---

## Phase 7: Context Engine（71–80）

**目标：** AI agent 的内存。上下文持久化、可压缩、跨重启恢复。

| # | 任务 |
|---|------|
| 71 | Agent 上下文存储（对话历史 + tool 结果） |
| 72 | 上下文窗口管理（token 预算、自动截断） |
| 73 | 上下文压缩（旧对话自动摘要） |
| 74 | 上下文持久化（写入备份盘，重启恢复） |
| 75 | 多 Agent 上下文隔离 + 共享 |
| 76 | 上下文查询 API（语义搜索历史） |
| 77 | Agent 记忆优先级（重要信息标记，不被压缩清除） |
| 78 | 上下文快照（手动 bookmark 某时刻状态） |
| 79 | 上下文迁移（agent 从机器 A 迁到机器 B） |
| 80 | 上下文加密（at-rest encryption） |

---

## Phase 8: 网络栈（81–90）

**目标：** TCP/IP 网络。Agent 能联网、调远程 tool。

| # | 任务 |
|---|------|
| 81 | 网卡驱动（e1000 / rtl8139，至少一种） |
| 82 | ARP / IPv4 基础 |
| 83 | ICMP（ping） |
| 84 | UDP 协议栈 |
| 85 | TCP 协议栈（三次握手、滑动窗口、重传） |
| 86 | Socket API（socket / bind / listen / accept） |
| 87 | DHCP 客户端 |
| 88 | DNS 解析器 |
| 89 | HTTP/1.1 基础 + `tool "net.http"` |
| 90 | TLS 握手基础（mbedtls 移植） |

---

## Phase 9: 硬件与生态（91–100）

**目标：** 真实硬件支持。AI 能烧录单片机、控制 USB 设备、操作 Android。开放平台。

| # | 任务 |
|---|------|
| 91 | USB 栈（XHCI 驱动 + 枚举） |
| 92 | 串口 tool（`tool "serial.write"` / `tool "serial.read"`） |
| 93 | ADB 协议（`tool "adb.shell"` / `tool "adb.push"`） |
| 94 | ESP32 烧录（`tool "hw.flash"`） |
| 95 | 真实硬件启动（至少一台 x86 笔记本/台式机） |
| 96 | ARM64 移植（树莓派 4/5） |
| 97 | 第三方 Tool SDK（用户可写自定义 tool） |
| 98 | Plugin 沙箱（第三方 tool 隔离运行） |
| 99 | 开发者文档 + 示例 tool 仓库 |
| 100 | ShuoZi OS 自托管（用 ShuoZi OS 编译 ShuoZi OS） |

---

## 核心哲学

旧版路线图说"真正的护城河是 10 年积累"。这仍然是对的。但新版强调了另一个东西：

**每一步都是内核。** 没有 Python 脚本凑数。没有"学习"当任务。剩下 90 步（Phase 0-9 除去已完成的脚手架）全部是系统代码、硬件交互、架构设计。每一步都可能卡一周。这就是为什么需要 10 年。

路线图的唯一指标仍然是：**不要停。** 但现在多了一条：**每一步都值得停一周。**
