# claude-shared

Louis's shared rules for Claude Code, in one place. The rules are in
[`CLAUDE.md`](CLAUDE.md). Each repo loads them at session start through
the hook in [`hooks/`](hooks/), then adds only its own repo-specific
`CLAUDE.md`.

This repo is public so that any cloud session can read it without
credentials. Keep it to working rules: nothing personal, no client
names, no secrets. The personal profile (`ai_profile.md`) lives in the
private `louisbaudry/ai_profile` repo.
