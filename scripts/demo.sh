#!/bin/bash
# ShuoZi OS — Phase 1 Demo
# 在 WSL 里跑: bash scripts/demo.sh
# 然后截图，发 GitHub

clear

echo "╔══════════════════════════════════════════════╗"
echo "║   ShuoZi OS — Phase 1 原型演示（示例界面）    ║"
echo "║   这不是可用的 OS，是概念验证代码的输出        ║"
echo "╚══════════════════════════════════════════════╝"
echo ""
echo "  5 个 tool 已注册，双终端共享 Session"
echo "  ⚠ 原型阶段，非正式产品"
echo ""

echo "──────────────────────────────────────────────"
echo "  1. 全 AI 模式（Agent 看到的是 JSON）"
echo "──────────────────────────────────────────────"
python3 prototype/main.py ai "echo hello from ShuoZi OS"
echo ""

echo "──────────────────────────────────────────────"
echo "  2. 系统信息 tool"
echo "──────────────────────────────────────────────"
python3 prototype/main.py ai "uname -a"
echo ""

echo "──────────────────────────────────────────────"
echo "  3. 文件写入 → 文件读取（闭环验证）"
echo "──────────────────────────────────────────────"
echo "hello from ShuoZi OS" > /tmp/shuozi-demo.txt
python3 prototype/main.py ai "cat /tmp/shuozi-demo.txt"
echo ""

echo "──────────────────────────────────────────────"
echo "  4. Tool Schema（Agent 靠这个理解系统）"
echo "──────────────────────────────────────────────"
python3 prototype/main.py ai --schema
echo ""

echo "──────────────────────────────────────────────"
echo "  5. 人类 CLI 模式（colorful terminal）"
echo "──────────────────────────────────────────────"
echo "  （截图下方展示 shuozi → 交互界面）"
echo ""
echo "══════════════════════════════════════════════"
echo "  仓库: github.com/ShuoZi-OS/shuozi-os.github.io"
echo "  Phase 1 完成 | Phase 2 进行中"
echo "══════════════════════════════════════════════"
