# Concept Doc Guide

## Purpose

A concept doc exists so **a person can understand a design without reading the design**.

That is the whole job. The design doc is written to be *correct* — exhaustive, precise, normative, and long. The concept doc is written to be *understood* — by a human, in one sitting, mostly by looking at pictures. It is the thing you hand someone who needs the shape before they need the spec.

Two consequences follow, and every rule in this guide comes from one of them:

- **The reader is a human, not an agent.** No downstream agent consumes this doc. Nothing is graded against it. It never gates a stage. If a sentence exists to satisfy a checklist rather than to help a person, cut it.
- **The design stays normative.** The concept doc is illustrative. It explains; it does not decide. On any disagreement the design wins and the concept doc is wrong.

## The three properties, in priority order

When a rule in this guide conflicts with another, resolve it in this order.

1. **Human.** Plain language, short sentences, no unexplained jargon. A reader who has never seen this codebase should follow it. If a sentence only parses once you already know the design, **draw it instead** — rewriting is the move this genre does not have (§ Prose budget).
2. **Visual.** Diagrams carry the concept; prose only connects them. If a section's idea survives with its diagram deleted, that section is prose wearing a diagram's clothes — redraw it or cut it.
3. **Focused.** One angle per section, four to eight sections, nothing exhaustive. Completeness is the design's job. **A concept doc that tries to cover everything has failed at being a concept doc**, even if every line in it is true.

## Prose budget — the rule that keeps this visual

**Diagrams explain. Prose labels.** If you are explaining in sentences, you have not finished the diagram.

| Budget | Limit | Force |
|---|---|---|
| Before a diagram | **≤2 lines** — just enough to make it legible | hard |
| After a diagram | **≤3 lines** — only what the picture cannot carry | hard |
| Longest unbroken prose run | **≤12 lines** | hard |
| Whole doc, prose ÷ fenced | **≤0.5** | **report it; do not fail on it** |
| Any paragraph | **≤3 lines** | hard |
| Whole doc, prose lines | **≤150** | hard — this replaces the old total-line cap |

**When you exceed a budget, the fix is never "write it tighter" — it is redraw.** Move the content into the picture: label the arrow, name the box, add a column, split into before/after panels. Prose that survives the redraw is prose the diagram genuinely cannot hold.

### How to count

- **prose** = non-blank lines outside fences, **excluding the mandated closing section** (it is bullets over zero diagrams by design — counting it penalizes a doc for conforming).
- **fenced** = every line inside a fence, plus the two ``` markers.
- **run** = consecutive non-blank prose lines; a blank line or a fence resets it.

```
awk '/^## [0-9]*\.? *What this deliberately/{stop=1} stop{next}
     /^```/{f=!f;fence++;run=0;next} f{fence++;next}
     NF{prose++;run++;if(run>max)max=run;next} {run=0}
     END{printf "prose %d  fence %d  ratio %.2f  longest run %d\n",prose,fence,prose/fence,max}' <doc>
```

### Where the numbers come from (11 docs, all projects)

Ratios: `0.31 0.34 0.35 0.36 0.38 0.45 0.45 0.49` · **gap** · `0.81 0.81 1.92`. The corpus breaks cleanly — nothing sits between 0.49 and 0.81 — so 0.5 is a real line, not a round number. But **four docs would fail it**, three of which shipped and read acceptably, so it is reported rather than enforced until more docs are drawn under this guide.

Longest runs, measured with the awk above: `7 7 7 8 8 8 9 10 10 11 11`. The maximum in the corpus is **11**, so `≤12` is a guard rail set just above observed practice rather than a break in the data — it binds nothing today and exists to catch drift. (An earlier draft said `≤8`, calibrated on two docs; it would have failed most of the corpus. A still-earlier count showing runs of 23–42 predates the closing-section exclusion in § How to count, which removed exactly those bullet blocks.)

## When to create one

Create a concept doc when a design is **large or unintuitive enough that a reader needs orientation before the spec** — a design that reorganizes something, introduces a boundary people will argue about, or is long enough that nobody will read it cold.

Skip it when the design is short, or its shape is obvious from the title. Most tasks do not need one. This doc is optional and always has been.

## When in the workflow

After a design doc exists, and any time afterward. A concept doc is a companion, not a stage — it does not gate `/dev-plan` and nothing waits on it.

Because it is a snapshot, it goes stale when the design changes. That is expected and is why the header records the size read (see § Shape).

## File naming

`docs/[milestone-slug]-[task-slug]-concept.md` — the design's own path with `-design` replaced by `-concept`.

If the source does not follow that convention, mirror its basename (`<basename>-concept.md`) and say so in the report.

## Size — cap the prose, not the page

**There is no total-line ceiling.** Good diagrams are line-expensive; capping total length caps the diagrams.

**The ceiling is on prose: ~150 prose lines.** Everything else may grow as long as the pictures earn it.

### Why the page-count rule was wrong

An earlier version of this guide capped every doc at 400 total lines. Measured against all eleven concept docs, that rule **fails the four most diagram-dense docs and passes the worst one in the corpus**:

```
 lines  prose  fence  ratio
   404    216    107   2.02  ← the wall-of-text doc — PASSES a 400-line cap
   476    122    251   0.49  ← fails it
   509    122    270   0.45  ← fails it
   531    117    307   0.38  ← fails it, and has the second-best ratio in the corpus
   670    183    403   0.45  ← fails it
```

Total length tracks how much was **drawn**. Prose length tracks how much was **explained in sentences** — which is the thing this genre is trying to keep small. Prose is also far more stable across the corpus (**70–205 lines, median 117**) than total length (295–670) — a 2.9× spread against 2.3×, and the prose spread has a single outlier where the length spread has none.

So: draw as much as the subject needs. Write as little as the drawings allow.

If a doc is long because the *subject* is large, that is fine. If it is long because you are still explaining, the prose budget will say so.

> **Still true:** a longer design does not earn a longer companion, and design length is not a cap. If your draft is running longer than the design, do not cut to match it — ask whether the doc should exist at all (§ When to create one). Never cap against a *short* design either: the mandated shape — header, thesis, four diagram-bearing sections, closing — costs roughly ninety lines before any content, so that cap would demand a doc shorter than a conforming one can be, and the author would resolve it by drawing worse diagrams.

## Shape

1. **H1** — `<Subject> — concept`
2. **Header table** — `Created` (run `date "+%Y-%m-%d"`, never guess), `Status`, `Subject`, `Origin`, `Illustrates`. Add a `Decisions` row only when decisions are recorded (attribute each: who, when). There is no `Consumer` row — nothing downstream consumes this doc.
   - `Status` **must** mark the doc CONCEPT, say **not normative**, and name the doc that is.
   - `Illustrates` records the design's path **and the line count as read** (e.g. `docs/core-foo-design.md @ 1055 lines`). A recorded size that no longer matches the source marks the doc as predating a change. Nothing checks this automatically — it is an aid for a person inspecting the doc, not detection the system performs.
3. **Thesis** — the design compressed to one to three sentences, core in **bold**. Write it first. If you cannot write it, you do not understand the design well enough to illustrate it; say so instead of padding.
4. `---`
5. **Numbered sections** — `## 1. <the angle>`, one angle each, four to eight total. Every one carries **at least one diagram**. Reach the diagram fast: frame in ≤2 lines, draw, then add only what the picture cannot carry (§ Prose budget).
   Angles that recur: the gap this closes · end-to-end flow · where each piece lives · the fork worth staring at · what it costs · decisions already made.
6. **Closing section** — `## N. What this deliberately does not do`, as bullets. This is the one section with **no diagram**; boundaries read better as a list.

## Diagrams

- **ASCII only. Never mermaid.** Plain fenced blocks, box-and-line drawings. Side-by-side comparison blocks (before/after, exists/missing) are the genre's most-used and most-effective form.
- **Width ≤100 characters** inside a fence. **Measure characters, not bytes** — box-drawing glyphs and em-dashes are multi-byte, and a byte count overstates width by roughly 3×, which will send you cutting a diagram that was never too wide.
- **A section you cannot draw is a signal the angle is not distinct enough** — merge it or cut it. Do not manufacture a diagram to satisfy the rule; an empty box diagram is worse than honest prose.

## How to draft

1. **Read the design in full**, plus any supporting inputs. `wc -l` it — that is the read-size for the header (the ceiling is flat, not derived from it).
2. **Input-staleness pass** — check the design's claims against its own *cited sources*, not only against the design body. A premise that is merely out of date is internally consistent by construction, so reading the design against itself will never surface it.
3. **Flag self-contradiction** as you compress — two sections naming different counts, a question parked open in one place and asserted settled in another, a rule whose stated scope excludes a case it later covers. Compression surfaces these naturally. Report both kinds; **reconcile neither**.
4. **Write the thesis.** It is the test of whether you have the design.
5. **Choose the angles** — four to eight, each genuinely distinct. Name each as a question a reader would actually ask.
6. **Draw first, then write.** For each angle, draw the diagram, then add only the framing and connective prose the diagram cannot carry. Writing prose first produces prose with a decorative picture under it.
7. **Cut to the ceiling**, then report.

## Best Practices

- **Write for someone who will read this once.** They will not re-read to resolve an ambiguity; they will give up.
- **Name things the way the design names them.** Inventing friendlier vocabulary strands the reader when they open the design.
- **Show open questions as open** — draw the fork. A concept doc that quietly picks an answer converts an unresolved question into apparent fact, and a diagram reads as settled far more strongly than a sentence does.
- **Attribute recorded decisions** (who, when). A decision without its trigger cannot be re-judged later.

## Common Pitfalls

- **Second-spec creep** — the doc grows toward completeness and stops being an orientation aid. The ceiling exists to catch this.
- **Decorative diagrams** — a picture that repeats the paragraph above it. The test: delete the prose; does the diagram still teach? Delete the diagram; does the section still work? Only the first should be survivable.
- **Manufactured content** — an angle not present in the source material. Invention is worse here than in prose, because a diagram reads as settled fact.
- **Silently fixing the design** — drawing the version you believe is right hides a real defect. Report it and illustrate what the design actually says.
- **Jargon inherited unexamined** — a term the design defines forty pages in, used here on page one with no gloss.
- **Byte-counting fence width** — see § Diagrams. It reports roughly 3× the true width on box-drawing diagrams.

## Verification Checklist

**Shape**
- [ ] H1 is `<Subject> — concept`
- [ ] Header table has `Created` (via `date`), `Status` (marks CONCEPT + not normative + names the normative doc), `Subject`, `Origin`, `Illustrates` (path **and** read line count)
- [ ] Thesis present, one to three sentences, core bolded
- [ ] Four to eight numbered sections, one angle each
- [ ] Closing `## N. What this deliberately does not do` present, as bullets
- [ ] No status metadata beyond the `Status` row

**Visual**
- [ ] Every numbered section except the closing one carries at least one diagram
- [ ] Zero mermaid; all diagrams ASCII in plain fenced blocks
- [ ] No in-fence line exceeds 100 **characters** (measured as characters, not bytes)

**Human**
- [ ] **≤150 prose lines** (total length is uncapped — diagrams may take the space they need)
- [ ] Every term the design defines is glossed on first use here (a mechanical stand-in for "a new reader can follow it", which the author is the worst-placed person to judge)
- [ ] Every diagram teaches something the prose does not — apply the § Common Pitfalls test: delete the prose, does the diagram still teach? delete the diagram, does the section still work? Only the first may survive
- [ ] **Prose budget held** (§ Prose budget): ≤2 before a diagram, ≤3 after, no run over 12 — and the ratio computed and reported, whatever it is
- [ ] No paragraph longer than three lines

**Honesty**
- [ ] Input-staleness pass run against the design's cited sources
- [ ] Self-contradiction in the design flagged, not reconciled
- [ ] Open questions shown as open, with the fork drawn
- [ ] Nothing in a diagram that is not in the source material

## Cross-references

- Normative twin: `docs/[milestone-slug]-[task-slug]-design.md` (`1-design-guide.md`)
- Template: `assets/templates/concept.md`
- Agent: `dev-concept-author` — spawn by `subagent_type` for background authoring
- Command: `/dev-concept`

## Next Stage

None. A concept doc is a companion — nothing waits on it. Return to whatever stage the design was headed for.
