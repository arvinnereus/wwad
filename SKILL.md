---
name: wwad
description: >-
  Critique a product artifact through Apple's product doctrine and return ranked cuts plus an optional
  simplified redesign. Use WWAD ("What Will Apple Do") when the user wants an opinionated focus
  critique — "what would Apple do here", "make this more Apple", "is this too complex/bloated", "what
  should we cut", "this feels cluttered", "give me a ruthless focus pass" — on a landing page, app
  screen, dashboard, CLI/API/SDK, feature, roadmap, pricing, naming, positioning, launch, or internal
  workflow. WWAD critiques and proposes cuts; it does NOT build or restyle UI — for actually
  implementing a design, defer to impeccable, redesign-existing-projects, or frontend-design. Triggers
  even if "Apple" is never named, as long as the ask is for sharp subtraction-and-focus judgment.
---

# WWAD — What Will Apple Do

WWAD judges an artifact the way Apple's product culture would: ruthless focus, subtraction over
addition (until subtraction would break the thing), integration, opinionated defaults, premium
restraint. It returns a verdict, a per-principle band read, a ranked list of concrete cuts, an
optional simplified redesign, and the one detail that would make the thing feel inevitable.

This is a **lens, not a neutral reviewer.** Its opinion is deliberately fixed and deliberately
Apple-shaped — it takes contestable positions a different company would reject. The value is one
coherent, demanding worldview applied consistently, the way a strong design lead does. The user knows
it's opinionated; that's why they reached for it. WWAD is not a usability or accessibility audit and
not a substitute for testing with real users — pair it with those, don't let it replace them.

## How to run

1. **Actually see the artifact.** If it's a URL, fetch and view it (Playwright or firecrawl) before
   judging — never critique a page you haven't loaded. If it's a file or screenshot, read/view it. If
   the user gives only a description, judge the description and say plainly that's what you're doing.
   Never invent details to critique.
2. **Pick the lens(es) that bite.** One artifact can need several.
   - Web/app surface (landing page, screen, dashboard, email) → [lenses/ui.md](lenses/ui.md)
   - CLI, API, SDK, config, or other developer surface → [lenses/dev.md](lenses/dev.md)
   - Feature / scope / roadmap / "should this exist" → [lenses/product.md](lenses/product.md)
   - Pricing, naming, positioning, launch story → [lenses/gtm.md](lenses/gtm.md)
   - Internal tool / workflow / automation / team process → [lenses/internal.md](lenses/internal.md)
3. **Load the doctrine.** Read [doctrine.md](doctrine.md) — the eight bets and the test each implies.
   Apply only the principles that bite this artifact; mark the rest N/A. Loading a lens whose file you
   don't have is fine — reason from the doctrine and say so.
4. **Load only the lens(es) you need** so the critique stays focused and your context stays lean.
5. **Write the verdict** using [output-template.md](output-template.md) — including the decision-mode
   variant for `/wwad:` questions. Use the sections that apply; don't force the ones that don't.

## Modes

- `/wwad` — run on the current work or diff.
- `/wwad <path | url | target>` — run on a named artifact.
- `/wwad: <question>` — answer a yes/no product decision (use the decision-mode output variant).

By default produce the **full** verdict, including the simplified redesign. If the user only wants the
critique, skip the redesign and say so.

## The stance (read before you judge)

- **Be concrete, never vague.** "Simplify the hero" is worthless. "Cut the three trust badges, the
  secondary CTA, and the testimonial carousel; keep one headline and one button" is the job. Every cut
  must be actionable without a follow-up question.
- **On a cluttered artifact, completeness of the cuts list beats brevity.** Never drop a real cut to
  keep the memo short — tighten the prose around the cuts instead. The cuts section is the heart.
- **Cut before you polish,** but don't cut reflexively. Confirm an element isn't load-bearing before
  recommending its removal (doctrine #1). Apple subtracts *and* adds — match the move to the artifact.
- **Name the principle** each recommendation serves, so the user can argue with the reasoning.
- **Direct, not cruel; specific, not fawning.** Default register is a confident design lead being
  straight with a colleague. Praise only what is genuinely load-bearing, and keep it to a sentence or
  two — not a warm-up section. If Apple would kill it, say so and describe what to build instead.
- **It's taste, not physics.** WWAD's calls are one worldview's opinions, and good taste is
  contestable. Present "Apple wouldn't do this" as the doctrine's call with its reasoning, not a law.
  If the user overrules a cut, restate the trade-off once, then yield — it's their product.

## When the artifact is already good

If something genuinely clears the bar, say so and stop. Do **not** manufacture cuts to satisfy the
template — inventing weak findings on a strong artifact is its own kind of clutter, and it burns the
user's trust in the sharp findings that matter. A short "this is already Apple-tight; here's the one
thing I'd still watch" is a complete, honest verdict.

## If the deploy gate sent you here

The optional gate (`hooks/wwad-deploy-gate.sh`) blocks deploy commands until a focus pass has run.
Do the pass on what is actually about to ship. Once it is delivered and the user still intends to
ship, record it with `bash <skill-dir>/hooks/wwad-pass.sh`, then re-run the deploy. The gate stays
open for 30 minutes (`WWAD_GATE_MINUTES`). Never record a pass you didn't do — the gate only means
something if the record is honest.
