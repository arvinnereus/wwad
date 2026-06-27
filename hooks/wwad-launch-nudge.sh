#!/usr/bin/env bash
# WWAD launch-language nudge — Claude Code UserPromptSubmit hook.
# Reads the hook payload (JSON) on stdin. If the prompt uses launch language,
# prints a one-line reminder that Claude Code adds to context. Non-blocking:
# always exits 0, never stops the turn.
#
# Tuning: edit the pattern below to match how you talk about shipping.

set -euo pipefail
payload="$(cat)"

# The prompt text lives in the payload; a whole-payload grep is good enough for
# a non-blocking nudge (false positives here are harmless).
if printf '%s' "$payload" | grep -qiE '\b(ship(ping|ped)?|launch(ing|ed)?|go[ -]?live|deploy(ing|ed)?|publish(ing|ed)?|going to prod|ready to (ship|launch|publish|go))\b'; then
  echo "WWAD: this sounds like a launch. Consider a /wwad focus pass before it goes out — ruthless subtraction is cheapest before you ship, not after."
fi

exit 0
