#!/usr/bin/env bash
set -euo pipefail
ROLE="${1:-CODER}"             # CODER / TESTER / MAINTAINER など
OUT="${2:-/tmp/patch.diff}"

# 1) Codex実行（あなたの環境のCLIに合わせて）
# 例: cat AGENT.md | codex run > "$OUT"
cat AGENT.md | codex run > "$OUT"

# 2) 役割ガード（任意：導入済みなら）
if [ -f agent/guard.py ]; then
  python agent/guard.py --role "$ROLE" "$OUT"
fi

# 3) 安全適用
./agent/apply_patch_safe.sh "$OUT"

echo "✅ Patch applied. Review changes, then commit & PR."
