---
name: stock-insight
description: >
  Deep-dive investigation skill for any U.S. stock ticker. Use this skill whenever
  the user provides a stock ticker symbol (e.g. AAPL, TSLA, NVDA) and wants analysis,
  research, or investigation of a company. Triggers on phrases like "analyze [TICKER]",
  "research [STOCK]", "give me insights on [COMPANY]", "investigate [TICKER]",
  "what do you think about [STOCK]", or any request to look into a publicly traded company.
  Also triggers when users ask about stock performance, company background, competitors,
  or recent news for a specific stock. This skill orchestrates multiple sub-analyses and
  produces a structured investment research report.
---

# stock-insight

A structured investigation skill that takes a stock ticker as input and produces a
comprehensive research report across 6 dimensions. Each section is clearly labeled
and actionable.

---

## Input

```
/stock-insight [TICKER]
```

Examples:
- `/stock-insight AAPL`
- `/stock-insight NVDA`
- `analyze TSLA` → triggers this skill
- `give me insights on Microsoft` → resolve to MSFT, then run this skill

If the user provides a company name instead of a ticker, resolve it to the correct
ticker symbol first before proceeding.

---

## Output Format

Produce a structured markdown report in chat with the following sections in order.
Use clear `##` headers for each section. At the end, offer to export as a Word or
PDF document using the docx/pdf skills.

---

## Investigation Workflow

> 📋 Before generating any output, read and apply the shared plugin rules at `../rules.md`.
> Pay special attention to **Rule 2 (Citation & Data Integrity)** — source hierarchy,
> no-data policy, and conflict resolution all apply to every section below.

Work through these 7 sections **in order**, using web search for each. Do not skip
sections. If data is unavailable for a section, note it explicitly rather than omitting
the section header.

---

### Section A — Industry Overview
*[Placeholder for industry-insight skill — implement later]*

For now, cover manually:
1. **Industry & Sector**: Identify the GICS sector and sub-industry this company belongs to.
2. **3-Month Industry Performance**: Search for how this industry/sector has performed over
   the past 3 months. Include notable tailwinds or headwinds affecting the sector.
3. **Macro Context**: Any regulatory changes, interest rate sensitivity, or macro trends
   relevant to this industry right now.

> 🔧 Note: When `industry-insight` skill is available, delegate Section A to it by calling:
> `/industry-insight [SECTOR] [SUB-INDUSTRY]`

---

### Section B — Company Background
*[Partial placeholder for founder-insight skill — founders deep-dive later]*

Cover:
1. **Founded**: Year and location of founding.
2. **Headquarters**: Current HQ location.
3. **Business Model**: What the company actually does and how it makes money (2-3 sentences).
4. **Market Capitalization**: Current market cap (search for latest figure).
5. **Employee Count**: Approximate number of employees.
6. **Founders & Key Leadership**: Name the founders and current CEO/leadership team.
   Provide a 1-sentence bio for each key figure.

> 🔧 Note: When `founder-insight` skill is available, delegate founder deep-dive to it by calling:
> `/founder-insight [FOUNDER_NAME]`

---

### Section C — 6-Month Price Performance

1. **Price Action**: Search for the stock's price range over the past 6 months.
   Include: current price, 6-month high, 6-month low, and % change over period.
2. **Volume Trends**: Any notable spikes in trading volume and what triggered them.
3. **Key Price Events**: Identify 2-3 moments where the stock moved significantly
   (>5%) and explain why.
4. **vs. Benchmark**: Compare performance to S&P 500 (SPY) over the same period.
5. **Analyst Consensus**: Current Buy/Hold/Sell ratings breakdown and average price target.

---

### Section D — Financial Report Highlights
*[Placeholder for financial-report-insight skill — detailed financial comparison later]*

**Step 1 — Detect data availability:**

Before presenting financials, determine which data source is available:

| Situation | Detection | Action |
|---|---|---|
| Normal public company | Has 10-K / 10-Q filings on SEC EDGAR | Use quarterly earnings data |
| Recently IPO'd (<90 days) | Listed date within 90 days of today | Use pre-IPO prospectus (S-1) data |
| No financials available | Private or data not found | State explicitly, skip metrics |

**Step 2 — Present financials based on detected source:**

**If quarterly earnings data exists (normal case):**
1. **Latest Earnings**: Most recent quarterly results — revenue, EPS (actual vs. estimate), YoY growth.
2. **Revenue Trend**: Revenue for the past 4 quarters (show direction — growing/declining).
3. **Profitability**: Gross margin, operating margin, net margin (latest quarter).
4. **Balance Sheet Snapshot**: Total debt, cash on hand, and debt-to-equity ratio.
5. **Free Cash Flow**: Latest annual or trailing twelve months (TTM) FCF figure.

**If recently IPO'd and no quarterly reports yet (pre-IPO fallback):**

> 📋 **数据来源说明 / Data Source Note**: 该公司上市不足90天，以下财务数据均来自
> **IPO招股说明书（S-1文件）**，为上市前经审计历史数据，并非上市后季报。
> *(Company listed within 90 days. Financials sourced from IPO Prospectus (S-1), not post-listing earnings reports.)*

1. **Pre-IPO Revenue**: Most recent full-year revenue from prospectus, with YoY comparison.
2. **Net Loss / Profit**: Full-year net income/loss and trend vs. prior year.
3. **Cash & Liquidity**: Cash on hand, short-term investments, total liquidity pre-IPO.
4. **IPO Proceeds**: Amount raised, intended use of funds.
5. **Burn Rate Warning**: Flag if losses are widening — note ongoing capital raise risk.

Always label the data source clearly at the top of Section D.

> 🔧 Note: When `financial-report-insight` skill is available, delegate full financial comparison to it by calling:
> `/financial-report-insight [TICKER]`

---

### Section E — Global Political Landscape & Geopolitical Impact

Investigate current geopolitical situations and assess their direct or indirect impact
on this company and its industry. Search broadly then narrow to what's relevant.

1. **Relevant Geopolitical Hotspots**: Identify active geopolitical situations (conflicts,
   sanctions, trade disputes, chokepoints) that could affect this company's supply chain,
   revenue, or industry. Examples: Strait of Hormuz for oil; Taiwan Strait for semiconductors;
   Russia-Ukraine for energy & wheat; US-China tariffs for tech.

2. **Direct Company Exposure**: Does this company have operations, suppliers, customers,
   or revenue in affected regions? Quantify if possible (e.g. "X% of revenue from China").

3. **Industry-Wide Impact**: How is the broader industry being affected by current
   geopolitical dynamics? Are competitors more or less exposed?

4. **Policy & Sanctions Risk**: Any relevant export controls, sanctions, government
   restrictions, or subsidy changes (e.g. CHIPS Act, IRA, export bans) that affect
   this company specifically.

5. **Geopolitical Opportunity**: Are there any geopolitical tailwinds? (e.g. defense
   spending increases, friend-shoring trends, energy security drives demand for nuclear)

For each factor, tag its likely impact: 🟢 Tailwind / 🔴 Headwind / 🟡 Watch

Search queries for this section:
- `"[INDUSTRY] geopolitical risk [YEAR]"`
- `"[COMPANY] China exposure supply chain"`
- `"[INDUSTRY] tariff impact [YEAR]"`
- `"[COUNTRY/REGION] [INDUSTRY] sanctions [YEAR]"`

> 🔧 Note: This section is especially critical for: energy, semiconductors, defense,
> agriculture, shipping, rare earth materials, and any company with significant
> international revenue or supply chain exposure.

---

### Section F — Recent Events & Catalysts

Search for events from the **past 1 month** that could affect stock price. Cover:

1. **Earnings / Guidance**: Any recent earnings surprises or forward guidance changes.
2. **Product / Business News**: New product launches, partnerships, contract wins, or losses.
3. **Leadership Changes**: CEO, CFO, or board-level changes.
4. **Legal / Regulatory**: Lawsuits, regulatory investigations, government contracts.
5. **Macro Events**: Tariffs, interest rate decisions, or geopolitical events specifically
   affecting this company.
6. **Insider Activity**: Any notable insider buying or selling (search SEC Form 4 filings).

For each event, note its likely impact: 🟢 Bullish / 🔴 Bearish / 🟡 Neutral

---

### Section G — Competitive Landscape

1. **Direct Competitors**: List 3-5 direct competitors in the same sub-industry.
   For each, provide: ticker, market cap, and a one-line description.
2. **Competitive Position**: How does this company rank in its space? Market share leader,
   challenger, or niche player?
3. **Adjacent Industry Players**: List 2-3 companies in related/adjacent industries that
   overlap or compete indirectly.
4. **Competitive Moat**: Assess the company's competitive advantage (brand, patents,
   network effects, switching costs, cost leadership).

---

## Report Footer

End every report with:

```
---
📊 Report generated by stock-insight | Data sourced via web search
⚠️  This is for informational purposes only, not financial advice.
🔄 Sub-skills pending: industry-insight | founder-insight | financial-report-insight
---
```

Then invite the user to ask follow-up questions:

> *"Report complete. Feel free to ask any follow-up questions — once we're done,
> I'll export the full report including our Q&A to a Markdown file."*

Note: If the user has requested the report in Chinese, translate the above invitation
and the final report accordingly. The SKILL itself always operates in English internally.

---

## Q&A Session & Final Export

After the report is delivered, handle follow-up questions naturally. Each answer should
be concise and directly reference the report sections where relevant.

**Tracking Q&A**: Keep a running record of all questions asked and answers given
during the session. These will be appended to the final exported file.

**Detecting session end**: The session ends when the user:
- Explicitly says they are done (e.g. "ok done", "that's all", "export now", "结束")
- Asks to export or save the report
- Stops asking questions and moves to a new topic

**On session end — export the full report:**

1. Compile the complete document:
   - Full 7-section report (Sections A–G)
   - Report footer
   - All Q&A pairs appended under a `## 问答记录 / Q&A` section

2. Save as a Markdown file using this naming convention:
   ```
   stock-[TICKER]-insight-[YYYYMMDD].md
   ```
   Example: `stock-XE-insight-20260425.md`

3. Determine the output path:
   - Ask the user: *"Where would you like to save the report? (default: `~/workspace/ai/reports`)"*
   - If the user accepts the default or provides no input, use `~/workspace/ai/reports/`.
   - If the user provides a custom path, use that path instead.
   - Create the directory if it does not exist.
   - Save the file to the resolved path and present it to the user.

4. End with a brief summary line, e.g.:
   > *"Full report (including Q&A) exported: `stock-XE-insight-20260425.md`"*
   > Note: Translate this message if the session was conducted in another language.

---

## Search Strategy

For each section, use targeted web searches. Recommended query patterns:

| Section | Search Queries |
|---|---|
| A - Industry | `"[SECTOR] sector performance 2025"`, `"[SUB-INDUSTRY] outlook Q2 2025"` |
| B - Background | `"[COMPANY] founded history"`, `"[TICKER] CEO leadership team"` |
| C - Performance | `"[TICKER] stock price 6 months"`, `"[TICKER] analyst price target 2025"` |
| D - Financials | `"[TICKER] earnings Q1 2025"`, `"[TICKER] revenue margin TTM"` |
| E - Geopolitics | `"[INDUSTRY] geopolitical risk 2025"`, `"[COMPANY] China exposure"`, `"[REGION] [INDUSTRY] sanctions"` |
| F - Events | `"[COMPANY] news April 2025"`, `"[TICKER] insider trading SEC Form 4"` |
| G - Competitors | `"[COMPANY] competitors [SECTOR]"`, `"[TICKER] market share [INDUSTRY]"` |

Use `web_fetch` to retrieve full articles when search snippets are insufficient.

---

## Quality Rules

- Always cite sources inline using `(Source: [outlet])` after key data points.
- Never fabricate prices, earnings figures, or executive names — search for them.
- If a figure is older than 90 days, flag it with ⚠️ (may be outdated).
- Keep each section concise but complete — aim for 150-250 words per section.
- Use 🟢 🔴 🟡 emoji signals where appropriate to aid quick scanning.
