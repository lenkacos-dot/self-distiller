---
name: self-distiller
description: >-
  Continuously compile and maintain a structured knowledge base about who the user is — cognition, decisions, values, behaviors, emotions, skills, relationships, motivation, and blind spots. Distill insights from any platform data: chat logs (WeChat/QQ/Telegram/iMessage), music history (QQ Music/Spotify/Apple Music), video history (YouTube/Bilibili), blog posts, reading history (Kindle/WeRead), code (GitHub), browser history, journals, and notes. Use when the user wants to build a personal digital persona, distill their own information, analyze their communication style or thinking patterns, or extract self-knowledge from social media or app data.
---

# Self-Distiller — 自我蒸馏知识库 Skill

> 基于 Karpathy LLM Wiki 模式的**特化实例**。
> 让任何 AI Agent 持续编译、维护一个关于「你是谁」的结构化知识库。

## 工作原理

三层架构：
```
self-wiki/
├── raw/                   ← 不可变层：原始材料
│   └── material_index.md
├── wiki/                  ← Wiki 层：结构化页面
│   ├── _index.md          ← 目录
│   ├── NN-name.md         ← 维度页面
│   └── contradictions.md  ← 矛盾汇总
└── .state/                ← 内部状态
    └── checkpoint.json
```

## 维度体系

Phase 1: 认知偏好（学习方式、信息处理、注意力模式）
Phase 2: + 决策模式、价值体系
Phase 3: + 行为模式、情绪模式、能力图谱、关系模式、动机驱动、盲区&成长

### 当前已实现维度

| 编号 | 维度 | 说明 |
|------|------|------|
| 01 | 认知偏好 | 思维模式、学习风格 |
| 04 | 说话风格 | 语调、用词、表情习惯 |
| 05 | 个人品味 | 番剧、音乐、审美 |
| **06** | **人生记忆** | **真实故事、经历、感受** |

## 工作流

1. 导入新材料 → 按维度解析提取
2. 查询 → 从 wiki 回答
3. 自检 → 扫描过期条目和矛盾

## 跨平台数据蒸馏指南

任何平台的数据都可以蒸馏，关键是从不同平台提取不同维度的信息：

### 📱 社交聊天类（微信 / QQ / Telegram / WhatsApp / iMessage）
- **提取维度**: 沟通风格、社交模式、情绪模式、决策模式
- **关注点**: 表达方式、用词习惯、情绪波动、关键决策表述、人际关系模式
- **入参**: 聊天记录导出(.txt/.json/.csv)、截图OCR

### 📝 文字输出类（博客 / 日记 / 笔记 / 知乎 / 微博 / 小红书）
- **提取维度**: 思考模式、写作风格、价值观、认知偏好
- **关注点**: 论证方式、观点倾向、关注领域、知识结构、语言习惯
- **入参**: 文章列表(.md/.html)、API导出、剪藏内容

### 🎵 音乐喜好类（QQ音乐 / 网易云音乐 / Spotify / Apple Music）
- **提取维度**: 情绪模式、注意力模式、行为习惯
- **关注点**: 不同心情下的歌单、重复播放的歌曲、场景音乐选择
- **入参**: 歌单截图、播放历史导出、收藏列表

### 🎬 视频观看类（YouTube / Bilibili / 抖音 / 快手 / 腾讯视频）
- **提取维度**: 学习风格、注意力模式、兴趣图谱
- **关注点**: 内容类型偏好、观看时长模式、评论互动风格、收藏分类
- **入参**: 观看历史导出、收藏列表、点赞记录

### 📚 阅读类（Kindle / 微信读书 / 豆瓣读书 / 得到）
- **提取维度**: 学习风格、信息筛选、知识组织
- **关注点**: 书籍分类偏好、标注/笔记习惯、阅读节奏、书评风格
- **入参**: 书单截图、标注导出、书评内容

### 💻 代码开发类（GitHub / GitLab / Stack Overflow）
- **提取维度**: 思考模式、问题解决风格、能力图谱
- **关注点**: 编码习惯、文档风格、Issue/PR沟通方式、技术选型偏好
- **入参**: Profile页面、仓库README、PR/Issue内容

### 🌐 浏览习惯类（浏览器历史 / 收藏夹）
- **提取维度**: 信息筛选、注意力模式、兴趣图谱
- **关注点**: 信息获取路径、阅读深度、多任务程度、兴趣切换频率
- **入参**: 浏览器书签导出(.html)、历史记录CSV

### 📊 通用处理原则

无论什么平台的数据，Agent 遵循相同的提炼逻辑：

1. **识别信号** — 从原始数据中找出有自我揭示价值的内容片段
   - 这表达了一个观点 → 收入「价值观」维度
   - 这展现了一个决策 → 收入「决策模式」维度
   - 这体现了一种学习方式 → 收入「认知偏好」维度
   - 这流露了情绪 → 收入「情绪模式」维度
   - 这展示了一个技能 → 收入「能力图谱」维度
2. **去噪** — 过滤系统消息、广告、重复内容、无意义短文本
3. **聚类** — 将类似信号归入同一维度条目
4. **置信度** — 单一来源=置信度低，多来源印证=置信度高
5. **矛盾标记** — 不同平台表现不一致时记录矛盾，不做强行统一

## 隐私承诺
- 所有数据仅存在本地，不上传云端
- Wiki 不包含原始材料全文，仅引用 ID
- 用户可随时删除整个目录彻底清除
