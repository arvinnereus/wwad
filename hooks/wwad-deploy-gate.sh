#!/usr/bin/env bash
# WWAD deploy gate — Claude Code PreToolUse hook (matcher: Bash; on Windows use Bash|PowerShell).
# Reads the tool payload (JSON) on stdin. If the command is a real deploy, blocks the call
# (exit 2) and asks Claude to run /wwad first. Anything else passes through untouched (exit 0).
#
# After a /wwad pass, record it with hooks/wwad-pass.sh: the gate then lets deploys through for
# WWAD_GATE_MINUTES (default 30). Exit 2 = block and feed stderr back to Claude.
#
# Tuning: edit the deploy patterns below for your stack.

set -euo pipefail
payload="$(cat)"

# Pull out tool_input.command as a JSON string. Honour escaped quotes (\") so a quoted path early in
# the command can't end the match and hide the deploy that follows it. Then undo the JSON escaping.
raw="$(printf '%s' "$payload" | grep -oE '"command"[[:space:]]*:[[:space:]]*"(\\.|[^"\\])*"' | head -n 1 || true)"
[ -z "$raw" ] && exit 0
cmd="$(printf '%s' "$raw" | sed -E 's/^"command"[[:space:]]*:[[:space:]]*"//; s/"$//; s/\\"/"/g; s/\\\\/\\/g')"

# Describing a deploy isn't doing one: blank out commit-message text (-m "…", -m '…', --message=…)
# before matching, so a message like "run ./deploy.sh" doesn't trip the gate. Chained deploys still count.
scan="$(printf '%s' "$cmd" | sed -E 's/(-m|--message)(=|[[:space:]]+)"(\\.|[^"\\])*"/ /g')"
scan="$(printf '%s' "$scan" | sed -E "s/(-m|--message)(=|[[:space:]]+)'[^']*'/ /g")"

# Deploy commands. git push only counts when it targets main/master (incl. -C <dir> and HEAD:main).
core_re='wrangler[[:space:]]+(deploy|pages[[:space:]]+deploy|versions[[:space:]]+upload)|vercel([[:space:]]+(deploy|--prod|build))?|netlify[[:space:]]+deploy|(npm|pnpm|yarn)[[:space:]]+publish|git([[:space:]]+-C[[:space:]]+("[^"]*"|[^[:space:]]+))?[[:space:]]+push([[:space:]]+[^;&|]*)?[[:space:]:](main|master)([^[:alnum:]/_.-]|$)'
# Project deploy scripts (./deploy.sh, bash path/deploy.sh). A --preview run isn't a launch.
script_re='(^|[[:space:]/"])deploy\.sh'

is_deploy=0
if printf '%s' "$scan" | grep -qiE "$core_re"; then
  is_deploy=1
elif printf '%s' "$scan" | grep -qE "$script_re" && ! printf '%s' "$scan" | grep -qE "${script_re}[^;&|]*--preview"; then
  is_deploy=1
fi
[ "$is_deploy" = 0 ] && exit 0

# A recent, recorded /wwad pass opens a short deploy window (see wwad-pass.sh).
marker="${WWAD_GATE_MARKER:-${HOME:-${USERPROFILE:-.}}/.claude/.wwad-gate-pass}"
minutes="${WWAD_GATE_MINUTES:-30}"
if [ -f "$marker" ]; then
  passed_at="$(head -n 1 "$marker" 2>/dev/null | tr -cd '0-9')"
  now="$(date +%s)"
  if [ -n "$passed_at" ] && [ $(( now - passed_at )) -ge 0 ] && [ $(( now - passed_at )) -lt $(( minutes * 60 )) ]; then
    exit 0
  fi
fi

here="$(cd "$(dirname "$0")" && pwd)"
echo "WWAD deploy gate: you're about to deploy. Run /wwad on what you're shipping first — a focus/restraint pass is cheapest before it goes live. When the pass is done, record it with: bash \"$here/wwad-pass.sh\" — then re-run this command (deploys stay open for $minutes minutes). Or remove this hook." >&2
exit 2
