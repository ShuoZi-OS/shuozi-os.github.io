#!/bin/bash
# ============================================
# ShuoZi OS — GitHub 部署脚本
# 在 WSL 终端里运行: bash scripts/deploy-github.sh
# ============================================

set -e

echo "╔════════════════════════════════╗"
echo "║   ShuoZi OS — GitHub 部署     ║"
echo "╚════════════════════════════════╝"
echo ""

REPO_PATH="/mnt/e/ShuoZi OS (1)"
cd "$REPO_PATH"

# ------------------------------------------------------------------
# 1. 检查 Git
# ------------------------------------------------------------------
if ! command -v git &>/dev/null; then
    echo "❌ Git 未安装。请先: sudo apt install git"
    exit 1
fi
echo "✅ Git: $(git --version)"

# ------------------------------------------------------------------
# 2. 配置 Git（如果还没有）
# ------------------------------------------------------------------
if [ -z "$(git config --global user.name)" ]; then
    read -p "Git 用户名: " git_name
    git config --global user.name "$git_name"
fi
if [ -z "$(git config --global user.email)" ]; then
    read -p "Git 邮箱: " git_email
    git config --global user.email "$git_email"
fi
echo "✅ Git 用户: $(git config --global user.name) <$(git config --global user.email)>"
echo ""

# ------------------------------------------------------------------
# 3. 输入 GitHub 仓库地址
# ------------------------------------------------------------------
read -p "GitHub 仓库 URL (例: git@github.com:ShuoZi-OS/shuozi-os.github.io.git): " REPO_URL

if [ -z "$REPO_URL" ]; then
    echo "❌ 必须提供仓库 URL"
    exit 1
fi

# ------------------------------------------------------------------
# 4. 创建 .gitignore
# ------------------------------------------------------------------
cat > "$REPO_PATH/.gitignore" << 'GITIGNORE'
# Python
__pycache__/
*.py[cod]
*.pyo
.venv/

# 内部文档（不公开）
RUNTIME_RULES.md
CODING_STANDARDS.md
CONTRIBUTING.md
ShuoZi OS项目计划.txt

# 内部代码
prototype/
docs/architecture/

# 其他
*.swp
*~
.DS_Store
GITIGNORE
echo "✅ 已创建 .gitignore"

# ------------------------------------------------------------------
# 5. 准备公开文件
# ------------------------------------------------------------------
echo ""
echo "📦 准备公开文件..."

# 把 PUBLIC_README.md 作为仓库 README
cp "$REPO_PATH/PUBLIC_README.md" "$REPO_PATH/README.md"

# 确保网站文件就位
if [ ! -d "$REPO_PATH/site" ]; then
    echo "❌ site/ 目录不存在"
    exit 1
fi

echo "✅ 公开文件就绪"

# ------------------------------------------------------------------
# 6. Git 初始化 + 提交
# ------------------------------------------------------------------
echo ""
echo "📝 Git 初始化..."

if [ -d "$REPO_PATH/.git" ]; then
    echo "  已有 .git 目录，跳过 init"
else
    git init -b main
    echo "  已初始化 Git 仓库 (main 分支)"
fi

git add \
    README.md \
    VISION.md \
    ROADMAP.md \
    ARCHITECTURE_PRINCIPLES.md \
    .gitignore \
    site/

echo ""
echo "📋 将要提交的文件:"
git status --short
echo ""

read -p "确认提交? (y/n): " confirm
if [ "$confirm" != "y" ]; then
    echo "已取消"
    exit 0
fi

git commit -m "docs: 初始化 ShuoZi OS 公开仓库

- README: 项目介绍
- VISION: 10年愿景
- ROADMAP: 100步路线图
- ARCHITECTURE_PRINCIPLES: 设计宪章
- site: GitHub Pages 网站"

echo "✅ 已提交"

# ------------------------------------------------------------------
# 7. 推送
# ------------------------------------------------------------------
echo ""
echo "🚀 推送到 GitHub..."
git remote add origin "$REPO_URL" 2>/dev/null || git remote set-url origin "$REPO_URL"
echo "  首次推送，覆盖远程已有的初始 README..."
git push -u origin main --force

echo ""
echo "╔════════════════════════════════╗"
echo "║  ✅ 部署完成！                ║"
echo "╚════════════════════════════════╝"
echo ""
echo "接下来:"
echo "  1. 去 GitHub 仓库 Settings → Pages"
echo "  2. Source 选 'Deploy from a branch'"
echo "  3. Branch 选 'main' 文件夹选 '/site'"
echo "  4. Save → 等待 1-2 分钟"
echo "  5. 访问 https://你的用户名.github.io"
