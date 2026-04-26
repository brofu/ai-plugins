---
name: financial-report-insight
description: >
  Deep-dive financial report comparison skill. Use this when a user wants to compare
  financial statements, earnings trends, or key ratios across quarters or against peers.
  Also called automatically by stock-insight (Section D). Triggers on phrases like
  "compare financials for [TICKER]", "show me the earnings trend for [COMPANY]",
  "financial report analysis of [TICKER]", or when stock-insight delegates Section D.
status: planned
parent: stock-insight
---

# financial-report-insight

> 🚧 **Planned** — sub-skill of `stock-insight` (Section D).

## Intended input
```
/financial-report-insight [TICKER] [optional: vs TICKER2]
```
Examples:
- `/financial-report-insight NVDA` — last 4 quarters trend
- `/financial-report-insight NVDA vs AMD` — peer comparison

## Intended scope
- Revenue, gross profit, operating income, net income (last 4-8 quarters)
- Key margins: gross, operating, net
- EPS actual vs. estimates (beat/miss history)
- Balance sheet: cash, debt, D/E ratio
- Free cash flow trend
- Peer comparison table (if second ticker provided)
- Valuation multiples: P/E, P/S, EV/EBITDA vs sector average

## To implement
Run `/skill-creator` and say: "build financial-report-insight as a sub-skill of stock-insight"
