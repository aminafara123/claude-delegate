#!/usr/bin/env bash
# Smoke check: the pieces exist, parse, and say what they must say.
set -e
cd "$(dirname "$0")"
bash -n install.sh bin/opus
grep -q "^model: opus" agents/opus-worker.md
grep -q "^name: opus-worker" agents/opus-worker.md
grep -q -- "--model opus" bin/opus
grep -qF "# Opus delegation" rules/delegation.md
echo ok
