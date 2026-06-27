# The Doctrine

Eight principles. Each one is a *contestable Apple bet* — a position Apple takes that a reasonable
competitor rejects — not a generic "less is more" platitude. That distinction is the whole point: if a
finding could come from any tasteful consultant, it isn't WWAD. Push every judgment to the place where
Apple's choice is genuinely different from the industry default, and say what the bet costs.

Each principle comes with the test it implies. The principles are the *why*; the tests are the *how*.

**Apply only the principles that actually bite this artifact. Mark the rest N/A and move on.** Judging
everything against all eight, including the ones that don't apply, is itself the unfocused checklist
behavior principle #2 condemns. A CLI tool has no "launch moment"; an internal cron has no "premium
restraint." Don't manufacture a finding to fill a slot.

---

## 1. Subtract until it breaks — then stop

The Apple bet, and where it differs: Apple removes what the entire industry calls mandatory — the
hardware keyboard, the floppy, the optical drive, the headphone jack — and eats the short-term outrage
because it's betting on where things are going. But this is **not** minimalism for its own sake. Apple
also *adds* with conviction when the addition is the product: the Dynamic Island, the dense pro
surfaces of Logic and Final Cut, even the Apple Pencil — which reversed Jobs' own "who wants a stylus?"
line once the addition genuinely served the work. The discipline is knowing the difference.

**Test:** Cut until removing one more thing would break the core job — that point is the target, not
"as little as possible." Before cutting any element, confirm it isn't load-bearing for the one thing
the artifact exists to do. Over-cutting a tool that *should* be rich (a pro app, a data-dense
dashboard) is the same failure as clutter, pointed the other way.

## 2. Say no to a thousand things — especially the good ones

The Apple bet: focus isn't killing bad ideas, it's killing *good* ones that don't serve the single
thing. Jobs cut Apple's product line to four quadrants — killing dozens of shipping products and the catalog complexity that came with them — so the lineup was something a customer could grasp in one glance. The
cost is real — you turn down customers and features that would genuinely sell — and Apple pays it on
purpose.

**Test:** Name the ONE thing this must do flawlessly. Then find a genuinely *good* feature here that
doesn't serve it, and recommend killing that one — proving the focus is real and not just rhetoric. If
you can't name the one thing, that's the first finding.

## 3. Own the whole stack; integrate where others bolt together

The Apple bet, and its sharpest edge against the industry: vertical integration over modularity. Chip,
OS, device, store, services — one company, because the seams between vendors are where experiences turn
to glue and tape. The open-and-modular camp calls this control a vice; Apple calls it the product.

**Test:** Trace the experience end to end. Where does it hand off to something the team doesn't control
— a third-party widget, an external checkout, an off-page link, a manual step between two tools — and
does quality visibly drop at that seam? Either bring the seam inside the tent or design it so the user
never feels the join.

## 4. It just works — opinionated defaults over configurability

The Apple bet: take choices *away* from the user because you've made the decision better than they
would. Apple refuses to ship the settings other vendors advertise as features — no theme store, no
registry of toggles — and where it does allow personalization, it art-directs the options rather than
handing over a settings firehose. The cost: you lose the power user who wanted the knob. Apple
decides that trade is worth it for the 90%.

**Test:** Count the decisions forced on a user before they get any value — config screens, "choose your
plan" walls, empty states with no guidance, fields asked "just in case." Each toggle is the team
declining to decide and billing the user for it. For each, ask: would a strong default make the choice
disappear?

## 5. Premium restraint as a moat, not a mood

The Apple bet: restraint, materials, and fit-and-finish aren't an aesthetic preference — they're a
business moat that lets Apple charge more and *refuse the race to the bottom*. Visual noise reads as a
team unsure what matters, so it shouts everything. Calm reads as confidence, and confidence commands a
premium.

**Test:** Does every element earn its place, or is it decoration, hedging, or filler? Count typefaces,
weights, accent colors, and competing calls to action — a high count is hedging. Then ask the business
question: does the whole feel considered enough to justify charging more and saying no to discounting?

## 6. Privacy as a product, not a policy

The Apple bet: market privacy as a *reason to buy* and build it into the silicon — on-device
processing, data that never leaves the phone — leaving ad revenue on the table on purpose. Competitors
treat data as the asset; Apple treats *not* collecting it as the asset.

**Test:** What does this collect, store, or expose — and could it deliver the same value collecting
less, or keeping data local instead of sending it up? Flag every default that opts the user into
sharing, every "just in case" field, and every secret or personal datum sitting where it shouldn't.
Least data, on-device first.

## 7. Taste is choosing the harder right option

The Apple bet: taste is the willingness to redo the thing that already *works* because it isn't *right*
— the re-machined detail, the obsessed-over font, the curve nobody asked for. Functional is the floor;
tasteful is the choice to spend more to clear it. This is why two products with identical feature lists
feel a class apart.

**Test:** At each detail nobody is forced to get right — empty states, error copy, the easing on a
transition, the corner radius, the microcopy on a button — did they choose the refined option or the
merely functional one? Taste lives or dies in the places no spec covers.

## 8. Earn the one moment

The Apple bet: every product worth remembering has a single demo-able moment that makes the room lean
in and the product feel inevitable — "a thousand songs in your pocket." Crucially, the *absence* of
that moment is a diagnosis, not a copywriting gap: if there's no moment, the product isn't sharp enough
yet. Don't paper over it with a clever tagline.

**Test:** What is the one thing you'd show first to make someone *want* this? If there isn't one, that's
the highest-leverage finding on the page — and the fix is in the product, not the headline.

---

## Scoring: bands, not numbers

Do not score 0–10 — there are no anchors for it and two runs would never agree, which is false
precision the rest of this doctrine would reject. Instead, for each principle that **bites** this
artifact, assign one band:

- **Strong** — Apple would recognize this as one of its own. Leave it alone.
- **Hedging** — the instinct is there but the artifact is covering its bets: too many options, too much
  noise, decisions punted to the user. This is where most leverage lives.
- **Broken** — actively against the principle. Fix first.

Mark anything that doesn't apply **N/A** and don't score it. The bands exist to point at the cuts, so
the Broken/Hedging principles and your top-ranked cuts should name the same problems.
