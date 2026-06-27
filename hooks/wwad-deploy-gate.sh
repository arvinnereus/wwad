#!/usr/bin/env bash
# WWAD deploy gate — Claude Code PreToolUse hook (matcher: Bash).
# Reads the tool payload (JSON) on stdin. If the command is a real deploy,
# blocks the call (exit 2) and asks Claude to run /wwad first. Anything else
# passes through untouched (exit 0).
#
# Exit 2 = block and feed stderr back to Claude. To proceed anyway, the model
# (or you) can re-issue the command after running /wwad, or remove this hook.
#
# Tuning: edit the deploy pattern below for your stack.

set -euo pipefail
payload="$(cat)"

# Pull just the command string out of the tool input so we don't match deploy
# words sitting in unrelated arguments.
cmd="$(printf '%s' "$payload" | grep -oE '"command"[[:space:]]*:[[:space:]]*"[^"]*"' || true)"

deploy_re='wrangler[[:space:]]+(deploy|pages[[:space:]]+deploy|versions[[:space:]]+upload)|vercel([[:space:]]+(deploy|--prod|build))?|netlify[[:space:]]+deploy|npm[[:space:]]+publish|pnpm[[:space:]]+publish|git[[:space:]]+push([[:space:]][^"]*)?[[:space:]]+(main|master)([^[:alnum:]/_.-]|$)'

if printf '%s' "$cmd" | grep -qiE "$deploy_re"; then
  echo "WWAD deploy gate: you're about to deploy. Run /wwad on what you're shipping first — a focus/restraint pass is cheapest before it goes live. Then re-run this command. (Override consciously, or remove this hook, to proceed.)" >&2
  exit 2
fi

exit 0
