#!/usr/bin/env bash
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
ROLE_OVERRIDE=TESTER agent/run_codex.sh
