# Solo Codex Workflow Template

# solo-codex-workflow

Codex と ChatGPT を活用した個人開発ワークフローのテンプレートです。  
GitHub Actions によるCI/CD、PRラベルによる変更範囲制限、安全なパッチ適用スクリプトを備えています。

## 概要
- **言語/フレームワーク非依存**（Python用サンプル込み）
- **CI**：pytest、Pythonマトリクス、pipキャッシュ
- **安全性**：PRラベルによる変更範囲制御、safe patch適用スクリプト
- **拡張性**：Docker化やLint追加可能

## 構成
- `src/` : アプリケーションコード
- `tests/` : テストコード
- `AGENT.md` : Codexへの要件指示
- `.github/workflows/tests.yml` : CI設定
- `agent/` : 補助ツール
- `docs/spec.md` : 詳細仕様書

## 詳細仕様
[詳細仕様はこちら](docs/spec.md)
