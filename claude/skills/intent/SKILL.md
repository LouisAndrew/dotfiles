---
name: intent
description: Plan and check the work of one ticket against <ticket>-intent.md and <ticket>-fact.md, for example rad-884-intent.md and rad-884-fact.md. The files live at the root of the main repo, and other repos in the same work share them. The user writes the intent file by hand. The agent writes the fact file. Plan mode runs before development. It gathers the facts and interviews the user about each point that is not clear. It writes the facts, decisions and plan to the fact file, and reports faults in the intent file in the chat. Check mode runs after development. It compares the branches of all repos in the work with both files and checks off only the items that evidence shows are done. Use plan mode for "brainstorm the intent", "plan the intent", "what do we need before we start", "gather the facts", "interview me", or /intent plan. Use check mode for "check intent", "are we done", "did we meet the intent", or /intent check. When the code is merged, the wrapup skill summarizes it.
---

# Intent

Two files describe the work of one ticket:

- `<ticket>-intent.md` is the user's document. The user writes all of it by hand: the goal, the context, links to Jira tickets, and an optional todo checklist. You never write its prose.
- `<ticket>-fact.md` is your document. It holds the repos, the facts with their sources, the decisions, the open decisions and the plan. Plan mode writes it. Check mode, later development and the wrapup skill read it, so it must make sense to an agent that did not see this conversation.

`<ticket>` is the Jira key in lowercase, for example `rad-884`. Both files live at the root of the main repo. The main repo is the repo where the work starts.

The skill has two modes:

- Plan mode, before development: you gather the facts, interview the user, write the fact file, and report faults in the intent file in the chat.
- Check mode, after development: you compare the branches with both files and check off the items that are done.

## Find the ticket and the files

1. Find the ticket key. Use the first of these that gives a key:
   1. The user's words or the skill arguments.
   2. The current branch name. Look for a key such as `RAD-884`.
   3. A single `*-intent.md` or `*-fact.md` file at the root of the current repo.
   4. Ask the user.
2. Find the files. Look at the root of the current repo first (`git rev-parse --show-toplevel`). If they are not there, look at the root of each sibling repo, for example `ls ~/dev/*/<ticket>-intent.md ~/dev/*/<ticket>-fact.md`. If you find the files in more than one repo, ask the user which repo is the main repo.
3. If the files are not in any repo, the current repo is the main repo. Plan mode creates the fact file there. Do not create the intent file. Tell the user its path, so the user can write it.

Say the ticket, the main repo and the mode in one line before you start.

## Pick the mode

1. If the user names the mode, use it.
2. If the user does not name it:
   - If the fact file does not exist, use plan mode.
   - If the fact file exists and a repo in its "Repos" section has changes since its base, use check mode.
   - If you cannot tell, ask the user which mode to use.

## The file rules

For the intent file:

- In plan mode, do not change it. Give each fault you find in the chat.
- In check mode, change it in one way only: replace `[ ]` with `[x]` on a todo line that evidence shows is done.
- Do not add notes, dates or comments to it. Do not fix its typos or style.
- If a writing-style hook or linter flags its prose after your edit, do not fix it. Tell the user in one line that you left the prose as written.

For the fact file:

- You own the file. Plan mode creates it or rewrites it.
- Use no H1 heading. Use H2 and H3 headings only.
- Keep it short. One line for each fact, decision and open decision. A plan item is a one-line title, at most three short sub-points, and a one-line "Done when". Leave out the detail that only matters during coding. If the user asks for detail, add it.
- Keep the source on each fact, so a reader can check the fact again.
- When you rewrite the file, keep the checked items of the plan checked, unless the plan item itself changed.
- Do not uncheck an item that the user checked. If your evidence disagrees, say so in the chat.

For both files: do not stage or commit them. The user decides about Git.

## Plan mode

The job is to find out what is true and what is still open before any code changes. Do not change code in plan mode.

### Steps

1. Read the starting point. This is the user's words, the intent file, an existing fact file, or all three. Note the goal, the tickets, and the scope that the user names. If the fact file exists, start from it and check that its facts are still true.

2. Find the repos. The work can touch more than one repo, for example an app and a backend. Find each repo that the goal touches, from the ticket, the user's words and the code. If you are not sure that a repo is part of the work, ask the user in the interview.

3. Read the tickets. If a Jira tool is available, read each linked issue, its acceptance criteria, and the issues that it links to. If a file names a ticket key without a link, read that issue too. If no Jira tool is available, say so and continue.

4. Gather the facts from the code. For each part of the goal, find the code in each repo that does it now. Write down its current behavior with a `<repo>:file:line` reference. Read each repo's `CLAUDE.md` or `AGENTS.md` for its rules and commands. If the code search covers many files, use a subagent and keep only its conclusions.

5. Gather the facts from outside the code. This includes feature flags, experiments, ad servers, analytics schemas, dashboards and earlier decisions in Confluence or the vault. If a tool can read the system, use it. If no tool can read it, write the fact down as unknown and name who or what can settle it.

6. Separate facts from inferences. A fact has a source that a reader can open: a `file:line`, a ticket, a page, a tool result, or a person in this conversation. If a statement comes from your own knowledge or reasoning, mark it as an inference, or check it with a tool first. Never give an inference as a fact.

7. Compare the sources. Find the places where the ticket, the intent file, the user's words and the code do not agree. Find the decisions that the ticket says are open. Find the scope that one source names and another does not.

8. Interview the user. Make a list of each point that is still not clear after steps 1 to 7. Then ask the user about the points in rounds, until no point stays unclear.

   - If one of these subjects is not clear, ask about it:
     - the reason for the work, and the result that tells the user it worked
     - the scope edges, for example which repos, platforms, screens or users are in
     - priorities and limits, for example a deadline, a release or a budget
     - decisions that are the user's to make, for example a choice between two designs
     - facts that only the user knows, for example a contact, a plan or the state of an outside system
   - Do not ask about a fact that the code, a ticket or a tool can tell you. Find it yourself.
   - Ask at most four questions in a round. Say in each question why the answer changes the plan. If you have a recommended answer, give it.
   - Use each answer before the next round. An answer can settle a point, start a new point, or show that you must read more code or another ticket.
   - If the user questions a requirement, find its source and its reason. Give both, and say which parts are facts and which are inferences.
   - If the user cannot answer a point, write it down as an open decision with its owner.
   - If each point is settled or is an open decision, stop the interview. If the user tells you to stop, also stop.

9. Write the fact file with these sections:

   ```markdown
   Facts for <TICKET>: <short title>. Updated: <YYYY-MM-DD>. Intent: <ticket>-intent.md. Tickets: <keys>

   ## Repos
   - <repo name> (main): <path>. Branch: <branch, or "not created yet">
   - <repo name>: <path>. Branch: <branch>

   ## Scope
   In: <repos, platforms, screens, placements, modes>
   Out: <what this work does not do>

   ## Facts
   - <A fact.> Source: <repo:file:line, ticket key, page, tool result, or person>

   ## Inferences
   - <A statement that is probably true but has no source yet.> Check with: <tool, page or person>

   ## Decisions
   - <The decision.> By: <person>, <YYYY-MM-DD>

   ## Open decisions
   - <The decision.> Owner: <person or team>. Default: <what the plan assumes until it is decided>. Blocks: <the plan items that wait for it>

   ## Plan
   - [ ] <repo name>: <An item that one person can do and someone can verify.>
     Done when: <the evidence, for example a test name, a log line, a dashboard value or a screenshot>
   ```

   Rules for the plan:

   - Give each item a "Done when" line. Check mode uses that line as the evidence rule for the item.
   - Start each item with the repo that it changes. An item outside the code, for example a decision or a flag, names the system instead.
   - Put the items that must happen before development first: decisions, access, flag setup and the collection of data.
   - Include the items in external systems, for example "create the flag in the experiments dashboard".
   - Keep each item small enough to finish in one pull request or less.

10. Report in the chat as a short summary. If the user asks for detail, give it:

    1. The path of the fact file and one line on what it holds.
    2. The faults in the intent file. For each fault, quote the line, say what is wrong, and suggest a fix. Leave the change to the user. These are faults:
       - a line that a fact or a decision contradicts
       - a goal with no result that someone can measure
       - a scope that disagrees with the ticket
       - a todo item with no clear end
    3. What is still open before development can start.
    4. If `$HC_TERMINAL_ID` is set, offer the crosscheck skill, so that Codex reviews the plan.

## Check mode

### Steps

1. Find the files with the steps in "Find the ticket and the files". If neither file exists, tell the user and offer plan mode. Do not create a file in check mode.

2. Save a copy of each file in your scratchpad directory before you edit it. You use the copies in step 7.

3. Read the intent and the plan. Note the goal and the scope in the intent file. Note every todo item in the intent file and every plan item in the fact file, each with its children and its "Done when" line. Note the repos and the open decisions in the fact file.

4. Read the linked tickets. If a file links Jira issues or names a ticket key and a Jira tool is available, read each issue and its acceptance criteria. If no Jira tool is available, say so in the report and continue with the files alone.

5. Collect the evidence from each repo in the "Repos" section:
   - Find the base: `git merge-base HEAD origin/<default branch>`. Get the default branch from `git symbolic-ref refs/remotes/origin/HEAD`. Use the branch that the fact file names. If that branch is merged, read its pull request with `gh pr list --state merged --search <TICKET>`.
   - Read the committed changes since the base (`git log` and `git diff <base>...HEAD`) and the uncommitted changes (`git status`, `git diff`, and the untracked files).
   - Read the changed code that relates to each item, not only the diff lines.
   - When an item depends on behavior, find the test that covers it. If you can run that test in under a few minutes, run it. Use the repo's own commands from its `AGENTS.md` or `CLAUDE.md`.

6. Decide each item in both files. If you have direct evidence that an item is done, check it. These are the evidence rules:
   - If the item has a "Done when" line, that line sets the evidence that you need.
   - A code item needs the code in the branch of its repo and, for behavior, a test or a run that shows it works.
   - Some items are in an external system, for example GAM, an experiment dashboard, a feature flag service or a deploy. Such an item needs evidence from a tool that reads that system, or evidence from the user in this conversation, such as a screenshot. If you cannot see the system, leave the item unchecked and name the evidence that settles it.
   - If all children of a parent item are checked, check the parent. If a parent has no children, it needs its own evidence.
   - If you are not sure, leave the item unchecked and explain in the chat.

7. Edit the files. Change each done item from `[ ]` to `[x]` with an exact edit of that line. Then compare each file with its copy from step 2. The only differences must be `[ ]` that became `[x]`. If anything else changed, restore the copy and edit again.

### The report

Give the report in the chat:

1. The verdict first: is the goal in the intent file met, partly met or not met, in one or two sentences.
2. The items you checked, each with its evidence (a file path, a test name, a command result or the user's screenshot).
3. The items you left unchecked, each with what is missing or the evidence that settles it.
4. Items the user checked that the evidence does not support. Say what you found, and leave the box as it is.
5. Gaps between the intent and the work. Name scope in the intent that no branch covers, and work in a branch that the intent does not ask for. Also name contradictions inside the intent, for example two different lists of modes.
6. If a decision in the fact file is still open and it affects the verdict, name it.
7. If a fact in the fact file is no longer true, name it and offer plan mode to update the file.
8. Loose ends that affect the goal, for example uncommitted work, failing checks, or a missing translation step.
9. If the goal is met and all pull requests are merged, offer the wrapup skill.

Keep the report short. Do not restate the whole intent.
