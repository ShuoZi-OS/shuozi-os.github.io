# Step 7: Shell 实操速成

> 目标：能读懂和写出 ShuoZi OS 原型需要的所有 shell 命令。
> 预计：2-3 小时，在 WSL Ubuntu 终端里边看边敲。

---

## 1. 你在哪里（5 分钟）

```bash
pwd         # 当前目录
whoami      # 你是谁
uname -a    # 系统信息
ls          # 看目录里的文件
ls -la      # 看所有文件（含隐藏）+ 权限 + 大小
```

每敲一条，想想：这条命令的输出如果被 AI agent 读到，它能用来决定什么？

---

## 2. 文件操作（10 分钟）

```bash
echo "hello" > test.txt       # 写文件（> 会覆盖）
echo "world" >> test.txt      # 追加（>> 不会覆盖）
cat test.txt                  # 读文件
cat -n test.txt               # 读文件（带行号）
head -3 test.txt              # 只读前 3 行
tail -2 test.txt              # 只读后 2 行
wc -l test.txt                # 数行数
rm test.txt                   # 删除文件
```

试试创建、读取、追加、删除。

---

## 3. 目录操作（5 分钟）

```bash
mkdir mydir           # 创建目录
mkdir -p a/b/c        # 递归创建多层目录
cd mydir              # 进入目录
cd ..                 # 回上一级
ls -R a               # 递归列出
rmdir mydir           # 删空目录
rm -rf a              # 删目录和所有内容（危险！）
```

---

## 4. 管道 — Shell 的灵魂（10 分钟）

Pipeline 把一个命令的输出接到另一个命令的输入。这是 Unix 哲学的核心：每个工具做一件事，串起来完成复杂任务。

```bash
# 看所有文件，只找带 .md 的
ls -la | grep ".md"

# 看所有文件，找 .md，还顺便数个数
ls -la | grep ".md" | wc -l

# 看进程，找 python 相关的
ps aux | grep python

# 看根目录磁盘使用，按大小排序，取前 5
du -h / 2>/dev/null | sort -hr | head -5

# 历史上输入过的所有命令里，哪些最常用
history | awk '{print $2}' | sort | uniq -c | sort -rn | head -10
```

最后一个敲进去看看你自己的命令使用习惯。

---

## 5. 重定向 — 输出去哪（5 分钟）

```bash
ls /notexist 2> error.txt     # stderr 写进文件
cat error.txt
ls / > /dev/null 2>&1          # 所有输出丢弃（/dev/null 是黑洞）
ls / &> all.txt                # stdout + stderr 都进一个文件
```

---

## 6. 系统信息 — AI agent 的眼睛（10 分钟）

这些是 ShuoZi OS 里 `system.info` tool 将来要调用的命令：

```bash
# 内核
uname -a                       # 内核版本
cat /proc/version              # 更详细的内核版本

# 内存
free -h                        # 内存使用
cat /proc/meminfo | head -5    # 详细内存信息

# 磁盘
df -h                          # 磁盘使用
du -sh ~                       # 家目录用了多少

# 设备
lsblk                          # 块设备列表
lsusb                          # USB 设备列表
lspci                          # PCI 设备列表

# 进程
ps aux --sort=-%mem | head -5  # 吃内存最多的 5 个进程
top -bn1 | head -10            # 一次性系统负载快照

# 网络
ip addr                        # 网络接口
ss -tlnp                       # 谁在监听什么端口
```

---

## 7. 权限 — ShuoZi OS capability token 的前身（5 分钟）

```bash
ls -la                         # 每行开头的 rwxrwxrwx 就是权限
chmod +x script.sh             # 加执行权限
chmod 644 file.txt             # rw-r--r--
```

ShuoZi OS 的 capability token 取代的正是这个模型——但先用着。

---

## 8. 进程控制（5 分钟）

```bash
sleep 100 &                    # 后台跑一个 sleep
jobs                           # 看后台任务
kill %1                        # 杀掉它（%1 是 jobs 里的编号）
ps aux | grep sleep            # 确信死了
```

---

## 9. 脚本速成 — 把命令串成程序（10 分钟）

创建 `~/myscript.sh`：

```bash
#!/bin/bash
# 检查给定路径的磁盘使用。超过阈值告警。

THRESHOLD=80
USED=$(df "$1" | tail -1 | awk '{print $5}' | tr -d '%')

if [ "$USED" -gt "$THRESHOLD" ]; then
    echo "⚠ 磁盘使用率 $USED%，超过阈值 $THRESHOLD%"
else
    echo "✅ 磁盘使用率 $USED%，正常"
fi
```

```bash
chmod +x ~/myscript.sh
~/myscript.sh /
~/myscript.sh /mnt
```

---

## 完成标准

能完成以下任务就算通过：

1. 创建一个目录 `~/shuozi-test`
2. 在里面创建 3 个 .txt 文件
3. 把 3 个文件名写入一个 `index.txt`
4. 用一条管道命令数出 `index.txt` 里有多少行不是空的
5. 把结果追加写到一个 `result.txt` 文件
6. 把整个目录删干净

都做出来就把这条划掉：**Step 7 ✅**
