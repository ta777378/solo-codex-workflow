#!/usr/bin/env bash
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
ROLE_OVERRIDE=CODER agent/run_codex.sh
