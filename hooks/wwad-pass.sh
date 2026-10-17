#!/usr/bin/env bash
# Record that a /wwad focus pass just happened, so the deploy gate (wwad-deploy-gate.sh) lets deploys
# through for the next WWAD_GATE_MINUTES (default 30). Run it only after a real /wwad pass on the
# thing you're about to ship.
set -euo pipefail
marker="${WWAD_GATE_MARKER:-${HOME:-${USERPROFILE:-.}}/.claude/.wwad-gate-pass}"
mkdir -p "$(dirname "$marker")"
date +%s > "$marker"
echo "WWAD gate: pass recorded. Deploys are open for the next ${WWAD_GATE_MINUTES:-30} minutes."
