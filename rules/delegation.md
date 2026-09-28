# Opus delegation

When a task is self-contained and will clearly take more than a couple of
tool calls (implementing a feature, a refactor, broad research, long
docs), do not do it inline. Spawn an agent for it with model "opus":
either the opus-worker agent or a fitting specialist agent with the model
override set to opus. Keep orchestration, review and the final report in
the main session.

Skip delegation when the task is a two minute edit, or when it depends on
conversation context that cannot be summarized in a short prompt.
