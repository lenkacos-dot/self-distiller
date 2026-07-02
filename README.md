# Self-Distiller — 自我蒸馏知识库

> **让任何 AI Agent 持续编译、维护一个关于「你是谁」的结构化知识库。**
> Let any AI Agent continuously compile and maintain a structured knowledge base about who you are.

---

## 中文说明

### 这是什么？
把你的日记、聊天记录、笔记等自我相关材料，提炼成按维度组织的个人认知图谱。每条认知都带着置信度、来源引用和矛盾标注。

### 怎么用？
1. **把这个文件夹放到你的电脑上**（任何位置都行）
2. **告诉 AI Agent**（Hermes / Claude Code / Codex）：
   > "用 Self-Distiller Skill 蒸馏我的信息"
3. **提供材料** — 发一段日记、一份聊天记录、一篇文章给你
4. **持续积累** — 每次导入新材料，画像自动更新

### 文件结构
```
Self-Distiller-Skill/
├── SKILL.md              ← Agent 操作规则（不要修改）
├── README.md             ← 本文件（操作手册）
├── raw/                  ← 你的原始材料（LLM 只读）
│   └── material_index.md
├── wiki/                 ← 蒸馏后的画像（LLM 全权维护）
|   ├── _index.md         ← 目录
|   ├── 01-cognition.md   ← 认知偏好维度页面
|   ├── 04-voice.md       ← **说话风格模型（⭐ 新增）**
|   ├── 05-taste.md       ← **个人品味模型（⭐ 新增）**
|   └── contradictions.md ← 矛盾记录
└── .state/               ← 内部状态
    └── checkpoint.json
```

### 维度体系
| 阶段 | 维度 | 关注什么 |
|------|------|---------|
| Phase 1 | 🧠 认知偏好 | 怎么学、怎么想、怎么处理信息 |
| Phase 2 | 🤔 决策模式 | 理性 vs 直觉、风险偏好 |
| Phase 2 | 💎 价值体系 | 什么重要、什么优先 |
| Phase 3 | 🎭 行为/情绪/能力/关系/动机/盲区 | 完整人生画像 |

### 隐私
- 所有数据存在本地，不上传任何云端
- 可随时删除整个文件夹彻底清除

---

## English Guide

### What is this?
A structured knowledge base that continuously distills who you are — your cognition, decisions, values, behaviors — from your journals, chats, notes, and any self-related materials.

### How to use?
1. **Place this folder anywhere on your machine**
2. **Tell your AI Agent** (Hermes / Claude Code / Codex):
   > "Use Self-Distiller Skill to distill my information"
3. **Feed materials** — share a journal entry, chat log, or note
4. **Accumulate** — each import enriches your digital persona

### File Structure
```
Self-Distiller-Skill/
├── SKILL.md              ← Agent instructions (do not edit)
├── README.md             ← This file (user manual)
├── raw/                  ← Your raw materials (LLM read-only)
│   └── material_index.md
├── wiki/                 ← Distilled persona (LLM-managed)
│   ├── _index.md         ← Table of contents
│   ├── 01-cognition.md   ← Cognitive preferences
│   └── contradictions.md ← Contradiction log
└── .state/               ← Internal state
    └── checkpoint.json
```

### Dimension System
| Phase | Dimension | Focus |
|-------|-----------|-------|
| Phase 1 | 🧠 Cognition | Learning style, thinking patterns, info processing |
| Phase 2 | 🤔 Decision | Rational vs intuitive, risk preference |
| Phase 2 | 💎 Values | What matters, priorities, principles |
| Phase 3 | 🎭 Full profile | Behavior, emotion, skills, relationships, motivation, blind spots |

### Privacy
- All data stays local, zero cloud upload
- Delete the entire folder anytime to wipe everything
