#!/bin/bash
# ============================================
# 修复本地 git remote
# 在 WSL Ubuntu 里跑: bash scripts/fix-git-remote.sh
# ============================================

set -e

REPO_PATH="/mnt/e/ShuoZi OS (1)"
cd "$REPO_PATH"

echo "1. 拉取 GitHub 上的最新内容（你在网页上传的那些）..."
git pull origin main --allow-unrelated-histories || {
    echo "pull 失败。可能需要先 stash 本地改动。"
    echo "运行: git stash && git pull origin main --allow-unrelated-histories && git stash pop"
    exit 1
}

echo ""
echo "2. 提交本地新增文件（原型代码 + 学习材料）..."
git add \
    prototype/run_shell.py \
    prototype/ai_linux.py \
    docs/learning/shell-basics.md \
    docs/learning/python-subprocess.md \
    docs/architecture/decisions/README.md \
    docs/architecture/decisions/ADR-TEMPLATE.md \
    docs/architecture/decisions/ADR-0000-shuozi-os-exists.md \
    scripts/fix-git-remote.sh \
    scripts/deploy-github.sh \
    2>/dev/null

echo ""
git status --short

read -p "确认提交? (y/n): " confirm
if [ "$confirm" = "y" ]; then
    git commit -m "feat: 添加原型代码和学习材料

    - prototype/run_shell.py: 支持列表+字符串双模式
    - prototype/ai_linux.py: AI 意图→tool call 原型
    - docs/learning/: Shell 和 subprocess 实操速成
    - docs/architecture/decisions/: ADR 模板 + ADR-0000"
    git push origin main
    echo "✅ 完成"
else
    echo "已取消"
fi
