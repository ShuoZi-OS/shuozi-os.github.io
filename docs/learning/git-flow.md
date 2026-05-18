# ShuoZi OS — Git Flow 策略

> 版本: v1.0 | 适用: 单人开发

---

## 分支结构

```
main      稳定分支。只有经过验证的代码才合并到这里。
          来源: dev（通过 merge）
          对外公开。从不直接 commit。

dev       开发分支。日常工作在此分支或其子分支进行。
          来源: feature/*, fix/*, docs/*
          所有功能先合到 dev，验证通过后合到 main。

feature/* 功能分支。一个分支做一个功能。
          从 dev 分出，完成后合回 dev，分支删除。
          命名: feature/read-file, feature/tool-router

fix/*     修 bug。从 dev 分出，合回 dev，分支删除。

docs/*    文档改动。从 dev 分出，合回 dev（如果是纯文档，可以直接合 main）。
```

---

## 日常操作

### 开始新功能

```bash
git checkout dev
git pull origin dev
git checkout -b feature/xxx
# 写代码...
git add -A
git commit -m "feat(xxx): 描述"
git push origin feature/xxx
```

### 完成功能，合入 dev

```bash
git checkout dev
git pull origin dev
git merge feature/xxx
git push origin dev
git branch -d feature/xxx          # 删本地分支
git push origin --delete feature/xxx  # 删远程分支
```

### dev 稳定后，合入 main

```bash
git checkout main
git pull origin main
git merge dev
git push origin main
git checkout dev
git merge main   # 同步 main 的改动回 dev
```

---

## 规则

1. **从不直接 commit 到 main。** main 只接受 merge。
2. **一个分支一件事。** 不把读文件和写文件放在一个分支。
3. **合完就删。** feature 分支合入 dev 后立即删除，避免分支堆积。
4. **每次 commit 关联一个 Issue（如果有）。** `Closes #N`
5. **push 前先 pull。** 避免无意义的 merge commit。
