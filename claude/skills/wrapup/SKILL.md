---
name: wrapup
description: Wrap up a ticket after its code is merged, also while the experiment or rollout is still waiting. Read its intent and fact files, the merged pull requests, the ticket and its epic. Then write a note about the problem, the logic, the change, the decisions and the next steps for monitoring and rollout. Save the note in the Obsidian vault under work/, and update the note of its epic. Add the ticket to the epic entry under the current quarter of the brag document. Use when the user says "wrap up", "wrap up the ticket", "summarize what we shipped", "write the brag entry", or invokes /wrapup.
---

# Wrapup

When the code of a ticket is merged, you write down what changed and why, and what to watch next. The experiment setup, the rollout and the first results usually come after the merge. They go into the note as next steps, not as results. The user uses the note to remember the work and to build the brag document for the performance review.

A ticket is usually one part of a Jira epic. The brag document shows the epic, because a reviewer reads the larger outcome, not each ticket. So the wrapup writes at two levels:

- The ticket note holds the detail of one ticket.
- The epic note joins the ticket notes of one epic. The brag entry is for the epic and links to the epic note.

A ticket with no epic gets its own brag entry that links to the ticket note, and no epic note.

The inputs are the files of the intent skill: `<ticket>-intent.md` (written by the user), `<ticket>-fact.md` and `<ticket>-test.md` (written by an agent), at the root of the main repo. The outputs are one ticket note, one epic note, and one bullet or entry in the brag document.

## Rules

- Read the vault `AGENTS.md` before your first vault write in the session. Its rules apply: write through the Obsidian CLI only, no `#` title heading, Simple English for all prose.
- Draft in the chat first. Write to the vault only after the user approves the draft.
- Keep the source on each claim, for example a pull request, a commit, a ticket or a dashboard. If you have no authoritative source for a claim, mark it as unverified. Never give an expected impact as a measured impact.
- Do not write credentials, secrets, customer data or personal data about other people. Name colleagues only by their role or as the user names them.
- Do not change code, the intent file, the fact file or the test file. Delete these three files only in the last step.
- Do not copy content between notes. The epic note links to the ticket notes and does not repeat their detail.

## Steps

1. Find the ticket and the files. Find the ticket key in this order, and use the first source that gives a key:
   1. The user's words or the skill arguments.
   2. The `TN` environment variable (`echo $TN`). A herdr space named after a ticket sets it, for example `TN=rad-885`. If `TN` is set, use it and do not ask the user. If the branch name has another key, use `TN` and say so in the chat.
   3. The current branch name.
   4. A single `*-intent.md` or `*-fact.md` file at the root of the current repo.
   5. Ask the user.

   Then find the files with step 2 of "Find the ticket and the files" in the intent skill. Say the ticket key and its source in one line before you start. If there is no fact file, continue with the ticket and the pull requests, and say so in the draft.

2. Find the epic. Read the Jira parent of the ticket. If no Jira tool is available, use the epic that the "Tickets" line or the decisions of the fact file name. Then read the epic: its summary, its description, and its child issues with their status (`parent = <EPIC>`). If the ticket has no epic, skip the epic steps below.

3. Check that the code is merged. For each repo in the "Repos" section of the fact file, find the pull requests with `gh pr list --state all --search <TICKET>`. If a pull request is still open, tell the user and ask if you must continue. The ticket status and the experiment state do not block the wrapup.

4. Check for earlier notes and entries:
   - Search the vault for a note of this ticket, for example `obsidian vault=vault search query="<TICKET>"`. If a note exists, update it instead of a new note. Update its Result and Monitoring sections.
   - Search the vault for the epic note, with `query="<EPIC>"`.
   - Read the brag document for the current year, `work/<YYYY> Brag Docs.md`. Find an entry with the epic key in its heading, and note the quarter it is in. Find a bullet for this ticket. If the ticket already has a bullet in the current quarter, do not add a second one.

5. Read what changed. For each merged pull request, read its description, its commits and its diff. Read the changed code that carries the main logic, not only the diff lines. Compare the result with the goal in the intent file and the plan in the fact file. If the pull request description names a change that the merged diff does not have, trust the diff and tell the user.

6. Read the state of the rollout. If the work has a feature flag or an experiment, read its state with a tool. At Rome2Rio, use the `r2r-itools` skill. Note the flags, their allocation, and the events or dashboards that measure the work. If no tool can read a system, write it down as unknown. If the experiment is not set up yet, make its setup the first monitoring item, with its owner. Mark each result as expected until a measure exists.

7. Interview the user. Ask only about what the sources cannot tell you. Ask at most four questions in a round. If you have a recommended answer, give it. These subjects often need the user:
   - the measured impact so far, or the date of the first measure
   - the people the user worked with, and the role the user played
   - what was hard, and what the user wants to do in a different way next time
   - feedback from stakeholders

8. Draft the ticket note in the chat. Use this structure. Leave out a section that has no content. If the ticket has no epic, leave out the `Epic` part.

   ```markdown
   ---
   tags:
     - work
     - ticket-summary
   ---

   Ticket: [<TICKET>](<Jira URL>). Epic: [[<EPIC> <Epic Short Title>]]. Shipped: <YYYY-MM-DD>. Repos: <repo names>. Pull requests: <links>

   ## Problem
   <Why the work was necessary, in two to four sentences.>

   ## What changed
   <The new behavior for users or the business, then the main logic: the parts, how data and control flow between them, and the important files.>

   ## Decisions
   - <The decision and its reason.> By: <person>

   ## Result
   - <A measured result.> Source: <dashboard, query or report>
   - <An expected result.> Unverified until: <date or measure>

   ## Monitoring and next steps
   - [ ] <What to watch or do, for example a metric, a guardrail, an allocation change or a follow-up ticket.> When: <date or trigger>. Where: <dashboard, tool or ticket>

   ## Learnings
   - <What worked, what was hard, and what to do in a different way next time.>

   ## Links
   - <Related vault notes, as wiki-links>
   ```

9. Draft the epic note in the chat. If the note exists, draft the change to it. The note is at `work/<EPIC> <Epic Short Title>.md`. Use this structure:

   ```markdown
   ---
   tags:
     - work
     - epic-summary
   ---

   Epic: [<EPIC>](<Jira URL>). Status: <Jira status>. Updated: <YYYY-MM-DD>

   ## Goal
   <The goal and the success measure of the epic, in two to four sentences, from the epic description.>

   ## Tickets
   - [x] <TICKET>: <one line on what it delivers>. [[<TICKET> <Short Title>]]
   - [ ] <TICKET>: <summary>. Status: <Jira status>

   ## Delivered so far
   <What the epic gives users or the business with the tickets that are done, in two to five sentences. State measured and expected results apart.>

   ## Open across tickets
   - <A risk, a dependency or a monitoring item that more than one ticket needs, with a link to the ticket note that owns it.>
   ```

   - List each child issue of the epic. A ticket with a note is `[x]` and links to the note.
   - If the epic note exists, change only the ticket line of this ticket, the Status and Updated values, "Delivered so far" and "Open across tickets". Keep all other text as it is.

10. Draft the brag change in the chat. The entry heading is `### <Epic title> (<EPIC>)`. Each bullet states what the user did and its effect, in the style of the existing entries.
    - If the epic entry is in the current quarter, add one bullet for this ticket: `<TICKET>: <what the user did and its effect>`.
    - If the epic entry is only in an earlier quarter, or there is none, make a new entry in the current quarter. It has a bullet for this ticket and at most one bullet for the role of the user in the epic. Its last bullet links to the epic note: `Note: [[<EPIC> <Epic Short Title>]]`. An earlier quarter keeps its own entry, so each quarter shows the work done in it.
    - If this ticket is the last open child of the epic, offer a rewrite of the epic entry of the current quarter. The rewrite has two to five outcome bullets.
    - If the ticket has no epic, the entry is a `###` heading with the short title of the ticket, and two to five bullets. The last bullet links to the ticket note.

11. Ask the user to approve or change all drafts.

12. Write to the vault on the MacBook:
    1. Create the ticket note with `obsidian vault=vault create path="work/<TICKET> <Short Title>.md" content="<text>"`. Use a human-readable title. Use `\n` for a new line.
    2. Create the epic note with `obsidian vault=vault create path="<path>" content="<text>"`. To change an existing epic note, read it, apply the approved change to its full text, and write it with `create path="<path>" content="<text>" overwrite`.
    3. If the brag document does not exist, ask the user before you create it.
    4. To add a bullet to an entry in the current quarter, use `obsidian vault=vault append path="<brag path>" heading="<entry heading text>" content="- <bullet>"`. The `Note:` bullet must stay last. If the append puts the new bullet after it, rewrite the document as in step 5.
    5. To add a new entry, a new quarter section or a rewritten entry, read the whole brag document first. Apply the change to its full text and write it with `create path="<brag path>" content="<text>" overwrite`. A new quarter goes above the newest quarter heading, below the frontmatter and the intro text. A new entry goes directly below the `## Q<n>` heading of the current quarter.
    6. Read each changed file back with `obsidian vault=vault read path="<path>"`. Compare it with the text before your write. The only differences must be the approved changes. If a write went to the wrong place or failed, stop and tell the user. Do not repair the file with filesystem tools.

13. Log the work. Append one entry to the memory log with the rules of the `remember` skill.

14. Report in the chat. Give the paths of the ticket note and the epic note, and the brag change. Give the open monitoring items with their dates, and each claim that is still unverified.

15. Delete the intent, fact and test files (`<ticket>-intent.md`, `<ticket>-fact.md` and `<ticket>-test.md`). The ticket note now holds what they had. Do this step only after each vault write in step 12 read back correctly. If a file is tracked in Git, tell the user and do not delete it.
