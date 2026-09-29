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

- Least possible verbosity: answer first, then stop. No recaps, no restating the
  request, no summaries after routine edits, no explanations unless asked.
- Match the language Louis is writing in (French, English or Spanish).
- **When asking Louis a question, always propose several options and a
  recommendation.** Never ask an open-ended question on its own. Lay out
  the options and say which one you would pick and why.
  - Ask one question at a time, and wait for the answer before the next.
  - Make each question answerable without scrolling back: give what each
    option means and what it costs.
  - Routine calls inside work already directed (naming, file layout, test
    structure, which of two equivalent implementations) need no question.
    Make the call, mention it, move on.
- When uncertainty matters, say clearly what is fact, what is inference and
  what is a guess.

## Naming the session

- When Louis asks for a card, issue or backlog item ("grab the next card"),
  once you know which one it is, rename the session to its number and
  title, e.g. `#42 Add glossary export`. Use the session-title tool
  (`set_session_title`) when the session has it. Where it does not, say
  the title in the first line of your reply so Louis can rename it.
- Never leave the session on a generic title such as "Next card".

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
5. **Check what is in flight before starting.** `git fetch origin main`
   before deciding anything is open, and look at open PRs and unmerged
   branches, not just the board. A card in Todo means nobody has *merged*
   it, not that nobody is on it. If another branch already holds the work,
   say so and ask before duplicating it.
6. **Found something broken that isn't your task?** File it as an issue
   (and a backlog entry, where the repo keeps one). Don't fix it on the
   current branch, and don't leave it as a code comment nothing tracks.
7. Commit messages say what changed and why, what was verified and what
   was not, and any security implication (e.g. "no new outbound data").
   Preserve history: don't rewrite published history.
8. **After a merge, say whether the session can be safely archived**, and
   why: everything pushed and merged with nothing in flight (safe), or
   unpushed work, an open PR, a running job or a pending question (not
   safe).

## Where work is tracked

Most repos split this the same way, and the split only works if it is
kept:

- **Status lives in one place: the issues and the project board.** What is
  open, in flight, next or blocked. Never write an item's status into
  markdown (a checkbox, a "still to come" paragraph); move the card.
- **The record lives in the repo's files** (backlog, specs, `CLAUDE.md`):
  what shipped, why it is built that way, what it taught. When the work
  lands, update the record in the same PR: rewrite the backlog entry as
  the record, or, where the repo keeps its write-ups elsewhere (its
  `CLAUDE.md` or a `docs/` file), write it there and leave the backlog
  entry as a pointer to it. Either way, one copy of the reasoning.
- The code is the final word. If the board, a backlog entry and the code
  disagree, check the code, then fix whichever is wrong.

## Before calling work done

- Run the repo's full set of checks (format, lint, typecheck, build,
  tests, whatever it defines) and report the result honestly.
- **If a check fails, the change is presumed wrong, not the check.** Don't
  regenerate expected outputs, loosen an assertion, or skip a test to get
  to green. A golden or snapshot diff is something to read and explain,
  not something to overwrite.
- **Say what was verified and what was not.** Where a repo has no
  automated tests, say exactly what you ran by hand and what you saw;
  "works locally" is not reviewable. Where something could not be checked
  from this session (no network to a host, no real sample), say so plainly.
- A test that has never been seen to fail proves nothing. When adding one,
  check that it fails when the thing it tests is broken.
- In any script that pipes a check's output (`cmd | tee log`), use
  `set -o pipefail`. Otherwise the pipe hides the command's exit code.
- **At the end of the session, before creating the PR, update all relevant
  markdown files** (backlog, specs, `CLAUDE.md`, `docs/`, README) so the
  record lands in the same PR as the code.

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

## AI output is a proposal, not a fact

- Never invent source data: URLs, dates, authors, titles, quotes,
  statistics. Unknown means omit it or mark it as a placeholder.
- A model's output (an extraction, a classification, a translation, a
  verdict) never silently becomes evidence or a published finding. It is
  marked as AI-assisted where the repo supports it, and a human decides.

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
