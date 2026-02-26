# Naming Research

## Goal
Research and evaluate product/project name candidates across brand strength, namespace cleanliness, trademark risk, semantic clarity, and scalability. Produce a ranked recommendation with a confirmed winner.

## Code Allowed
NO

## Timeline Estimates
NOT NEEDED - Focus on research quality, not speed.

## Input
- **Required**: Project description (what the product does, target audience, key differentiators)
- **Optional**: Vision artifact — provides problem statement, value proposition, and target user context
- **Optional**: Architecture artifact — provides technical surface area (CLI names, import names, API endpoints, MCP server names)
- **Optional**: Candidate names to evaluate (if user already has ideas)
- **Optional**: Naming constraints (e.g., "must work as Python import", "hosted under creational.ai", "max 8 characters")

## Process

### 1. Gather Context

Read available design artifacts to understand:
- What the product does (from vision or user notes)
- Technical surfaces where the name appears (from architecture or user notes): CLI commands, import statements, MCP server names, URLs, SaaS branding, pricing tiers
- Target audience (developers? non-technical users? both?)
- Parent brand context (standalone domain? hosted under org umbrella like `creational.ai/[name]`?)

### 2. Define Evaluation Criteria

Use these 7 criteria, weighted in this order (adjust weights if user specifies different priorities):

| # | Criterion | Weight | What It Measures |
|---|-----------|--------|------------------|
| 1 | Brand strength | 1st | Distinctiveness, memorability, pronounceability, visual identity |
| 2 | Semantic clarity | 2nd | Does the name communicate what the product does to the target audience? |
| 3 | Scalability | 3rd | Can the name grow with the product beyond its initial scope? |
| 4 | Namespace cleanliness | 4th | PyPI, npm, GitHub org/repo, crates.io — is the software namespace available? |
| 5 | Trademark cleanliness | 5th | Are there existing companies, registered trademarks, or funded entities using this name in the same or adjacent industry? |
| 6 | SEO potential | 6th | Can you rank for this name? Or is it a common word / dominated by incumbents? |
| 7 | CLI/import ergonomics | 7th | Does it work as `import [name]`, `[name] --help`, `[name]-mcp`? Length, typing ease, no hyphens in awkward places |

If the product is hosted under a parent domain (e.g., `creational.ai/[name]`), domain availability is NOT a criterion — replace it with namespace cleanliness. Note this in the report.

### 3. Generate Candidates

If the user provides candidates, use those. Otherwise, generate 10-15 candidates using these strategies:

- **Portmanteau**: Combine key concept words (e.g., "ad" + "mediation" → "admedi")
- **Truncation**: Shorten a descriptive term (e.g., "mediation" → "medio")
- **Suffix patterns**: Modern SaaS suffixes (-ly, -ify, -io, -hub, -kit, -flow)
- **Metaphor**: Names that evoke what the product does without describing it literally
- **Compound**: Two short words joined (e.g., "tiersync", "adflow")

Aim for 6-8 characters. Shorter is better for CLI/import. Avoid names that are common English words.

### 4. Research Each Candidate

For EVERY candidate, research these in order. Be thorough — a name that looks clean on first glance may have fatal conflicts buried in search results.

**a. Software namespace check:**
- PyPI: Search `https://pypi.org/project/[name]/`
- npm: Search `https://www.npmjs.com/package/[name]`
- GitHub: Search for org `github.com/[name]` and repo `github.com/[name]/[name]`
- Any other relevant registries for the project's tech stack

**b. Trademark and company search:**
- Search: `"[name]" company` and `"[name]" trademark`
- Search: `"[name]" software` and `"[name]" [industry term]`
- Look for: funded startups, acquisitions, registered trademarks (especially ® symbols), companies with employees and revenue
- Check LinkedIn company pages if search results suggest active companies

**c. Domain status** (only if standalone domain needed):
- Check .com, .io, .dev, .ai availability
- Note if domains are parked, active, or NXDOMAIN

**d. SEO landscape:**
- Search the bare name — what dominates results?
- Is it a common English word? A medical/legal term? A popular library?
- Would search results for `[name] docs` or `[name] tutorial` be findable?

**e. Phonetic and visual check:**
- Could it be confused with another word verbally? (e.g., "admedly" → "admittedly")
- Is it easy to spell after hearing it once?
- Does it look distinct in written form?

### 5. Eliminate Candidates

A candidate is eliminated if ANY of these are true:
- **Registered trademark** (®) in the same or adjacent industry
- **Funded company** ($1M+) using the exact name in a related space
- **Major acquisition** involving the name (e.g., Nielsen acquiring "AdIntel")
- **Active, established company** (50+ employees) using the name
- **PyPI/npm package taken** by an active, maintained library in a related domain
- **Common English word** that can never be owned in search results
- **GitHub org taken** by an active project (not a dead single-commit repo)

Document WHY each candidate was eliminated. The graveyard section is as valuable as the recommendation — it shows the research was thorough and prevents revisiting dead names.

### 6. Score Survivors

For candidates that survive elimination, score each on the 7 criteria using a 5-star scale:

```
★☆☆☆☆ = Fatal or near-fatal weakness
★★☆☆☆ = Significant concern
★★★☆☆ = Acceptable, some concerns
★★★★☆ = Strong
★★★★★ = Excellent, no concerns
```

Half stars (★★★½☆) are allowed for nuance.

Calculate a weighted total (1-5 scale) based on criterion weights.

### 7. Write the Report

Follow the template exactly. The report structure is:
1. Verdict (confirmed winner + one-paragraph summary)
2. Graveyard (eliminated candidates with reasons)
3. Survivors ranked (detailed findings per survivor, #1 through #N)
4. Evaluation matrix (scoring table)
5. Surface examples (what the name looks like in practice)
6. Umbrella analysis (if hosted under parent brand — does it change the ranking?)
7. Next steps (trademark search, domain registration, repo rename, etc.)

## Output
`naming-research.md` artifact using `assets/templates/naming-research.md`

Example: `naming-research.md`

## Verification Checklist
- [ ] Template read from `assets/templates/naming-research.md`
- [ ] Artifact follows template structure exactly
- [ ] Vision artifact referenced (if available) for context
- [ ] Architecture artifact referenced (if available) for technical surfaces
- [ ] At least 10 candidates evaluated (user-provided + generated)
- [ ] Every eliminated candidate has a documented reason
- [ ] Every survivor has verified findings (not assumptions)
- [ ] Web search used for trademark/company/namespace checks (not guessed)
- [ ] Evaluation matrix uses consistent scoring
- [ ] Surface examples show how the name works in practice
- [ ] Next steps are actionable
- [ ] No code in the output

## Common Pitfalls
- Falling in love with a name before researching it — research first, then judge
- Shallow search (one query per name) — use multiple search queries per candidate
- Treating a parked domain as "available" — it's registered, even if unused
- Ignoring phonetic confusion — names are spoken in meetings, podcasts, and standups
- Assuming a small company is harmless — a 10-person company with a trademark can still send a C&D
- Not checking the actual PyPI/npm page — search results may be stale

## Next Stage
→ No fixed next stage. Naming research can be run at any point during design (typically after Vision or Architecture). The confirmed name feeds into all subsequent design artifacts.
