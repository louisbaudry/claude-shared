# Loading the shared context into a repo

`load-shared-context.sh` is a Claude Code SessionStart hook. At the start
of each session it prints:

- **`CLAUDE.md`** from this repo: the working rules. It reads a local
  clone (`$CLAUDE_SHARED_DIR`, `../claude-shared`, `~/claude-shared`), or
  fetches from GitHub without credentials, since this repo is public.
- **`ai_profile.md`** from the private `louisbaudry/ai_profile`: who Louis
  is. It's optional and comes from a local clone (`$AI_PROFILE_DIR`,
  `../ai_profile`, `~/ai_profile`). In a cloud session it loads only if
  `ai_profile` was selected as one of the session's repos, because the
  cloud proxy replaces any token with the session's own GitHub access.
  Locally, without a clone, `$AI_PROFILE_TOKEN` (a fine-grained,
  read-only token) works.

A `CLAUDE.md` `@import` can't do this: it only reads local files, and a
cloud session has only its own repos checked out.

The hook never fails a session. If the rules can't be loaded, it prints a
note asking Claude to tell you. A missing profile gets a single quiet line.

## Per-repo install

1. Copy the script:

   ```bash
   mkdir -p .claude/hooks
   cp /path/to/claude-shared/hooks/load-shared-context.sh .claude/hooks/
   chmod +x .claude/hooks/load-shared-context.sh
   ```

2. Register it in `.claude/settings.json` (merge if the file exists):

   ```json
   {
     "hooks": {
       "SessionStart": [
         {
           "hooks": [
             {
               "type": "command",
               "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/load-shared-context.sh"
             }
           ]
         }
       ]
     }
   }
   ```

3. Start the repo's `CLAUDE.md` with this, and keep only repo-specific
   content below it:

   ```markdown
   > Shared rules for working with Louis are loaded at session start from
   > `louisbaudry/claude-shared` by `.claude/hooks/load-shared-context.sh`.
   > This file only adds what is specific to this repo. If the session
   > context has no "Shared context for working with Louis" block, or it
   > shows a NOTE, say so.
   ```

## Updating

Edit `CLAUDE.md` here and merge to `main`. Every repo picks up the change
at its next session. Only changes to the script itself need copying into
each repo again.
