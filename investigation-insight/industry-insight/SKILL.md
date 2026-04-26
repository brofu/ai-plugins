---
name: industry-insight
description: >
  Deep-dive industry and sector analysis skill. Use this when a user wants to understand
  how a specific industry or sector is performing, its macro trends, key players, and
  outlook. Also called automatically by stock-insight (Section A). Triggers on phrases
  like "how is the [SECTOR] industry doing", "analyze the semiconductor sector",
  "what's the outlook for [INDUSTRY]", or when stock-insight delegates Section A.
status: planned
parent: stock-insight
---

# industry-insight

> 🚧 **Planned** — sub-skill of `stock-insight` (Section A).

## Intended input
```
/industry-insight [SECTOR] [SUB-INDUSTRY]
```
Example: `/industry-insight Technology Semiconductors`

## Intended scope
- GICS sector & sub-industry classification
- 3-month sector ETF performance (e.g. SMH, XLK, XLE)
- Key tailwinds and headwinds
- Regulatory & macro context
- Top 5 companies by market cap in the sector

## To implement
Run `/skill-creator` and say: "build industry-insight as a sub-skill of stock-insight"
