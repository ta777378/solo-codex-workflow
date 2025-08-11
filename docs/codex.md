# Codex 使い方ガイド

## 原則
- Codexは**実装(diff)**のみを出す。**テストは人間が作る/変更する**。
- 出力は**ユニファイドdiffのみ**。説明文やコードブロックは不要。
- 変更は基本 `src/**` のみ。CIやテンプレ保守の場合は `.github/**` や `agent/**` も可。

## ロール
- **Coder**: `src/**` の最小差分で既存テストを緑に。`tests/**`変更禁止。
- **Tester**: 人間担当。`tests/**` でFail→Greenの流れを作る。
- **Template Maintainer**: CI・ガード・ドキュメントの保守。

## 実行手順（標準）
1. `AGENT.md` に今回のタスクを書く（受け入れ条件・範囲・禁止事項）
2. `agent/run_codex.sh CODER` を実行 → `/tmp/patch.diff` 生成
3. ガードOKなら適用・コミット・PR作成 → `role:coder` ラベル → CI確認

## 失敗時の対処
- diffが壊れている → `agent/apply_patch_safe.sh` が弾く。AGENT.mdを簡潔に直す
- `git apply` 失敗 → 競合があればリベース、古いベースなら再生成
- CI落ち → ログ確認 → AGENT.mdを補足して再依頼 or 手動で修正

## よくあるレシピ
- **新しい関数追加**: 受け入れ条件をテスト化→Coderに最小実装依頼
- **バグ修正**: 再現テスト追加→Coderで修正→CI緑
- **軽いCI調整**: Maintainerロールで `tests.yml` をCodexに依頼（テストは触らない）
