# 言語/フレームワーク切り替えガイド

## Node.js (npm)
- テスト: `npm ci && npm test`
- 置換: `.github/workflows/tests.yml` のインストール/実行ステップ
- 例:
  - setup-node: `actions/setup-node@v4` with `cache: 'npm'`
  - Run tests: `npm test --silent`

## Go
- テスト: `go test ./...`
- 置換: setup-go + `go build`/`go test`

## Java (Maven)
- テスト: `mvn -B -q test`
- 置換: setup-java + `actions/cache`（~/.m2）

## Python (デフォルト)
- 既定: `requirements.txt` / `pytest` / `PYTHONPATH=.` / matrix 3.10/3.11

## ディレクトリ構成ルール
- 実装: `src/`（言語に応じて調整可）
- テスト: `tests/`
- CI: `.github/workflows/tests.yml`

## 切替手順（例: Node）
1. `requirements.txt` → `package.json` に移行
2. `tests.yml` のセットアップと実行コマンドを Node 用に置換
3. `CODEOWNERS` と gate はそのまま（tests の所有権ポリシーは共通）
