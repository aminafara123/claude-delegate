#!/usr/bin/env bash
# Smoke check: the pieces exist, parse, and say what they must say.
set -e
cd "$(dirname "$0")"
node --check install.js
node --check opus.js
grep -q "^model: opus" agents/opus-worker.md
grep -q "^name: opus-worker" agents/opus-worker.md
grep -qF "# Opus delegation" rules/delegation.md
node -e "const p = require('./package.json'); if (!p.bin.opus || !p.bin['claude-delegate']) process.exit(1)"
echo ok
