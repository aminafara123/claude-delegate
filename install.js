#!/usr/bin/env node
// Installs the opus-worker agent and the delegation rule. Safe to run
// twice, the rule is only appended once.
const fs = require("fs");
const path = require("path");
const os = require("os");

const here = __dirname;
const claudeDir = path.join(os.homedir(), ".claude");

fs.mkdirSync(path.join(claudeDir, "agents"), { recursive: true });
fs.copyFileSync(
  path.join(here, "agents", "opus-worker.md"),
  path.join(claudeDir, "agents", "opus-worker.md")
);

const claudeMd = path.join(claudeDir, "CLAUDE.md");
const current = fs.existsSync(claudeMd)
  ? fs.readFileSync(claudeMd, "utf8")
  : "";
if (!current.includes("# Opus delegation")) {
  const rule = fs.readFileSync(
    path.join(here, "rules", "delegation.md"),
    "utf8"
  );
  const glue = current === "" || current.endsWith("\n") ? "\n" : "\n\n";
  fs.writeFileSync(claudeMd, current + glue + rule);
}

console.log("installed: opus-worker agent and delegation rule in ~/.claude/CLAUDE.md");
console.log("new Claude Code sessions pick it up on start");
console.log('for the opus terminal command, install globally: npm i -g claude-delegate');
