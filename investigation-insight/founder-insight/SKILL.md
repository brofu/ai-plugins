---
name: founder-insight
description: >
  Deep-dive founder and leadership investigation skill. Use this when a user wants
  detailed background on a company's founders, CEO, or key executives. Also called
  automatically by stock-insight (Section B). Triggers on phrases like "tell me about
  the founder of [COMPANY]", "who is the CEO of [TICKER]", "background on [PERSON]",
  "founder profile of [NAME]", "leadership deep-dive on [COMPANY]",
  or when stock-insight delegates founder research.
status: stable
parent: stock-insight
---

# founder-insight

A structured investigation skill that takes a person's name and their associated
company as input and produces a concise 3-section leadership profile.
Can be run standalone or called automatically by `stock-insight` (Section B).

---

## Input

```
/founder-insight [PERSON_NAME] [COMPANY_OR_TICKER]
```

Examples:
- `/founder-insight "Jensen Huang" NVDA`
- `/founder-insight "Elon Musk" TSLA`
- `/founder-insight "Sam Altman" OpenAI`
- `tell me about the founder of Apple` → resolve to "Steve Jobs / Tim Cook", then run this skill

If the user provides only a company name or ticker, identify the founder(s) and/or
current CEO first, then run the profile for the most relevant person.

If multiple founders exist, note all of them but focus the deep-dive on the one
most relevant to the user's question (or the most active/current one).

---

## Output Format

Produce a structured markdown report in chat with the following 3 sections in order.
Use clear `##` headers for each section. At the end, offer to export as a Word or
PDF document using the docx/pdf skills.

---

## Investigation Workflow

> 📋 Before generating any output, read and apply the shared plugin rules at `../rules.md`.
> Pay special attention to **Rule 2 (Citation & Data Integrity)** — source hierarchy,
> no-data policy, and conflict resolution all apply to every section below.

Work through these 3 sections **in order**, using web search for each. Do not skip
sections. If data is unavailable for a section, note it explicitly rather than omitting
the section header.

---

### Section A — Biographical Overview

Cover the person's foundational background and career journey in one unified section:

1. **Full Name**: Legal name and any commonly used name/alias.
2. **Date & Place of Birth**: Include nationality and citizenship if notable.
3. **Education**: Degrees, institutions, fields of study. Note any notable dropouts
   or non-traditional paths (e.g. "dropped out of Stanford PhD program").
4. **Personal Background**: Family background if publicly known and relevant to their
   leadership story (e.g. immigrant family, self-made background). Focus on what
   shaped their professional identity.
5. **Net Worth**: Current estimated net worth. Cite source and date. Flag with ⚠️
   if estimate is older than 90 days.
6. **Equity Stake**: Approximate ownership % in their primary company. Source from
   SEC filings (proxy statement / DEF 14A) where possible.
7. **Career Timeline**: Trace the professional path chronologically — early roles,
   pre-company positions, how they came to found or join their primary company,
   and any notable board or advisory roles held along the way:
   ```
   [YEAR] — [Role / Event]
   [YEAR] — [Role / Event]
   ...
   ```

---

### Section B — Company Role & Leadership

Consolidate founding story, current role, leadership style, and track record:

1. **Founding Story** *(if founder)*: When, where, and why was the company founded?
   What problem were they solving? Were there co-founders — what happened to them?
   *(Skip if not a founder — start from current role.)*
2. **Current Title & Tenure**: Current role, when they assumed it, how long held.
   Do they also chair the board? Do they hold dual-class voting control?
3. **Compensation & Equity**: Most recent total compensation package and equity stake
   value. Source from SEC proxy filings (DEF 14A).
4. **Leadership Style & Principles**: How do they run the company? Any publicly stated
   operating principles or management philosophy. Cite speeches or interviews.
5. **Track Record**: Key financial or operational growth metrics from when they
   joined/founded vs. today. 2-3 landmark products, deals, or initiatives they
   championed. Note any significant failed bets — be factual and balanced.
6. **Succession**: Any known succession plan or public speculation about their tenure.

---

### Section C — Reputation in Industry

Combine controversies, legal history, public presence, and network perception:

1. **Controversies & Legal History**: Any lawsuits, SEC investigations, regulatory
   issues, or significant public controversies naming this person. For each, include
   status (pending/settled/dismissed) and outcome. Tag severity:
   🔴 Significant / 🟡 Notable / ⚪ Minor.
   If none found, state: `No significant controversies found as of [DATE].`
2. **Public Presence**: Notable interviews, podcasts, keynotes, or books. Are they
   active on social media — and what do they post about?
3. **Industry Standing**: How is this person perceived by investors, peers, and
   employees? Cross-reference analyst commentary, employee reviews (Glassdoor/Blind),
   and press tone. Are they widely trusted, controversial, or polarizing?
4. **Key Network**: Notable investors who back them, mentors they've cited,
   influential peers, and any philanthropic or policy activity worth noting.

---

## Report Footer

End every report with:

```
---
👤 Report generated by founder-insight | Data sourced via web search
⚠️  This is for informational purposes only, not financial advice.
📎 Part of the investigation-insight plugin | Parent skill: stock-insight (Section B)
---
```

Then apply the shared plugin disclaimer from `../rules.md` Rule 3.

Then invite the user to ask follow-up questions:

> *"Profile complete. Feel free to ask any follow-up questions — once we're done,
> I'll export the full profile including our Q&A to a Markdown file."*

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
   - Full 3-section profile (Sections A–C)
   - Report footer
   - All Q&A pairs appended under a `## 问答记录 / Q&A` section

2. Save as a Markdown file using this naming convention:
   ```
   founder-[LASTNAME]-[COMPANY]-insight-[YYYYMMDD].md
   ```
   Example: `founder-huang-nvda-insight-20260425.md`

3. Determine the output path:
   - Ask the user: *"Where would you like to save the profile? (default: `~/workspace/ai/reports`)"*
   - If the user accepts the default or provides no input, use `~/workspace/ai/reports/`.
   - If the user provides a custom path, use that path instead.
   - Create the directory if it does not exist.
   - Save the file to the resolved path and present it to the user.

4. End with a brief summary line, e.g.:
   > *"Full profile (including Q&A) exported: `founder-huang-nvda-insight-20260425.md`"*
   > Note: Translate this message if the session was conducted in another language.

---

## Search Strategy

For each section, use targeted web searches. Recommended query patterns:

| Section | Search Queries |
|---|---|
| A - Biography & Career | `"[NAME] biography early life"`, `"[NAME] net worth [YEAR]"`, `"[NAME] equity stake [COMPANY] proxy"`, `"[NAME] career before [COMPANY]"`, `"[NAME] work history"` |
| B - Role & Leadership | `"[COMPANY] founding story [NAME]"`, `"[NAME] CEO tenure compensation SEC proxy"`, `"[NAME] management style interview"`, `"[COMPANY] growth under [NAME]"` |
| C - Reputation | `"[NAME] lawsuit controversy [YEAR]"`, `"[NAME] SEC investigation"`, `"[NAME] interview podcast"`, `"[COMPANY] glassdoor [NAME]"`, `"[NAME] philanthropy network"` |

Use `web_fetch` to retrieve full articles when search snippets are insufficient.
For equity and compensation data, prefer direct SEC EDGAR lookups:
`https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&company=[COMPANY]&type=DEF+14A`

---

## Quality Rules

- Always cite sources inline using `(Source: [outlet, date])` after key data points.
- Never fabricate names, dates, net worth figures, or legal outcomes — search for them.
- If a figure is older than 90 days, flag it with ⚠️ (may be outdated).
- Keep each section concise but complete — aim for 200-300 words per section.
- For Section C controversies, be factual and balanced — neither downplay nor sensationalize.
- If called by `stock-insight`, return only a **condensed summary** (2-3 sentences per section)
  to keep the parent report readable. Full profile is for standalone use only.
