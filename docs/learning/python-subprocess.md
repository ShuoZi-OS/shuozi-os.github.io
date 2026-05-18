# Step 8: Python subprocess 实操速成

> 目标：理解 `run_shell()` 底层用到的 subprocess 模块，能写出安全的进程调用。
> 预计：1-2 小时，搭配 prototype/run_shell.py 源码边看边练。
> 前置：已完成 Step 7（Shell 基础）

---

## 1. 为什么不用 os.system()（5 分钟）

Python 有三种方式调用外部命令。从差到好：

```python
# ❌ 最差：os.system() — 返回值是退出码，不捕获输出，有注入风险
import os
code = os.system("ls -la")      # 输出直接打印到终端，拿不到

# ⚠ 还行：os.popen() — 能读到输出，但已过时
import os
with os.popen("ls -la") as f:
    output = f.read()

# ✅ 正确：subprocess — 全功能、安全、可控
import subprocess
result = subprocess.run(["ls", "-la"], capture_output=True, text=True)
print(result.stdout)
```

ShuoZi OS 只用第三种。`run_shell()` 封装的就是 `subprocess.run()`。

---

## 2. subprocess.run() 完全拆解（10 分钟）

```python
import subprocess

result = subprocess.run(
    # 参数 1: 命令
    ["echo", "hello"],          # 列表模式：安全，无 shell 注入
    # 或
    "echo hello",               # 字符串模式（需 shell=True）

    # 参数 2: 捕获输出
    capture_output=True,        # 捕获 stdout + stderr

    # 参数 3: 文本模式
    text=True,                  # 返回 str 非 bytes

    # 参数 4: 超时
    timeout=5.0,                # 秒。超时抛 TimeoutExpired

    # 参数 5: 工作目录
    cwd="/tmp",                 # 在 /tmp 下执行

    # 参数 6: 环境变量
    env={"PATH": "/usr/bin"},   # 只给 PATH，其他全空

    # 参数 7: 输入
    input="hello\nworld",       # 发给命令的 stdin
)
```

---

## 3. 结果对象 — 它返回什么（5 分钟）

```python
proc = subprocess.run(["ls", "/nonexistent"], capture_output=True, text=True)

print(proc.returncode)   # 退出码。0 = 成功。非 0 = 失败
print(proc.stdout)       # 标准输出（字符串）
print(proc.stderr)       # 标准错误（字符串）
print(proc.args)         # 原始命令

# 如果想失败时自动抛异常：
proc = subprocess.run(["ls", "/nonexistent"], check=True)
# 抛出 CalledProcessError
```

---

## 4. 错误处理 — 四种情况的对应（10 分钟）

ShuoZi OS 的 `run_shell()` 就是这么设计错误处理的：

```python
import subprocess

# 情况 1: 命令执行成功（退出码 0）
try:
    proc = subprocess.run(["echo", "ok"], capture_output=True, text=True)
    print(f"✅ stdout: {proc.stdout}")      # "ok\n"
except:
    pass  # 不会到这里

# 情况 2: 命令失败（退出码非 0）— 不会抛异常
proc = subprocess.run(["ls", "/nope"], capture_output=True, text=True)
print(f"exit_code: {proc.returncode}")      # 2
print(f"stderr: {proc.stderr}")             # 错误信息

# 情况 3: 超时 — 抛 TimeoutExpired
try:
    proc = subprocess.run(["sleep", "10"], timeout=1)
except subprocess.TimeoutExpired:
    print("⏰ 超时了")

# 情况 4: 命令不存在 — 抛 FileNotFoundError
try:
    proc = subprocess.run(["thiscmddoesntexist"], capture_output=True)
except FileNotFoundError:
    print("❌ 命令不存在")
```

---

## 5. shell=True 的危险与必要（5 分钟）

```python
# 危险：如果 user_input 是 "hello; rm -rf /"，灾难发生
user_input = "hello"
subprocess.run(f"echo {user_input}", shell=True)

# 安全：列表模式不经过 shell 解析
subprocess.run(["echo", user_input])

# 但管道 / 重定向 / 通配符只能用 shell=True
subprocess.run("cat *.txt | grep error | wc -l", shell=True)
```

ShuoZi OS 的设计：列表模式用于安全调用，字符串模式标记为 `_irreversible: True`。

---

## 6. pipe — 进程间通信（5 分钟）

有时需要两个进程协作，但不走 shell 管道：

```python
# 先得到一个进程的输出
p1 = subprocess.run(["ls", "/"], capture_output=True, text=True)

# 把它当输入喂给下一个进程
p2 = subprocess.run(["grep", "mnt"], input=p1.stdout, capture_output=True, text=True)

print(p2.stdout)
```

这就是 ShuoZi OS 里 tool 组合的底层原理：tool_a → stdout → tool_b 的 stdin。

---

## 7. 实作：手写一个简易 run_shell（10 分钟）

不要看 prototype/run_shell.py。从零写一个：

```python
import subprocess

def my_run_shell(cmd, timeout=30):
    try:
        proc = subprocess.run(
            cmd, shell=True,
            capture_output=True, text=True,
            timeout=timeout,
        )
        return {
            "ok": proc.returncode == 0,
            "stdout": proc.stdout,
            "stderr": proc.stderr,
            "exit_code": proc.returncode,
        }
    except subprocess.TimeoutExpired:
        return {
            "ok": False,
            "error": f"超时（>{timeout}s）",
        }
    except Exception as e:
        return {
            "ok": False,
            "error": str(e),
        }

# 测试
print(my_run_shell("echo hello"))
print(my_run_shell("cat /etc/hostname"))
print(my_run_shell("ls /nonexistent"))
```

写完再回去看 `prototype/run_shell.py`，对比你的版本和正式版的差异。

---

## 8. 看懂 run_shell.py 的每一行（5 分钟）

打开 `prototype/run_shell.py`。逐行回答：

1. `ShellResult` 为什么要用 `@dataclass`？不用会怎样？
2. `timed_out` 和 `error` 字段各自负责什么信号？
3. `asdict(result)` 把 `ShellResult` 变成什么？为什么要这么做？
4. `shell=use_shell` 变量是怎么决定值的？
5. `time.perf_counter()` 为什么不用 `time.time()`？
6. 超时捕获后为什么 `TimedOutExpired` 中拿不到 `stdout/stderr`？

不确定答案的话问我。

---

## 完成标准

做完以下就算通过：

1. 手写 `my_run_shell()` 能用列表和字符串两种模式
2. 用 `subprocess.run` 写一个脚本：列出 `/proc` 下所有数字开头的目录（它们是进程），打印进程 ID 和对应的命令行
3. 用 pipe 模式做一件事：`ls /` 的输出喂给 `grep "mnt"`
4. 解释 `capture_output=True, text=True` 如果不写会怎样

全做出来就把这条划掉：**Step 8 ✅**
