# Rules for coding repos

> Applies to repos that ship code. Read after [`CLAUDE.md`](CLAUDE.md),
> which holds the rules common to every repo (communication, git and PRs,
> tracking, public-repo safety). A repo's own `CLAUDE.md` may narrow these.

## Before calling work done

- Run the repo's full set of checks (format, lint, typecheck, build,
  tests, whatever it defines) and report the result honestly.
- **If a check fails, the change is presumed wrong, not the check.** Don't
  regenerate expected outputs, loosen an assertion, or skip a test to get
  to green. A golden or snapshot diff is something to read and explain,
  not something to overwrite.
- Where a repo has no automated tests, say exactly what you ran by hand
  and what you saw; "works locally" is not reviewable.
- A test that has never been seen to fail proves nothing. When adding one,
  check that it fails when the thing it tests is broken.
- In any script that pipes a check's output (`cmd | tee log`), use
  `set -o pipefail`. Otherwise the pipe hides the command's exit code.

## Parallel sessions on one repo

Several sessions may work on the same repo at once if they do not collide.

- **Claim before starting.** Assign the issue to yourself, or add an
  `in-progress` label, and skip any card that already has one. "Todo" does
  not mean free. Two sessions taking "the next card" at once is the commonest
  failure.
- **One area per session.** Split cards by module or file set, not just by
  order. Don't start a card that overlaps files an open PR already touches;
  say so and ask.
- **Re-gate after syncing `main`.** Before merging, merge current `main`
  into the branch and re-run the full checks on the result. A clean git merge
  can still break behaviour; only the checks show it. Never merge on a CI
  result that predates the latest `main`.
- **Shared record files conflict by design** (backlog, changelog, `CLAUDE.md`).
  Keep entries small and in separate sections; whoever merges second resolves
  the conflict by keeping both sides, never by dropping the other session's
  entry.
- **State outside git is shared too:** database migrations (check the next
  number against `main` just before merging), lockfiles and generated files
  (regenerate with the repo's tooling, don't hand-merge), a shared dev
  database, ports, deploys. Run migrations and deploys only from the session
  that owns that area, and never against shared or production data from a
  session that doesn't.

## Design

- **Define a shared fact once and import it everywhere.** Two copies of a
  constant, schema or regex can drift apart without anyone noticing.
- A test fixture that encodes a belief about someone else's format proves
  only that belief. Check it against a real sample before trusting the
  tests built on it.
- Keep a change to what the task needs. Refactors, renames and dependency
  bumps that the task doesn't require go in their own issue and PR.

## Security and data

- No credentials, tokens or secrets in code, fixtures, logs or commit
  messages, in public or private repos. Read them from the environment.
- Say in the commit message whether the change adds outbound data flows,
  new dependencies or new permissions ("none" is an answer).
- Fixtures use synthetic data. Real client or personal data never goes in
  a fixture, even trimmed (see the public-repo rules in `CLAUDE.md`).

## AI output in code

- Generated code is a proposal: read it, run it, and be able to explain it
  before it goes in a PR.
- Never invent APIs, flags, package names or versions. Check the docs or
  the installed source; say so when you could not.
