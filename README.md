# claude-delegate

A small kit that makes Claude Code spend Opus tokens on the heavy lifting and keep the top tier orchestrator model for steering. Top tier models come with tighter weekly limits, so the trick is not using them less, its having them delegate more.

Three pieces, no code running anywhere:

| Piece | What it does |
|---|---|
| `agents/opus-worker.md` | A generic worker agent pinned to `model: opus`. Any session can hand it a self-contained task |
| `rules/delegation.md` | A rule appended to `~/.claude/CLAUDE.md`: heavy self-contained work gets spawned as an Opus agent instead of running inline |
| `bin/opus` | An `opus` command for any console. No args opens an interactive Opus session, args become a one shot prompt |

## Setup

```bash
git clone https://github.com/aminafara123/claude-delegate
cd claude-delegate
./install.sh
```

The installer copies the agent to `~/.claude/agents/`, puts `opus` in `~/.local/bin/` and appends the rule to `~/.claude/CLAUDE.md` once. Run `./test.sh` to check the pieces.

## Demo

In a Claude Code session running a top tier model:

```
> refactor the report parser and add tests

⏺ Agent(opus-worker) · implementing parser refactor with tests

⏺ The worker refactored parse_report into three small functions and
  added test_parser.py, 6 asserts, all passing. The orchestrator
  session spent its own tokens only on this summary.
```

And from a plain console:

```bash
opus "explain what this regex does: ^\*\*(T-[A-Z]\d+) "
```

The session above is demo data. The mechanism is exactly what the kit installs.

## Design notes

- **Nothing new is invented.** Claude Code already lets an agent definition pin a model and lets a session override the model per spawned agent. This kit just packages that into a habit: one worker, one rule, one command.
- **The rule routes your whole agent pack.** If you have specialist agents installed, the delegation rule tells the orchestrator to spawn them with the opus override, so they all become Opus workers without editing their files.
- **Uninstall is transparent.** Delete the agent file, the `opus` script and the rule block from `~/.claude/CLAUDE.md`. Nothing else is touched.

## Honest notes

- What this saves depends on how your plan meters each model. Delegation shifts the heavy token spend to Opus, but the orchestrator still reads every worker report, so its usage drops rather than disappears. Watch /usage for a week before trusting any number.
- The rule is an instruction, not a hard router. The model follows it well but nothing enforces it.
- Model aliases like `opus` resolve to the latest Opus. When Anthropic moves the alias, this kit moves with it.

## About

Al Amin Bashir Afara, Dubai · [github.com/aminafara123](https://github.com/aminafara123) · [linkedin.com/in/aminafara](https://www.linkedin.com/in/aminafara)
