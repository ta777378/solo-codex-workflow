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

## ドキュメント
- [Codexの使い方](docs/codex.md)
- [言語/フレームワーク切替](docs/language-switch.md)
- [詳細仕様](docs/spec.md)

## Codexの実行（ディレクトリ連動）

- **実装作業**: `cd src && ./codex.sh`
  - Coderモードで実行され、`src/**` 以外の変更はローカルのガードとPRゲートでブロックされます
- **テスト作業（基本は人間）**: `cd tests` で手動編集
  - 特殊ケースでCodexにテスト生成を試す場合は `cd tests && ./codex.sh`（Testerモード）
- **テンプレ保守**: `.github/` や `agent/` で編集 → PRには `role:coder` ラベル

> PRは必ずラベル（`role:coder` / `role:tester`）を付けてください。ゲートが役割と変更範囲を検証します。
