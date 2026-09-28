#!/usr/bin/env bash
# Installs the opus-worker agent, the opus command and the delegation
# rule. Safe to run twice, the rule is only appended once.
set -e
here="$(cd "$(dirname "$0")" && pwd)"

mkdir -p ~/.claude/agents ~/.local/bin
cp "$here/agents/opus-worker.md" ~/.claude/agents/
install -m 755 "$here/bin/opus" ~/.local/bin/opus

touch ~/.claude/CLAUDE.md
if ! grep -qF "# Opus delegation" ~/.claude/CLAUDE.md; then
  printf '\n' >> ~/.claude/CLAUDE.md
  cat "$here/rules/delegation.md" >> ~/.claude/CLAUDE.md
fi

grep -q "^model: opus" ~/.claude/agents/opus-worker.md
command -v claude >/dev/null || echo "warning: claude CLI not found on PATH"
case ":$PATH:" in
  *:"$HOME/.local/bin":*) ;;
  *) echo "warning: ~/.local/bin is not on PATH, the opus command needs it" ;;
esac
echo "installed: opus-worker agent, opus command, delegation rule in ~/.claude/CLAUDE.md"
