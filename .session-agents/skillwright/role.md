<!-- Empty overlay — inherits the skill baseline at ~/.claude/skills/session-agents/references/roles/skillwright.md.
     This whole file is HTML comments, so it composes as a no-op: an empty / all-comment overlay
     means "skill default alone" (the comms composer is comment-aware — headings inside comments
     never declare sections). Delete these comments and write real content to tailor the role
     (e.g. this project's command-naming pattern, where its skills deploy from, its
     component-review ritual).

     GRAMMAR CHEAT-SHEET (uncomment a heading + its lines to use it; the marker controls the fold):
       ## Responsibilities : base   →  EXTEND — the inherited section stays, your lines append
       ## Boundaries                →  REPLACE — your content substitutes the inherited section
       ## Rules                     →  (bare heading, empty body) DELETE the inherited section
       (a section you omit entirely →  passes through from the baseline unchanged)
     Canonical sections: Responsibilities / Boundaries / Rules / Anti-patterns.
     Preview before launch:  comms compose skillwright

     Example — delete the comment wrappers to activate:
       ## Rules : base
       - Skills deploy from claude-code/; every shared change is canon-verified then deployed
-->
