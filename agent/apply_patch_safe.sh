#!/usr/bin/env bash
set -euo pipefail
in="${1:-/tmp/patch.diff}"
tr -cd '\11\12\15\40-\176' < "$in" > /tmp/patch.clean.diff
if ! grep -qE '^diff --git ' /tmp/patch.clean.diff || ! grep -qE '^\+\+\+ b/' /tmp/patch.clean.diff; then
  echo "❌ not a valid unified diff"; exit 2
fi
git apply /tmp/patch.clean.diff
echo "✅ patch applied"
