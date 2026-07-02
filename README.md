# Self-Distiller — 自我蒸馏知识库

> **让任何 AI Agent 持续编译、维护一个关于「你是谁」的结构化知识库。**
> Let any AI Agent continuously compile and maintain a structured knowledge base about who you are.

---

## 中文说明

### 这是什么？
把你的日记、聊天记录、音乐歌单、浏览历史、博客文章、GitHub 代码等任何线上数据，**提炼成按维度组织的个人认知图谱**。每条认知都带着置信度、来源引用和矛盾标注。

**不管数据来自哪个平台** — 微信、QQ、微博、小红书、知乎、B站、YouTube、Spotify、QQ音乐、Kindle、GitHub……Agent 都能吸收。

### 怎么用？
1. **把这个文件夹放到你的电脑上**（任何位置都行）
2. **告诉 AI Agent**（Hermes / Claude Code / Codex）：
   > "帮我用 Self-Distiller 蒸馏我的信息"
3. **提供材料** — 发一段日记、一份聊天记录、一篇博客、一个歌单截图……
4. **持续积累** — 每次导入新材料，画像自动更新

### 文件结构
```
Self-Distiller-Skill/
├── SKILL.md              ← Agent 操作规则
├── README.md             ← 本文件（操作手册）
├── raw/                  ← 你的原始材料（LLM 只读）
│   └── material_index.md
├── wiki/                 ← 蒸馏后的画像（LLM 全权维护）
│   ├── _index.md         ← 目录
│   ├── 01-cognition.md   ← 认知偏好维度页面
│   └── contradictions.md ← 矛盾记录
└── .state/               ← 内部状态
    └── checkpoint.json
```

### 不同平台能提炼什么？

| 平台类型 | 平台举例 | 能了解你什么 |
|---------|---------|------------|
| 📱 聊天软件 | 微信、QQ、Telegram、iMessage | 沟通风格、社交模式、情绪、决策 |
| 📝 内容平台 | 知乎、微博、小红书、博客 | 思考方式、价值观、兴趣领域 |
| 🎵 音乐平台 | QQ音乐、网易云、Spotify、Apple Music | 情绪模式、品味偏好 |
| 🎬 视频平台 | YouTube、B站、抖音、Netflix | 学习风格、注意力模式 |
| 📚 阅读平台 | 微信读书、Kindle、豆瓣 | 知识结构、学习偏好 |
| 💻 代码平台 | GitHub、GitLab | 编程习惯、问题解决风格 |
| 🌐 浏览器 | Chrome/Safari 历史 | 信息获取习惯、好奇心模式 |

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
A structured knowledge base that continuously **distills who you are** — your cognition, decisions, values, behaviors — from your chats, music playlists, browsing history, blog posts, GitHub code, and any online data.

**No matter which platform** — WeChat, QQ, Weibo, Xiaohongshu, Zhihu, Bilibili, YouTube, Spotify, QQ Music, Kindle, GitHub… the Agent can absorb it.

### How to use?
1. **Place this folder anywhere on your machine**
2. **Tell your AI Agent** (Hermes / Claude Code / Codex):
   > "Use Self-Distiller Skill to distill my information"
3. **Feed materials** — share a journal, chat log, playlist, blog post…
4. **Accumulate** — each import enriches your digital persona

### What each platform reveals

| Platform Type | Examples | What it reveals |
|--------------|----------|----------------|
| 📱 Chat | WeChat, WhatsApp, Telegram | Communication style, relationships, emotions, decisions |
| 📝 Writing | Blog, Medium, Zhihu | Thinking patterns, values, interests |
| 🎵 Music | Spotify, Apple Music, QQ Music | Emotional patterns, taste preferences |
| 🎬 Video | YouTube, Bilibili, TikTok | Learning style, attention patterns |
| 📚 Reading | Kindle, Goodreads | Knowledge structure, learning preferences |
| 💻 Code | GitHub, GitLab | Coding habits, problem-solving style |
| 🌐 Browser | Chrome/Safari history | Information diet, curiosity patterns |

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
