# Self-Distiller — Self-Distillation Knowledge Base Skill

> A specialized instance of the **Karpathy LLM Wiki pattern** for self-knowledge.
> Shares the same architecture (three-layer + incremental workflow) as LLM Wiki, just a different domain:
> - LLM Wiki → your **external knowledge** (tools, configs, projects)
> - Self-Distiller → your **self-knowledge** (cognition, decisions, values)
> Both are independent — use one or both as you like.

---

## Overview

Lets any AI agent continuously compile and maintain a structured knowledge base about "who you are."

- **Input**: diaries, notes, conversation logs, any self-related material
- **Output**: dimension-organized Wiki pages with confidence scores, source citations, and contradiction markers
- **Data**: plain Markdown + JSON, all stored locally

---

## How It Works

Based on the Karpathy LLM Wiki pattern with three layers:

```
self-distiller/
├── SKILL.md              ← This file: rules, templates, token budget
├── raw/                  ← Immutable layer: original materials, read-only
│   └── material_index.md
├── wiki/                 ← Wiki layer: LLM-maintained structured pages
│   ├── index.md          ← Table of contents
│   ├── 01-cognition.md   ← Cognitive preferences
│   ├── ...               ← More dimensions as added
│   └── contradictions.md ← Contradiction tracker (key feature!)
├── .state/               ← Internal state (user-invisible)
│   └── checkpoint.json   ← Checkpoint + token log
└── reports/              ← Self-check reports
    └── self-check/
```

---

## Dimension System

Each dimension is a separate `wiki/NN-name.md` file.

### Phase 1 (MVP) — Single Dimension

1. **Cognition** — Learning style, information processing, attention patterns

### Phase 2 — Expand to 3 Dimensions

1. Cognition
2. **Decision-making** — Risk tolerance, rational vs intuitive, procrastination
3. **Value system** — Core values, priorities, principles

### Phase 3 — Full 9 Dimensions

1. Cognition
2. Decision-making
3. Value system
4. **Behavior patterns** — Daily habits, social style, expression
5. **Emotional patterns** — Triggers, regulation, resilience
6. **Skill map** — Depth & breadth of abilities
7. **Relationship patterns** — Interaction style, trust pace
8. **Motivation drivers** — Intrinsic/extrinsic, goal orientation
9. **Blind spots & growth** — Known weaknesses, past lessons, biases

---

## Entry Format

Every Wiki entry follows this structure:

```markdown
## Entry ID: cognition-003

**Confidence**: High | **Created**: 2026-06-01 | **Updated**: 2026-06-15
**Source**: [raw/M003.md] | **Version**: 2 (updated 2 times)

### Content
[Core description]

### Evidence
- [raw/M003.md] → paragraph 3: user stated...
- [raw/M012.md] → another source corroborates

### Change History
- v1 2026-06-01: First extracted from diary M001
- v2 2026-06-15: Material M012 strengthened this observation, confidence Medium→High

### Related
- [[01-cognition#entry cognition-001]]
```

---

## Token Budget (Hard Constraints)

These limits must be followed in any operation:

| Operation | Token Cap | Behavior on Exceed |
|-----------|-----------|-------------------|
| Material parsing | 2,000/batch | Auto-truncate, record checkpoint |
| Wiki comparison | 3,000/run | Only compare Medium+ confidence entries |
| Wiki writing | No cap | Writing cost is minimal |
| Self-check scan | 5,000/run | Sort by confidence ascending, skip low-priority |
| Query response | 3,000/run | Prioritize high-confidence entries |

---

## Workflows

### A. Ingest New Material

1. **Receive material** — User provides self-related content (diary, notes, etc.)
2. **Write to raw/** — Save with material ID (immutable layer)
3. **Read index.md** — Understand existing entries
4. **Parse & extract** — Extract key info per current dimensions
   - Matching existing entries → update (add source, adjust confidence)
   - New info → create new entry
5. **Update contradictions.md** — If new info contradicts existing, record it (never force-unify)
6. **Update index.md** — Reflect changes
7. **Update checkpoint.json** — Record token usage
8. **Report** — Tell user what was added/changed

### B. Query

1. User asks about themselves ("What's my cognitive style?")
2. **Read index.md** → locate relevant pages and entries
3. **Read target entries** → synthesize answer
4. **Cite sources** — Show which materials support the answer

### C. Self-Check (Index-Level, No Full-Text Review)

1. Scan all Wiki entries' confidence + last-updated timestamp
2. Flag:
   - Entries untouched for 30+ days → "possibly stale"
   - Low-confidence entries → "needs more evidence"
   - Contradictions unresolved for 30+ days → "needs review"
3. Output self-check report (never auto-modify entries)
4. Let user decide whether to do full-text cross-check on specific entries

---

## Contradiction Handling (Core Feature)

**Never auto-unify contradictions.** Preserve them with classification:

| Type | Example | Handling |
|------|---------|----------|
| **Timeline evolution** | "Used to prefer solitude, now enjoys socializing" | Mark timeline, note as **change** not contradiction |
| **Context-dependent** | "Rational at work, emotional in personal life" | Mark context tags, note as **switch** not contradiction |
| **Blind spot** | Self-assessed "introverted" vs friends say "extroverted" | Tag as **needs review**, ask user to judge |

```markdown
## Contradiction: decision-002 vs decision-007

**Type**: Context-dependent | **Found**: 2026-06-15
**Sources**: raw/M003.md (decision-002) vs raw/M012.md (decision-007)

**decision-002**: Risk-averse, "only deposit, never stocks"
**decision-007**: Risk-seeking, "quit job to start business"

**Analysis**: M003 is about banking/investing, M012 is about career
**Action**: Marked as context-dependent. Suggested user add more career decision materials.
```

---

## Comparison with Other Systems

| System | Storage | Traceable Sources | Contradictions | Agent-Agnostic | Best For |
|--------|---------|------------------|----------------|----------------|----------|
| **Agent Memory** | Key-value pairs | ❌ | ❌ | ❌ | Config values |
| **gbrain RAG** | Vector DB | ✅ | ❌ mixed | ✅ | General knowledge retrieval |
| **Clone/Persona Bot** | Finetune or Prompt | ❌ | ❌ | ❌ | Mimicking user speech |
| **LLM Wiki** | Markdown Wiki | ✅ | ✅ | ✅ | Tech/project knowledge |
| **Self-Distiller** | **Structured entry Wiki** | **✅** | **✅ classified** | **✅** | **Self-knowledge** |

---

## Privacy & Security

### Commitment
1. All data stored only on local filesystem, never uploaded to any cloud
2. Wiki entries contain no full text of original materials, only material ID references
3. User can delete the entire `self-distiller/` directory to erase all data
4. Recommend adding `self-distiller/` to `.gitignore` to avoid accidental public commits

### Risk Notice
- This Skill produces highly personal data
- Do not place `self-distiller/` in public cloud sync directories without encryption
- For shared devices, consider file-level encryption
- Before importing materials, check for sensitive PII (ID numbers, bank cards, etc.)
