#!/usr/bin/env node
// Run Opus from any console. No args: interactive session. With args:
// everything becomes one headless prompt and the answer prints to stdout.
const { spawnSync } = require("child_process");

const args = process.argv.slice(2);
const claudeArgs = ["--model", "opus"];
if (args.length > 0) {
  claudeArgs.push("-p", args.join(" "));
}

const r = spawnSync("claude", claudeArgs, {
  stdio: "inherit",
  shell: process.platform === "win32",
});
if (r.error && r.error.code === "ENOENT") {
  console.error("claude CLI not found on PATH. Install Claude Code first: npm i -g @anthropic-ai/claude-code");
  process.exit(127);
}
process.exit(r.status === null ? 1 : r.status);
