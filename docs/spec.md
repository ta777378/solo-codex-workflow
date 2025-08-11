# 詳細仕様書

## CI仕様
### トリガー
- push(main) → `test_push`
- pull_request → `gate` → `test_pr`
- labeled（ラベル付与） → 再実行

### 実行環境
- Python 3.10 / 3.11（マトリクス）
- pipキャッシュ有効
- PYTHONPATH=. で pytest 実行

## ゲートルール
- ラベル必須: `role:coder` または `role:tester`
- role:coder: `tests/**` 変更禁止
- role:tester: `tests/**` と Docs以外の変更禁止
- CODEOWNERS: `tests/**` の変更は指定レビュアー承認必須

## ローカル補助ツール
- `agent/apply_patch_safe.sh`:
  - 制御文字除去
  - 簡易妥当性チェック
  - git apply 安全実行

## 今後の予定
- テスト件数減少検知
- カバレッジ閾値導入
- Lint / 型チェック
- Docker化
