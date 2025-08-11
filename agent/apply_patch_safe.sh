#!/usr/bin/env bash
set -euo pipefail
in="${1:-/tmp/patch.diff}"

# 制御文字を除去してクリーンに
tr -cd '\11\12\15\40-\176' < "$in" > /tmp/patch.clean.diff

# 最低限の妥当性 (ヘッダ確認)
if ! grep -qE '^diff --git ' /tmp/patch.clean.diff || ! grep -qE '^\+\+\+ b/' /tmp/patch.clean.diff; then
  echo "❌ patch is not a valid unified diff. Aborting." >&2
  exit 2
fi

# 適用
git apply /tmp/patch.clean.diff
echo "✅ patch applied."
