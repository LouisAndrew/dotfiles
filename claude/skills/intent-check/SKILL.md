---
name: intent-check
description: Evaluate the current branch against the INTENT.md file at the repo root. The user writes INTENT.md by hand with a goal, Jira links and a todo checklist. Check off only the todo items that evidence shows are done, and give every comment in the chat. Use when the user says "check intent", "evaluate INTENT.md", "are we done", "did we meet the intent", or invokes /intent-check.
---

# Intent check

The user keeps an `INTENT.md` file at the root of the repo. The user writes all of it by hand: the goal, the context, links to Jira tickets, and a todo checklist. You compare the work on the current branch with that file. You tell the user if the branch meets the goal, and you check off the todo items that are done.

## The editing rule

You change `INTENT.md` in one way only: you replace `[ ]` with `[x]` on a todo line that evidence shows is done. Nothing else in the file changes.

- Do not edit, add, remove, reorder or reformat any other text, including typos and style problems. The prose belongs to the user.
- Do not uncheck a box. If the user checked an item and your evidence disagrees, say so in the chat.
- Do not add notes, dates or comments to the file. Every comment goes in the chat.
- Do not stage or commit `INTENT.md`.
- If a writing-style hook or linter flags the prose in `INTENT.md` after your edit, do not fix it. Tell the user in one line that you left the prose as written.

## Steps

1. Find the file. Run `git rev-parse --show-toplevel` and read `INTENT.md` there. If the file does not exist, tell the user and stop. Do not create it.

2. Save a copy of the file in your scratchpad directory before you edit it. You use it in step 7.

3. Read the intent. Note the goal and the scope, for example the modes, products or platforms that it names. Also note the named feature flags or configuration, and every todo item with its children.

4. Read the linked tickets. If the file links Jira issues and a Jira tool is available, read each issue and its acceptance criteria. If no Jira tool is available, say so in the report and continue with the file alone.

5. Collect the evidence from the branch:
   - Find the base: `git merge-base HEAD origin/<default branch>`. Get the default branch from `git symbolic-ref refs/remotes/origin/HEAD`.
   - Read the committed changes since the base (`git log` and `git diff <base>...HEAD`) and the uncommitted changes (`git status`, `git diff`, and the untracked files).
   - Read the changed code that relates to each todo item, not only the diff lines.
   - When an item depends on behavior, find the test that covers it. If you can run that test in under a few minutes, run it. Use the repo's own commands from its `AGENTS.md` or `CLAUDE.md`.

6. Decide each todo item. If you have direct evidence that an item is done, check it. These are the evidence rules:
   - A code item needs the code in the branch and, for behavior, a test or a run that shows it works.
   - Some items are in an external system, for example GAM, an experiment dashboard, a feature flag service or a deploy. Such an item needs evidence from a tool that reads that system, or evidence from the user in this conversation, such as a screenshot. If you cannot see the system, leave the item unchecked and name the evidence that settles it.
   - If all children of a parent item are checked, check the parent. If a parent has no children, it needs its own evidence.
   - If you are not sure, leave the item unchecked and explain in the chat.

7. Edit the file. Change each done item from `[ ]` to `[x]` with an exact edit of that line. Then compare the file with the copy from step 2. The only differences must be `[ ]` that became `[x]`. If anything else changed, restore the copy and edit again.

## The report

Give the report in the chat:

1. The verdict first: is the goal in `INTENT.md` met, partly met or not met, in one or two sentences.
2. The items you checked, each with its evidence (a file path, a test name, a command result or the user's screenshot).
3. The items you left unchecked, each with what is missing or the evidence that settles it.
4. Items the user checked that the evidence does not support. Say what you found, and leave the box as it is.
5. Gaps between the intent and the work. Name scope in the intent that the branch does not cover, and work in the branch that the intent does not ask for. Also name contradictions inside the intent, for example two different lists of modes.
6. Loose ends that affect the goal, for example uncommitted work, failing checks, or a missing translation step.

Keep the report short. Do not restate the whole intent.
