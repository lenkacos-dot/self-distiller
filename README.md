<p align="center">
  <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="MIT License">
  <img src="https://img.shields.io/badge/python-3.8%2B-blue" alt="Python 3.8+">
  <img src="https://img.shields.io/badge/dependencies-0-green" alt="Zero Dependencies">
  <img src="https://img.shields.io/badge/platform-Hermes%20%7C%20Claude%20%7C%20ChatGPT%20%7C%20OpenCode-lightgrey" alt="Platform">
  <img src="https://img.shields.io/badge/version-v1.0-orange" alt="v1.0">
  <img src="https://img.shields.io/github/stars/lenkacos-dot/self-distiller?style=social" alt="GitHub Stars">
</p>

<br/>

<h1 align="center">🧬 Self-Distiller</h1>
<h3 align="center">Personal Knowledge Distillation for Any AI Agent</h3>
<h4 align="center"><strong>让任何 AI Agent 持续编译、维护一个关于「你自己」的结构化知识库。</strong></h4>

<br/>

---

> **此版本为分享版模板，不含任何个人数据。导入你自己的材料后再使用。**

---

## 📖 这是什么 / What is this

把你的日记、聊天记录、音乐歌单、浏览历史、博客等任何数据，**提炼成按维度组织的个人认知图谱**。每条认知都带着置信度、来源引用和矛盾标注。

分享版 = 完整的工具链 + 空白模板，拿到就能用。

---

## 🏗️ 架构 / Architecture

```
                    ┌─────────────────────────────────────┐
                    │        Self-Distiller Pipeline      │
                    └─────────────────────────────────────┘

    原始材料                   蒸馏过程                    提炼结果
  ┌────────────┐          ┌────────────────┐          ┌──────────────┐
  │ raw/       │          │   AI Agent     │          │ wiki/        │
  │            │          │                │          │              │
  │ 聊天记录   │ ──►     │ 读取 → 分析    │ ──►     │ 01-认知偏好  │
  │ 日记       │ ──►     │ 提取 → 写入    │ ──►     │ 02-决策模式  │
  │ 歌单       │ ──►     │ 矛盾标注       │ ──►     │ 03-价值体系  │
  │ 浏览历史   │ ──►     │ 置信度评分     │ ──►     │ 04-说话风格  │
  │ 博客       │ ──►     │                │ ──►     │ 05-品味偏好  │
  │            │          │                │          │ 06-人生记忆  │
  └─────┬──────┘          └────────────────┘          └──────┬───────┘
        │                                                    │
        ▼                                                    ▼
  encrypt-raw.sh                                      Personal Profile
  (AES-256-CBC)                                      去识别化总结

                    ┌─────────────────────────────────────┐
                    │     加密层（可选但推荐）              │
                    │  encrypt-raw.sh lock / unlock        │
                    │  AES-256-CBC + SIGINT 自动清理       │
                    └─────────────────────────────────────┘
```

---

## 📁 各部分功能对照 / What's Inside

```
self-distiller-skill-分享版/
│
├── README.md                       ← ⭐ 本文档。使用说明 + 所有文件的功能解释
│
├── SKILL.md                        ← 🤖 [AI Agent 操作手册]。告诉 Hermes/Claude Code/Codex
│                                     怎么读、写、更新这个知识库。
│                                     🔧 模板文件，无需修改即可用。
│                                     已包含：蒸馏流程 + 跨平台指南 + 5 个高级工作流
│
├── wiki/                           ← 📖 [蒸馏后的画像]。你用起来后，AI 会在这里写入
│   ├── _index.md                   ← 目录索引。🔧 模板
│   ├── 01-cognition.md             ← 🧠 [认知偏好] — 怎么学、怎么想、怎么处理信息
│   ├── 02-decision-mode.md         ← 🤔 [决策模式] — 怎么做决定、风险偏好
│   ├── 03-value-system.md          ← ⚖️ [价值体系] — 什么重要、道德边界
│   ├── 04-voice.md                 ← 🗣️ [说话风格] — 口语习惯、语气词、用词偏好
│   ├── 05-taste.md                 ← 🎵 [品味偏好] — 音乐、视频、内容消费倾向
│   ├── 06-memory.md                ← 📅 [人生记忆] — 经历、故事、重要节点
│   └── contradictions.md           ← ⚠️ [矛盾记录] — 当新数据与旧认知冲突时记录在这里
│
├── raw/                            ← 📦 [原始材料]。把你的原始数据放这里
│   └── material_index.md           ← 材料清单模板。AI 读完材料后会更新它
│
├── academic-distillation.md        ← 🎓 [学术蒸馏模块]。把论文/学术写作风格萃取的完整指南
│                                     - 写作风格提取（从你的论文审稿/回复中提炼风格）
│                                     - 论文知识库（每篇论文结构化记录）
│                                     - 4 个写作用例（引言起草、方法对比、相关工作、差距分析）
│                                     🔧 模板，无需修改
│
├── paper-wiki/                     ← 📚 [论文知识库]。管理你读过/引用过的论文
│   ├── _index.md                   ← 论文总索引。🔧 模板
│   ├── papers/TEMPLATE.md          ← 单篇论文模板（问题、方法、结论、引用关系等 8 个字段）
│   └── topics/TEMPLATE.md          ← 主题对比模板（多篇论文对比、差距分析）
│
├── reports/                        ← 📊 [自检报告]
│   └── README.md                   ← 自检流程说明。AI 执行自检后报告输出于此
│
├── encrypt-raw.sh                  ← 🔐 [加密/解密工具]。AES-256-CBC
│                                     支持子目录 + SIGINT 自动清理
│                                     lock：加密 raw/；unlock：解密 raw/
│                                     🔧 直接可用，无需修改
│
├── Privacy_Guide_隐私安全说明.md    ← 🛡️ [隐私说明书]。解释：
│                                     - 加密能防什么/不能防什么
│                                     - 使用后的清理清单
│                                     - 如何做自审
│                                     🔧 直接可用（已去除个人路径，通用版本）
│
├── .gitignore                      ← Git 忽略规则。已配好：raw/、.enc_key、备份文件
│                                     🔧 直接可用
│
└── raw/wiki/ 内的 .md 文件          ← 纯文本，AI 可直接读写。
                                       raw/ 下的文件建议加密，用 encrypt-raw.sh 管理
```

---

## ⚔️ 功能对比 / Feature Comparison

| Feature | Self-Distiller | Manual Notes | Other Tools |
|---------|:--------------:|:------------:|:-----------:|
| **AI-driven distillation** | ✅ | ❌ | ⚠️ Limited |
| **6-dimensional profile** | ✅ | ❌ | ❌ |
| **Contradiction tracking** | ✅ | ❌ | ❌ |
| **Confidence scoring** | ✅ | ❌ | ❌ |
| **Encryption (AES-256)** | ✅ | N/A | ❌ |
| **Zero dependencies** | ✅ | ✅ | ❌ |
| **Paper knowledge base** | ✅ | ❌ | ❌ |
| **Privacy-first design** | ✅ | ❌ | ❌ |

---

## 🔄 工作流程 / Workflow

```
材料              raw/                   wiki/（提炼结果）
 📄 聊天记录 →  放这里         →  AI →  01-cognition.md
 🎵 歌单     →  建议加密        →  读取  →  02-decision-mode.md
 📱 笔记     →                  →  分析  →  03-value-system.md
                                   提取  →  04-voice.md
                                   写入  →  05-taste.md
                                          →  06-memory.md
                                          →  contradictions.md
```

---

## ⚡ 三步上手 / Quick Start (3 Steps)

1. **复制材料**：把你的日记、聊天记录、歌单等丢进 `raw/`
2. **加密**（可选但推荐）：`./encrypt-raw.sh lock` 加密原始材料
3. **告诉 AI**：`帮我用 Self-Distiller 蒸馏我的信息`

AI 会自动解密（`./encrypt-raw.sh unlock`）→ 读取 raw/ → 分析 → 写入 wiki/ → 重新加密。

---

## 🛡️ 隐私说明 / Privacy

| 数据层级 | 默认状态 | 谁能看到 |
|---------|---------|---------|
| raw/（原始材料）| 模板（空）| 你放入什么就是什么。建议用 encrypt-raw.sh 加密 |
| wiki/（提炼结果）| 模板（示例行）| AI Agent 能读写。提炼结果是去识别化的总结 |
| .gitignore | 已配置 | 阻止 raw/ 和密钥被提交到 Git |

---

## 📊 维度体系 / Dimension System

| 阶段 | 维度 | 功能 | 状态 |
|:----:|------|------|:----:|
| Phase 1 | 🧠 认知偏好 (01-cognition) | 怎么学、怎么想、怎么处理信息 | 🔧 模板待填充 |
| Phase 2 | 🤔 决策模式 (02-decision-mode) | 怎么做决定、风险偏好 | 🔧 模板待填充 |
| Phase 2 | ⚖️ 价值体系 (03-value-system) | 什么重要、道德边界 | 🔧 模板待填充 |
| Phase 1 | 🗣 说话风格 (04-voice) | 口语习惯、语气词、用词偏好 | 🔧 模板待填充 |
| Phase 1 | 🎵 品味偏好 (05-taste) | 音乐、视频、内容消费倾向 | 🔧 模板待填充 |
| Phase 1 | 📅 人生记忆 (06-memory) | 经历、故事、重要节点 | 🔧 模板待填充 |
| Phase 3 | 🎭 完整画像 | 行为、情绪、能力等 | ⏳ 待扩展 |

---

## 🔗 Related / 相关

| Resource | Link |
|----------|------|
| **GitHub Repo** | [https://github.com/lenkacos-dot/self-distiller](https://github.com/lenkacos-dot/self-distiller) |
| **Hermes Agent** | [https://hermes-agent.nousresearch.com](https://hermes-agent.nousresearch.com) |
| **Boss Mode** | [https://github.com/lenkacos-dot/boss-mode](https://github.com/lenkacos-dot/boss-mode) |

---

## 📄 License

```
MIT License

Copyright (c) 2025 lenkacos-dot

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

> **v1.0 分享版** | 不含个人数据 | MIT — Do what you want. Credit if you find it useful.