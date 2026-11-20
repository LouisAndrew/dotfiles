---
name: pr-description
description: >-
  Write a copyable Markdown pull-request description from the changes on the current branch, in any
  repo. Uses the repo's PR template when one exists. Use when asked to "create a PR description",
  "write the PR body", "draft the PR", or "give me a copyable PR description".
---

# PR description from branch changes

This skill writes a full PR description as one fenced Markdown block that the user can copy.
It does not open, create, or edit the PR.

## Procedure

1. Find the base branch. Use `master` or `main`, whichever exists. If the user names a base, use it.
2. Collect the branch changes:
   - `git log <base>..HEAD --oneline` for the commits.
   - `git diff <base>...HEAD --stat` for the changed files.
   - `git diff <base>...HEAD` for the full diff. Skip lockfile bodies, and read only their stat.
   - `git status --short` for uncommitted changes. If there are any, ask the user if the
     description must include them.
3. Find a ticket key (for example `PROJECT-123`) in the branch name, the commit messages, or the diff.
4. Find the PR template. Look in this order:
   - `.github/pull_request_template.md`
   - `.github/PULL_REQUEST_TEMPLATE.md`
   - `.github/PULL_REQUEST_TEMPLATE/*.md`
   - `docs/pull_request_template.md`
   - `pull_request_template.md`
5. If a template exists, keep its headings and order. Fill each section and remove its HTML comments.
   Follow any instructions that the comments give, for example bullet limits.
6. If no template exists, use the default layout below.
7. Write the description (see the writing rules).
8. Give the output as one fenced `markdown` code block. Before the block, say in one sentence what
   the user must fill by hand, for example a missing ticket key or screenshots.

## Default layout

```markdown
<One short paragraph: what changed, why, and the impact. Two or three sentences.>

**Ticket:** <link or key>

## Summary of changes

- <bullets grouped by theme>

## Testing

- <what to test and any setup it needs>
```

## Writing rules

- Base every statement on the diff and the commits. Do not invent behavior, metrics, or results.
- Keep it short. A reviewer reads the diff for the detail.
- Write the opening paragraph in one or two short sentences.
- Group the summary bullets by theme, not one bullet per file. Use 6 bullets at most.
- Keep each bullet to one line of about 15 words. State what changed. Do not explain how or
  list every value, and do not use sub-bullets.
- Write version bumps as `old → new`.
- If you do not know a ticket key, keep the template placeholder and tell the user.
- Keep the testing section to two to four one-line bullets: what to test and any setup it needs, for
  example flags, regions, fresh installs, rebuilds, or devices. Do not write a numbered
  step-by-step plan with expected results, even if the template comment asks for one.
- Do not say that tests or checks passed unless you ran them in this session.
- Leave screenshot tables and metrics sections empty. The author fills them.
- End the description with the PR attribution line from the session instructions, if one is given.
