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
| 02 | 决策模式 | 怎么做决定、风险偏好 |
| 03 | 价值体系 | 什么重要、道德边界 |
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

## 🔒 隐私安全

| 层级 | 说明 |
|------|------|
| ❌ 本模板不含个人数据 | 所有 `NN-name.md` 文件为空白模板 |
| ✅ 自带加密工具 | `encrypt-raw.sh` 开箱即用（AES-256 加密 raw/ 目录） |
| ✅ `.gitignore` 防误提交 | 已配置，挡住 raw/、.enc_key、微信导出目录 |
| ❓ 填入数据后 | 你的隐私数据仅存于本地 Markdown 文件 |
| ⚠️ 云 API 会出网 | 使用 DeepSeek/OAI 等云端 LLM 时，数据会被发送到其服务器 |
| 💡 本地模型不出网 | 使用 Ollama/LM Studio 则数据不离开本机 |
| ✅ 可随时删除 | 删除整个目录即可彻底清除 |
| 📖 详见隐私说明书 | `Privacy_Guide_隐私安全说明.md` — 含加密能防/不能防的详细说明 |
| 🎓 学术蒸馏模块 | `academic-distillation.md` + `paper-wiki/` — 学术写作风格蒸馏 + 论文知识库（见扩展模块） |

---

## 扩展模块

本模板附带以下可选模块，按需启用：

### 🎓 Academic Distillation — `academic-distillation.md`

专为学术场景设计，包含两个独立子目标：

1. **学术写作风格蒸馏** — 从你的论文草稿、导师批注中提取学术写作指纹，写入 self-wiki 的「说话风格」+「认知偏好」维度。让你用 AI 写论文时不跑调。
2. **论文知识蒸馏** — 将文献结构化蒸馏到 `paper-wiki/` 知识库，每篇论文一页（研究问题/方法/发现/可引用片段/引用关系），写 Literature Review 和 Related Work 时直接引用。
3. **论文写作用例** — 4 个组合用例，教你如何把风格蒸馏 + 论文知识蒸馏结合起来用（如："按我的学术风格写 Introduction"、"对比方法论"、"写 Related Work"、"分析论文缺陷"）

使用：阅读 `academic-distillation.md`，按需创建 `paper-wiki/` 目录下的论文条目。

---

## 高级工作流

### 1️⃣ 自检流程（完整性检查）

当你说"检查一下我的 Self-Distiller" 时自动执行：

```
1. 读取 _index.md → 检查所有维度的条目数是否符合预期
2. 对每个维度页面，检查条目 ID 格式是否连续无断层
3. 检查 contradictions.md：如果有 >20 条 wiki 条目但 contradictions.md 为空 → 主动扫描矛盾
4. 检查每个条目的最后更新日期：>90 天前的标记为「待验证」
5. 检查 .state/checkpoint.json 的总条目数是否与 wiki/ 合计一致
6. 扫描 raw/material_index.md：是否有新增材料未被蒸馏
7. 输出检查报告到 reports/self-check/{日期}.md
```

### 2️⃣ 矛盾检测工作流

每次导入新材料后自动执行：

```
1. 读取所有维度页面中的全部条目
2. 跨维度对比：
   - 认知偏好 vs 决策模式：思考方式与决策方式是否一致？
   - 说话风格 vs 品味偏好：表达方式反映了什么品味？
   - 记忆 vs 价值观：经历塑造了哪些价值观？
3. 如果发现矛盾 → 写入 contradictions.md
4. 更新矛盾的条目：在条目底部加 ⚠️ 参见矛盾链接
```

### 3️⃣ 查询应答工作流

当用户询问个人相关问题（"我怎么样"、"帮我"）时：

```
1. 解析问题 → 确定需要哪些维度
   - "帮我决定..." → 02-决策模式 + 03-价值体系
   - "帮我写..." → 04-说话风格 + 01-认知偏好
   - "我喜欢..." → 05-品味偏好 + 06-记忆
   - "我的故事..." → 06-人生记忆
2. 读取对应维度页面 → 筛选置信度≥高的条目
3. 如果交叉引用存在 → 联动读取
4. 组合多条条目 → 用第一人称、自然语言回答
5. 如果证据不足 → 说明不确定之处
```

### 4️⃣ 置信度衰减与废弃

| 最后更新距今 | 置信度调整 | 操作 |
|------------|-----------|------|
| < 30 天 | 不变 | — |
| 30-90 天 | 不变 | 添加「最后验证」标记 |
| 90-180 天 | 降一级（高→中，中→低） | 提示用户验证 |
| > 180 天 | 标记为 `⚠️ 待验证` | 需要新材料确认 |
| 用户明确表示改变 | 直接废弃 | 加 deprecated 标记 |

### 5️⃣ 交叉引用规则

每个新条目应检查：

```
- 这反映了什么价值观？ → 链接到 03-value-system.md
- 这影响了什么决策方式？ → 链接到 02-decision-mode.md
- 这和哪个记忆有关？ → 链接到 06-memory.md
- 这说明了什么品味？ → 链接到 05-taste.md
```
