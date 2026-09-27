# Working with Louis (universal CLAUDE.md)

> Shared instructions for Claude Code in **every** repository Louis works in.
> Each repo's own `CLAUDE.md` loads this file at session start and then adds
> only what is specific to that repo. Who Louis is and his broader
> preferences live in `ai_profile.md` in his private `ai_profile` repo,
> loaded alongside this file when the session can reach it; this file is
> about how to work with him in a codebase.
>
> This repository is public. Keep it to working rules: nothing personal,
> no client names, no credentials.
>
> Precedence: a repo's own `CLAUDE.md` may narrow or extend these rules for
> that repo. It should not silently contradict them; where it does, the
> repo file wins and the conflict is worth flagging to Louis.
>
> Guidance that applies across repos belongs here, not copied into each one.
> Two copies of the same rule drift apart as soon as one is edited.

## Communication

- Be concise. Skip explanations unless asked. No summaries after routine edits.
- Match the language Louis is writing in (French, English or Spanish).
- **When asking Louis a question, always propose several options and a
  recommendation.** Never ask an open-ended question on its own. Lay out
  the options and say which one you would pick and why.
- When uncertainty matters, say clearly what is fact, what is inference and
  what is a guess.

## Git and pull requests

1. **Never merge without being asked.** Push the branch, open the PR,
   describe what it does, then wait. Every merge is an individual,
   explicit go-ahead, even when the change looks obviously safe.
2. **One task, one branch, one PR.** When the work comes from an issue,
   the PR body says `Closes #NN` so the issue and its board card close on
   merge.
3. **Branch from `main`, merge back to `main`, promptly.** Never branch
   from another session's branch, and never let one branch pile up several
   sessions of work. Otherwise `main` quietly stops being trunk.
4. **One session at a time on one area.** Parallel sessions on the same
   files, or on a shared record file, produce conflicts neither session
   meant to cause.
5. Use descriptive commit messages. Preserve history: don't rewrite
   published history.

## Before calling work done

- Run the repo's full set of checks (format, lint, typecheck, build,
  tests, whatever it defines) and report the result honestly.
- **If a check fails, the change is presumed wrong, not the check.** Don't
  regenerate expected outputs, loosen an assertion, or skip a test to get
  to green. A golden or snapshot diff is something to read and explain,
  not something to overwrite.
- In any script that pipes a check's output (`cmd | tee log`), use
  `set -o pipefail`. Otherwise the pipe hides the command's exit code.

## Design decisions go on the record

- Write a design decision (a data model, a file-format detail, a scope
  change) into the repo's docs before or alongside the code, never after.
  Keep the reasoning, not just the conclusion.
- Inspect the existing architecture before proposing large changes.
  Prefer maintainable solutions over clever ones, and don't replace a
  working system just because another stack is fashionable.
- **Define a shared fact once and import it everywhere.** Two copies of a
  constant, schema or regex can drift apart without anyone noticing.
- A test fixture that encodes a belief about someone else's format proves
  only that belief. Check it against a real sample before trusting the
  tests built on it.

## Public repositories

Before pushing, check whether the repo is public. If it is, everything
pushed is readable by anyone: code, fixtures, docs, commit messages,
branch names, and PR and issue text.

- **No personal data and no client data, ever, in any form.** That means
  no real names, email addresses, phone numbers or postal addresses. It
  also means no client names, client documents, translation memories,
  glossaries or text taken from them. No credentials, tokens or internal
  hostnames either. Nothing that would let a reader identify a client or a
  person behind a pseudonym. This covers test fixtures and "just a
  snippet" in an example or a log too.
- When unsure whether something identifies someone, leave it out and ask.
- Deleting a file in a later commit does not unpublish it: history keeps
  it. So the check happens before the push, not after.

Private repos still never get credentials or secrets committed.

## Maintaining this file

This file lives in `louisbaudry/claude-shared`. Update it there when a rule
turns out to apply everywhere, and move repo-specific detail back into
that repo's own `CLAUDE.md`. Propose changes; don't edit it silently from
another repo's session.
