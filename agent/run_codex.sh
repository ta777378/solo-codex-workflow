#!/usr/bin/env bash
set -euo pipefail

# 実行ディレクトリからロール自動判定
abs_dir="$(pwd)"
role="CODER"
case "$abs_dir" in
  *"/tests"* ) role="TESTER" ;;
  *"/src"* ) role="CODER" ;;
  *"/.github"*|*"/agent"* ) role="MAINTAINER" ;;
  * ) role="${ROLE_OVERRIDE:-CODER}" ;;
esac
echo "➡ Role(auto): $role  (cwd: $abs_dir)"

# プロンプト雛形の選択
prompt_file="prompts/coder.md"
[ "$role" = "TESTER" ] && prompt_file="prompts/tester.md"
[ "$role" = "MAINTAINER" ] && prompt_file="prompts/template_maintainer.md"

if [ ! -f "$prompt_file" ]; then
  echo "❌ prompt file not found: $prompt_file"; exit 2
fi
if [ ! -f "AGENT.md" ]; then
  echo "❌ AGENT.md が見つかりません（リポ直下で実行してください）"; exit 2
fi

# Codex入力準備
tmp_in="$(mktemp)"
cat "$prompt_file" > "$tmp_in"
echo -e "\n---\n" >> "$tmp_in"
cat "AGENT.md" >> "$tmp_in"

# Codex実行 → diff保存
OUT="${1:-/tmp/patch.diff}"
cat "$tmp_in" | codex run > "$OUT"

# 役割ガード（ローカル）
if [ -f agent/guard.py ]; then
  maprole="$role"; [ "$role" = "MAINTAINER" ] && maprole="CODER"
  python agent/guard.py --role "$maprole" "$OUT"
fi

# 安全適用
if [ -x agent/apply_patch_safe.sh ]; then
  ./agent/apply_patch_safe.sh "$OUT"
else
  git apply "$OUT"
fi

echo "✅ Patch applied (Role=$role). 変更を確認してコミット→PR（ラベル付与）へ。"
