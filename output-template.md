# Output Template

Two shapes: **artifact mode** (default — reviewing a thing) and **decision mode** (`/wwad:` — resolving
a question). Use the sections that apply to the artifact in front of you; don't force the ones that
don't. Keep it tight — this is a sharp memo, not an essay. Match length to the artifact: a cluttered
landing page earns a screenful; a naming call earns five sentences.

---

## Artifact mode (default)

```markdown
# WWAD — <artifact name>

**Verdict:** <one line — exactly one of:>
- ✅ Apple ships this. <what to leave alone>
- ✂️ Apple ships it after these cuts. <light trimming, product & execution are sound>
- 🔁 Right idea, wrong execution — rebuild <the surface> before shipping. <the concept is sound but
  this version isn't there; the cuts amount to a rebuild, not a trim>
- ❌ Apple kills this and builds <one-line alternative> instead.
- ⚠️ Can't judge from a description — I'd need <the URL / a screenshot / the actual artifact>. <use ONLY
  when the description is genuinely too thin to support any honest finding. If you can judge it, judge it
  and label it a description-based read (per SKILL.md step 1) — don't refuse just because it isn't live.>

**Band read** (only the principles that bite this artifact; mark the rest N/A and omit them)
| Principle | Band |
|---|---|
| <principle name> | Strong / Hedging / Broken |
| ... | ... |
<Strong = Apple would claim it. Hedging = the instinct's there but it's covering its bets (most
leverage). Broken = actively against the principle (fix first). The Broken/Hedging rows and your top
cuts should name the same problems.>

## What it gets right
<One or two sentences, only if genuinely load-bearing. Not a section to fill — if there's little worth
saying, say little. Earn the critique, don't perform warmth.>

## The cuts (ranked, highest leverage first)
1. **<concrete change>** — <why; name the principle it serves>
2. **<concrete change>** — <why; principle>
3. ...
<Each cut specific enough to act on without a follow-up. Lead with removals — but confirm an element
isn't load-bearing before cutting it (doctrine #1). On a cluttered artifact, completeness wins over
brevity: don't drop a real cut to stay short. If the artifact is already strong, say so and stop — do
NOT manufacture cuts to fill this section.>

## The redesign
<The simplified version made real, at the artifact's altitude: revised copy, a concretely-described
tightened layout, the cut feature list, the simplified pricing table, the new name options. Show, don't
describe. Omit (and say so) if the user asked for critique only.>

## The one more thing
<The single detail or moment that would make this feel inevitable — one paragraph. Omit for artifacts
that have no demo moment (an internal cron, a config file); forcing one produces filler. When it
applies, this is the gift that makes the whole verdict worth reading.>
```

---

## Decision mode (`/wwad:` questions)

A yes/no or A-or-B question has nothing built to "cut" and nothing to "redesign," so those sections
strain. Use this shape instead. The doctrine and the relevant lens still drive the reasoning — only the
output structure changes.

```markdown
# WWAD — <the decision, as a question>

**The call:** <one line — the recommendation. Name the option plainly, including "neither — here's the
third option" when the question is a false binary. e.g. "Ship with no settings screen — but keep sync
and export as invisible behavior, not toggles.">

**Where the leverage is** <2–4 sentences instead of a band table: which principles decide this and
which way they point. A score table is theater for a decision — don't use one.>

## Each option, honestly
<Brief: the strongest case for and against each option on the table, so the user sees the trade you're
making — not just your conclusion.>

## What to build, what to refuse
<The decision-mode equivalent of "the cuts": a ranked list of concrete calls — build this, refuse that,
default to this — each naming the principle behind it.>

## What shipping this looks like
<Optional, kept short: a few concrete lines on the recommended path made real. Don't over-specify a
product the user hasn't asked you to design — this is illustration, not a spec.>

## The one more thing
<Most decisions have no demo moment — omit this section unless there's a genuinely inevitable-making
moment to name. Don't reach for filler on a yes/no call.>
```

---

## Notes

- **Bands, not numbers.** Never score 0–10 — there are no anchors and two runs wouldn't agree. The
  three bands are reproducible and honest about the method's precision.
- **The cuts / "what to build" section is the heart.** Vague entries mean you haven't looked hard
  enough at the actual artifact — go back and get specific.
- **Stay in voice.** Confident design lead being straight with a colleague: direct, specific,
  respectful, never cruel and never fawning.
