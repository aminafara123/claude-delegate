# claude-delegate

Save your Claude Code weekly limit. This kit makes your top tier model delegate the heavy work to Opus subagents automatically, and gives you an `opus` command for the terminal. One agent, one rule, one command. No dependencies, no server, nothing running in the background, about forty lines you can read in a minute.

## The problem

Claude Code meters its top tier models with tight weekly usage limits. If your best model types every line of code itself, the cap goes fast. Claude Code can already spawn subagents on any model, and Opus handles implementation work very well. The capability sits there unused because nothing makes it the default. Thats the whole gap this kit closes.

## What it does

- Your orchestrating model keeps the thinking: planning, review, the final answer
- Heavy self-contained work like features, refactors, broad research and long docs gets spawned as an Opus subagent instead of running inline
- From any terminal, `opus` opens an Opus session, or answers a one shot prompt without touching your main session at all

## Whats inside

| Piece | What it does |
|---|---|
| `agents/opus-worker.md` | A generic worker agent pinned to `model: opus`. Any session can hand it a self-contained task |
| `rules/delegation.md` | A delegation rule appended to `~/.claude/CLAUDE.md` once. It tells the orchestrator to route heavy work to Opus subagents |
| `bin/opus` | The `opus` terminal command. No args opens an interactive Opus session, args become a one shot prompt |

## Quick start

```bash
git clone https://github.com/aminafara123/claude-delegate
cd claude-delegate
./install.sh
```

Thats it. New Claude Code sessions pick up the rule on start. Run `./test.sh` if you want to check the pieces.

From the terminal:

```bash
opus                                          # interactive Opus session
opus "write a regex that matches ISO dates"   # one shot, prints the answer and exits
```

Inside a Claude Code session running a top tier model:

```
> refactor the report parser and add tests

⏺ Agent(opus-worker) · implementing parser refactor with tests

⏺ The worker refactored parse_report into three small functions and
  added test_parser.py, 6 asserts, all passing. The orchestrator
  session spent its own tokens only on this summary.
```

The session above is demo data. The mechanism is exactly what the kit installs.

## Why youd want it

- **The scarce quota goes further.** Top tier tokens get spent on steering and judgement, Opus tokens get spent on typing.
- **It routes the agents you already have.** If you run a pack of specialist agents, the rule tells the orchestrator to spawn them with the Opus override, so they all become Opus workers without editing a single file of theirs.
- **Nothing to trust blindly.** No binaries, no API keys, no wrapper sitting between you and Claude. Standard documented Claude Code features underneath, and every line of the kit is readable in one sitting.
- **Reversible in a minute.** Delete the agent file, the `opus` script and the rule block from `~/.claude/CLAUDE.md`. Nothing else was touched.

## FAQ

**Does this reduce my token usage?**
It shifts it, which is the point. The heavy spend moves to Opus and the orchestrator only reads worker reports, so its usage drops rather than disappears. What that saves in practice depends on how your plan meters each model. Watch /usage for a week before trusting any number.

**I already have specialist agents installed. Do I need the opus-worker?**
The rule routes your specialists too. The worker is just the generic target for tasks that dont fit any of them.

**Is this a hack or against the terms?**
No. Pinning a model in an agent definition and overriding the model per spawned agent are normal Claude Code features. This kit is configuration for them, nothing more.

**What happens when Anthropic updates Opus?**
The `opus` alias resolves to the latest Opus model, so the kit follows along with no changes.

**Does the rule always fire?**
Its an instruction the model follows, not a hard router. In practice models follow it well, but nothing enforces it, and quick two minute edits stay inline on purpose.

## About

Al Amin Bashir Afara, Dubai · [github.com/aminafara123](https://github.com/aminafara123) · [linkedin.com/in/aminafara](https://www.linkedin.com/in/aminafara)
