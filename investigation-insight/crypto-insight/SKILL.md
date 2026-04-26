---
name: crypto-insight
description: >
  Deep-dive investigation skill for any cryptocurrency token or project. Use this skill
  whenever the user provides a crypto ticker or name (e.g. BTC, ETH, SOL, DOGE) and wants
  analysis, on-chain investigation, or market research. Triggers on phrases like "analyze
  [TOKEN]", "investigate [CRYPTO]", "what's happening with [COIN]", "on-chain analysis of
  [TOKEN]", or any request to research a cryptocurrency project. Produces a structured
  report covering on-chain metrics, tokenomics, recent events, and competitive landscape.
status: planned
---

# crypto-insight

> 🚧 **Planned** — not yet implemented.
> This skill will be built as part of the `investigation-insight` plugin.

## Intended scope

When built, this skill will accept a crypto ticker or name as input and produce
a structured investigation report covering:

- **A — Market Overview**: Sector (L1, L2, DeFi, etc.), 3-month market performance
- **B — Project Background**: Team, founding, tokenomics, total supply, circulating supply
- **C — Price & Volume Performance**: 6-month price action, exchange listings, liquidity
- **D — On-Chain Metrics**: Active addresses, transaction volume, exchange flows, whale activity
- **E — Recent Events**: Protocol upgrades, partnerships, regulatory news, hacks (last 1 month)
- **F — Competitive Landscape**: Direct competitors, ecosystem positioning, moat analysis

## Planned tools
- Web search for price/news data
- On-chain data via public APIs (Glassnode, CryptoQuant, Nansen references)
- Exchange flow tracking

## To implement
Run `/skill-creator` and say: "build crypto-insight as part of investigation-insight plugin"
