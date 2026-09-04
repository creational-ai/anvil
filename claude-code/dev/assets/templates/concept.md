# [Subject] — concept

| | |
|---|---|
| **Created** | [run `date "+%Y-%m-%d"` — never guess] |
| **Status** | CONCEPT — illustrative, **not normative**. `docs/[milestone-slug]-[task-slug]-design.md` is normative; nothing here overrides it. |
| **Subject** | [what this is, in one line — the module, mechanism, or change being illustrated] |
| **Origin** | [where this came from — the proposal, the observed defect, the prior shape it replaces] |
| **Illustrates** | `docs/[milestone-slug]-[task-slug]-design.md` @ [N] lines *(size as read — a mismatch with the current design means this doc predates a change)* |
| **Decisions** | [OPTIONAL — omit this row unless decisions are recorded. Attribute each: who, when.] |

[Thesis — one to three sentences, core in **bold**. Write it first; if you cannot, you do not understand the design well enough to illustrate it yet.]

---

## 1. [The angle, as a question a reader would actually ask]

[MAX 2 LINES. Only what makes the diagram legible. Not the idea — the diagram carries that.]

```
        BEFORE                                   AFTER
┌─────────────────────────┐              ┌─────────────────────────┐
│ [what exists today]     │ ──migrate──▶ │ [what replaces it]      │
│ [its cost, quantified]  │   (one-way)  │ [what that cost becomes]│
└─────────────────────────┘              └─────────────────────────┘
```

[MAX 3 LINES. Only what the picture cannot hold. Over budget? Redraw — label the arrow, name the box,
add a column — do not write tighter prose.]

## 2. [Next angle, also as a question]

[≤2 lines.]

```
  caller            module                    store
    │                 │                         │
    ├── Request() ───▶│                         │
    │                 ├─── open page ──────────▶│
    │                 │                         │
    │◀── Result ──────┤   (never blocks)        │
```

[≤3 lines.]

## 3. [Next angle]

[≤2 lines.]

```
┌──────────────────────────────────────────────┐
│ CONSUMER          owns: policy, persistence  │
├──────────────────────────────────────────────┤
│ MODULE            owns: the call, the handoff│
├──────────────────────────────────────────────┤
│ PLATFORM          owns: nothing we control   │
└──────────────────────────────────────────────┘
   ▲ the seam worth staring at ───────┘
```

[≤3 lines.]

<!-- 4-8 sections total, each with >=1 diagram, each heading phrased as a question.

     THREE ARCHETYPES ARE SHOWN ABOVE — reuse the one that fits the angle, do not reuse one shape
     for every angle:
       1. side-by-side  — before/after, exists/missing, option A vs B
       2. sequence      — who calls whom, in what order, what comes back
       3. layering      — where each piece lives, who owns what, where the seam is
     Others worth drawing: a branch/fork (decision with both paths drawn), a cost table.

     PROSE BUDGET — the guide's § Prose budget sets every limit; compute the ratio with the awk
     one-liner there and report it. Local rule you can hold while writing: <=2 lines before a
     diagram, <=3 after, no paragraph over 3 lines. If a thought needs more, it is a diagram you
     have not drawn yet.

     LABEL THE ARROWS. An unlabeled arrow is a sentence you are about to write below the diagram. -->

## N. What this deliberately does not do

[Bullets only. The one section with no diagram.]

- **[Thing it does not do]** — [why that is the right call, not an omission]
- **[Thing deferred]** — [what would have to be true to revisit it]
- **[Question left open]** — [stated as open; never quietly resolved here]
