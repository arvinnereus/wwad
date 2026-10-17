#!/usr/bin/env bash
# WWAD deploy gate — Claude Code PreToolUse hook (matcher: Bash; on Windows use Bash|PowerShell).
# Reads the tool payload (JSON) on stdin. If the command runs a real deploy, blocks the call (exit 2)
# and asks Claude to run /wwad first. Anything else passes through untouched (exit 0).
#
# Only deploys that are run count, not deploys that are mentioned: `./deploy.sh` is a deploy;
# `cat deploy.sh`, `git add deploy.sh`, an echo or a commit message that names one are not.
#
# After a /wwad pass, record it with hooks/wwad-pass.sh: the gate then lets deploys through for
# WWAD_GATE_MINUTES (default 30). Exit 2 = block and feed stderr back to Claude.
#
# Tuning: edit the deploy patterns below for your stack.

set -euo pipefail
payload="$(cat)"

# Pull out tool_input.command as a JSON string, honouring escaped quotes (\") so a quoted path can't end
# the match early. Then undo the JSON escaping: escaped backslashes are parked first so a Windows path like
# C:\new\x isn't mistaken for a newline, JSON newlines become real ones, quotes come back.
raw="$(printf '%s' "$payload" | grep -oE '"command"[[:space:]]*:[[:space:]]*"(\\.|[^"\\])*"' | head -n 1 || true)"
[ -z "$raw" ] && exit 0
cmd="$(printf '%s' "$raw" | sed -E 's/^"command"[[:space:]]*:[[:space:]]*"//; s/"$//
s/\\\\/__WWAD_BS__/g; s/\\"/"/g; s/\\t/ /g
s/\\[nr]/\
/g
s/__WWAD_BS__/\\/g')"

# One command per line: split at ; & | (and the newlines above), so each piece is judged on its own.
segs="$(printf '%s\n' "$cmd" | tr ';&|' '\n\n\n')"

# A deploy only counts at the START of a piece: optionally behind shell keywords, VAR=value, sudo/env,
# or a package runner (npx, bunx, pnpm dlx, yarn), and with an optional path/extension (PowerShell:
# & "C:\Program Files\nodejs\npx.cmd" wrangler ...).
start='^[[:space:]($`{]*'
kw='((if|then|do|else|time|sudo|env|exec|command|nohup)[[:space:]]+)*'
assign='([A-Za-z_][A-Za-z0-9_]*=[^[:space:]]*[[:space:]]+)*'
path='("[^"]*[/\\]|[^[:space:]";&|]*[/\\])?'
ext='(\.(cmd|exe|ps1))?"?'
runner='('"$path"'(npx|bunx)'"$ext"'[[:space:]]+(-y[[:space:]]+)?|(pnpm|yarn)'"$ext"'[[:space:]]+((dlx|exec)[[:space:]]+)?)?'
tools='(wrangler'"$ext"'[[:space:]]+(deploy|pages[[:space:]]+deploy|versions[[:space:]]+upload)|vercel'"$ext"'([[:space:]]+(deploy|--prod|build)|[[:space:]]*$)|netlify'"$ext"'[[:space:]]+deploy|(npm|pnpm|yarn)'"$ext"'[[:space:]]+publish|git'"$ext"'([[:space:]]+-C[[:space:]]+("[^"]*"|[^[:space:]]+))?[[:space:]]+push([[:space:]]+[^[:space:]]+)*[[:space:]:](main|master)([^[:alnum:]/_.-]|$))'
deploy_re="${start}${kw}${assign}${runner}${path}${tools}"
# Project deploy scripts (./deploy.sh, bash path/deploy.sh). A --preview run isn't a launch.
script_re="${start}${kw}${assign}((ba|z)?sh${ext}[[:space:]]+)?${path}deploy\\.sh"

hits="$(printf '%s\n' "$segs" | grep -iE "$deploy_re" || true)"
scripts="$(printf '%s\n' "$segs" | grep -E "$script_re" | grep -vE -- '--preview' || true)"
[ -z "${hits}${scripts}" ] && exit 0

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
