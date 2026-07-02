# Self-Distiller — Self-Distillation Knowledge Base Skill

> A specialized instance of the **Karpathy LLM Wiki pattern** for self-knowledge.
> Shares the same architecture (three-layer + incremental workflow) as LLM Wiki, just a different domain:
> - LLM Wiki → your **external knowledge** (tools, configs, projects)
> - Self-Distiller → your **self-knowledge** (cognition, decisions, values)
> Both are independent — use one or both as you like.
>
> **[中文版说明 → README.zh.md](./README.zh.md)**

---

## What is Self-Distiller?

An agent-agnostic Skill that lets **any AI agent** (Hermes, Claude Code, Crush, local Ollama, etc.) continuously compile and maintain a structured knowledge base about **who you are**.

**Input**: diaries, notes, conversation logs, any self-related material
**Output**: dimension-organized Wiki pages with confidence scores, source citations, and contradiction markers
**Data**: plain Markdown + JSON, all stored locally, never uploaded to any cloud

---

## Relationship with LLM Wiki

Self-Distiller is a **specialization** of the Karpathy LLM Wiki pattern. They share the same architecture but serve different domains:

| | LLM Wiki | Self-Distiller |
|---|---|---|
| Domain | Your **external knowledge** | Your **self-knowledge** |
| Content | Tool configs, project notes, automations | Cognition, decisions, values, emotions |
| Dependency | Independent of Self-Distiller | **Independent of LLM Wiki** |

You can use Self-Distiller standalone, or pair it with LLM Wiki for complementary knowledge management.

---

## Core Features

### 1. Preserves Complexity, No Simplistic Labels

Other systems reduce you to tags: "introverted, rational, risk-averse". But people aren't tags.

Self-Distiller keeps contradictions visible:
- "I only put money in deposits" today, "I quit my job to start a business" tomorrow → marked as **context-dependent contradiction** (conservative in finance, adventurous in career)
- Used to prefer solitude, now enjoys socializing → **timeline marker**, shows growth not contradiction
- Self-assessed as "introverted" but friends say "extroverted" → **preserves both perspectives**

### 2. Every Insight Has a Traceable Source

Not AI guessing. Every Wiki entry is bound to a **material ID + original text location**:

> "User prefers tables for comparison (Source: diary 2026-06-29, para 3 + Xiaohongshu post 2026-06-30) → Confidence: High (two independent sources)"

You can always ask "Why do you think that?" and the AI will show you the original material.

### 3. Confidence System

| Level | Meaning |
|-------|---------|
| **High** | 2+ independent sources corroborate |
| **Medium** | 1 source + logical reasoning (Phase 2) |
| **Low** | Single mention or inferred — AI notes "speculative" |

### 4. Agent-Agnostic

Pure file I/O — doesn't depend on any specific AI platform.
- Hermes Agent ✅
- Claude Code / Codex CLI ✅
- Crush ✅
- Your local Ollama Qwen ✅

Any LLM that can `read_file` / `write_file` can operate it.

---

## Directory Structure

```
self-distiller/
├── SKILL.md                  ← Core instructions (tell the AI how to work)
├── wiki/
│   ├── _index.md             ← Index (initially empty)
│   ├── 01-cognition.md       ← Dimension template: cognition (Phase 1)
│   └── contradictions.md     ← Contradiction tracker (initially empty)
├── raw/
│   └── material_index.md     ← Source material index (read-only)
├── .state/
│   └── checkpoint.json       ← Checkpoint + token log
└── reports/self-check/       ← Self-check report output
```

## How to Use

### Three Actions

**Ingest** — Drop a diary entry, tell the AI: "Distill this into my self-portrait."
→ AI reads the material → extracts cognitive insights → writes to Wiki pages.

**Query** — Ask about yourself: "What's my decision-making style?"
→ AI searches the Wiki, synthesizes an answer, cites sources.

**Self-Check** — "Run a self-check."
→ AI scans all entries' confidence and freshness → outputs a report → you decide what to fix (AI never auto-modifies).

## Getting Started

1. Put this directory where your AI can access it
2. Tell your AI: "Set up the Self-Distiller skill, I want to start using it"
3. The AI will read `SKILL.md`, understand the structure, and confirm readiness
4. Start ingesting materials!

---

## Token Cost Estimate

| Operation | Token Range | Notes |
|-----------|------------|-------|
| Initialization | ~500 | Reading schema + creating directories |
| Import 1 material | 2,000~8,000 | Read + compare + write Wiki |
| Query | 300~1,500 | Read index + entries + answer |
| Self-check | 1,500~5,000 | Scan metadata + generate report |

At DeepSeek V4 Flash pricing (¥0.5/M input, ¥2/M output), each operation costs well under ¥0.01. File I/O is handled by the agent runtime (free).

---

## License

MIT. Based on the Karpathy LLM Wiki pattern and inspired by [Hatari130/podcast-bridge](https://github.com/Hatari130/podcast-bridge).
