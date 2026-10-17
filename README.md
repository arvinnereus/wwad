# WWAD — What Will Apple Do

A Claude skill that critiques any product artifact through Apple's product doctrine and returns
ranked, concrete cuts — plus an optional simplified redesign and the one detail that would make the
thing feel inevitable.

WWAD is a **lens, not a neutral reviewer.** Its opinion is deliberately fixed and deliberately
Apple-shaped: it takes contestable positions a different company would reject (integration over
modularity, opinionated defaults over configurability, refusing the race to the bottom). The value is
one coherent, demanding worldview applied consistently — the way a strong design lead does — instead of
balanced mush.

It works on landing pages, app screens, dashboards, **CLIs / APIs / SDKs**, features, roadmaps,
pricing, naming, positioning, launches, and internal workflows.

> Not affiliated with or endorsed by Apple Inc. "What Will Apple Do" is a critical lens modelled on
> Apple's well-documented product behaviour — a point of view to reason from, not a channeling of any
> person. Its judgments are taste, not physics; overrule them when you know your users better.

---

## The doctrine — eight contestable bets

Each is a position Apple takes that a reasonable competitor rejects — not generic "less is more."

1. **Subtract until it breaks, then stop** — remove what the industry calls mandatory (the headphone
   jack), but don't cut load-bearing things; Apple also *adds* with conviction (the Dynamic Island).
2. **Say no to a thousand things — especially the good ones** — focus is killing good ideas, not bad.
3. **Own the whole stack; integrate where others bolt together** — control the seams.
4. **It just works — opinionated defaults over configurability** — take choices away because you made
   them better.
5. **Premium restraint as a moat, not a mood** — restraint lets you charge more and refuse to discount.
6. **Privacy as a product, not a policy** — leave data (and ad revenue) on the table on purpose.
7. **Taste is choosing the harder right option** — redo the thing that "works" because it isn't right.
8. **Earn the one moment** — the absence of a demo-able moment is a diagnosis, not a copywriting gap.

Full detail, each with the test it implies, lives in [`doctrine.md`](doctrine.md).

---

## Install (Claude Code)

Clone into your skills directory:

```bash
git clone https://github.com/arvinnereus/wwad.git ~/.claude/skills/wwad
```

The skill is discovered automatically. Confirm with `/skills` (you should see `wwad`).

---

## Use

```
/wwad                      run on the current work or diff
/wwad <path | url>         run on a named artifact (a URL is fetched and viewed before judging)
/wwad: <question>          resolve a yes/no product decision (uses the decision-mode output)
```

You don't have to say "Apple." "What should we cut here?", "is this too bloated?", or "give me a
ruthless focus pass" all reach for WWAD.

### What you get back

A verdict (`✅ ships` / `✂️ ships after cuts` / `🔁 right idea, wrong execution` / `❌ kill it` /
`⚠️ can't judge`), a per-principle **band read** (Strong / Hedging / Broken — no fake 0–10 scores), a
ranked list of concrete cuts, an optional redesign, and "the one more thing." Abridged example:

```
# WWAD — Nimbus landing page
Verdict: ✂️ Apple ships it after these cuts.

The cuts (ranked, highest leverage first)
1. Delete the spin-to-win wheel, the 5-second newsletter popup, and the live-chat bubble — three
   trust leaks before the visitor reads a word. (Premium restraint; Cut the chrome)
2. Cut the hero from three competing CTAs to one. (One primary action; Say no)
3. Rewrite the headline to say one true thing — three nouns stapled to a buzzword survives the squint
   as nothing. (Three-second clarity; Taste)
...
```

---

## The lenses

WWAD loads only the lens(es) that fit the artifact, on top of the doctrine:

| Lens | For | File |
|---|---|---|
| UI | landing pages, app screens, dashboards, email | [`lenses/ui.md`](lenses/ui.md) |
| Developer | CLI, API, SDK, config formats | [`lenses/dev.md`](lenses/dev.md) |
| Product | features, scope, roadmap, "should this exist" | [`lenses/product.md`](lenses/product.md) |
| Go-to-market | pricing, naming, positioning, launch | [`lenses/gtm.md`](lenses/gtm.md) |
| Internal | internal tools, workflows, automations, process | [`lenses/internal.md`](lenses/internal.md) |

---

## Optional: the launch gate (Phase 2 hooks)

WWAD can run as a *standing gate* so a focus pass isn't forgotten before you ship. Two optional
[Claude Code hooks](https://docs.anthropic.com/en/docs/claude-code/hooks):

- **A nudge** (`UserPromptSubmit`) — when you use launch language ("ship", "go live", "publish"),
  it reminds you to run `/wwad` first. Non-blocking.
- **A gate** (`PreToolUse` on `Bash` and `PowerShell`) — when a real deploy command runs
  (`wrangler deploy` / `pages deploy`, `vercel`, `netlify deploy`, `npm`/`pnpm`/`yarn publish`, `git push`
  to main, or a project `deploy.sh`), it pauses and asks you to run `/wwad` first. Preview runs
  (`deploy.sh --preview`) and pushes to other branches pass.

**After the pass**, record it and re-run the deploy:

```bash
bash ~/.claude/skills/wwad/hooks/wwad-pass.sh   # opens the gate for 30 minutes (WWAD_GATE_MINUTES)
```

Example config and the three scripts are in [`hooks/`](hooks/). To enable, merge
[`hooks/settings.example.json`](hooks/settings.example.json) into your `~/.claude/settings.json` and
adjust the paths. The scripts are POSIX shell — on Windows, run them via Git Bash.

The gate reads the real command out of the hook's JSON, quoted paths and all, and only counts deploys that
are **run**, not ones that are mentioned: `cd "My Site" && npx wrangler pages deploy` is caught, while
`cat deploy.sh`, `git add deploy.sh`, an `echo`, or a commit message that names a deploy passes.

These are deliberately opt-in: the skill is fully useful without them.

---

## License

MIT — see [`LICENSE`](LICENSE).
