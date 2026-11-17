---
name: wrapup
description: Wrap up a ticket after its code is merged, also while the experiment or rollout is still waiting. Read its intent and fact files, the merged pull requests and the ticket. Then write a note about the problem, the logic, the change, the decisions and the next steps for monitoring and rollout. Save the note in the Obsidian vault under work/, and add a short entry under the current quarter of the brag document. Use when the user says "wrap up", "wrap up the ticket", "summarize what we shipped", "write the brag entry", or invokes /wrapup.
---

# Wrapup

When the code of a ticket is merged, you write down what changed and why, and what to watch next. The experiment setup, the rollout and the first results usually come after the merge. They go into the note as next steps, not as results. The user uses the note to remember the work and to build the brag document for the performance review.

The inputs are the files of the intent skill: `<ticket>-intent.md` (written by the user) and `<ticket>-fact.md` (written by an agent), at the root of the main repo. The output is one note in the Obsidian vault and one entry in the brag document.

## Rules

- Read the vault `AGENTS.md` before your first vault write in the session. Its rules apply: write through the Obsidian CLI only, no `#` title heading, Simple English for all prose.
- Draft in the chat first. Write to the vault only after the user approves the draft.
- Keep the source on each claim, for example a pull request, a commit, a ticket or a dashboard. If you have no authoritative source for a claim, mark it as unverified. Never give an expected impact as a measured impact.
- Do not write credentials, secrets, customer data or personal data about other people. Name colleagues only by their role or as the user names them.
- Do not change code, the intent file or the fact file.

## Steps

1. Find the ticket and the files. Use the steps in "Find the ticket and the files" of the intent skill. If there is no fact file, continue with the ticket and the pull requests, and say so in the draft.

2. Check that the code is merged. For each repo in the "Repos" section of the fact file, find the pull requests with `gh pr list --state all --search <TICKET>`. If a pull request is still open, tell the user and ask if you must continue. The ticket status and the experiment state do not block the wrapup.

3. Check for an earlier note. Search the vault for a note of this ticket, for example `obsidian vault=vault search query="<TICKET>"`. If a note exists, update it instead of a new note. Update its Result and Monitoring sections, and do not add a second brag entry.

4. Read what changed. For each merged pull request, read its description, its commits and its diff. Read the changed code that carries the main logic, not only the diff lines. Compare the result with the goal in the intent file and the plan in the fact file.

5. Read the state of the rollout. If the work has a feature flag or an experiment, read its state with a tool. At Rome2Rio, use the `r2r-itools` skill. Note the flags, their allocation, and the events or dashboards that measure the work. If no tool can read a system, write it down as unknown. If the experiment is not set up yet, make its setup the first monitoring item, with its owner. Mark each result as expected until a measure exists.

6. Interview the user. Ask only about what the sources cannot tell you. Ask at most four questions in a round. If you have a recommended answer, give it. These subjects often need the user:
   - the measured impact so far, or the date of the first measure
   - the people the user worked with, and the role the user played
   - what was hard, and what the user wants to do in a different way next time
   - feedback from stakeholders

7. Draft the note in the chat. Use this structure. Leave out a section that has no content.

   ```markdown
   ---
   tags:
     - work
     - ticket-summary
   ---

   Ticket: [<TICKET>](<Jira URL>). Shipped: <YYYY-MM-DD>. Repos: <repo names>. Pull requests: <links>

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
   - Intent and facts: `<main repo>/<ticket>-intent.md`, `<main repo>/<ticket>-fact.md`
   - <Related vault notes, as wiki-links>
   ```

8. Draft the brag entry in the chat. It is a `###` heading with the short title, and two to five bullets. Each bullet states what the user did and its effect, in the style of the existing entries. The last bullet links to the note.

9. Ask the user to approve or change both drafts.

10. Write to the vault on the MacBook:
   1. Create the note at `work/<TICKET> <Short Title>.md` with `obsidian vault=vault create path="<path>" content="<text>"`. Use a human-readable title. Use `\n` for a new line.
   2. Find the brag document for the current year, `work/<YYYY> Brag Docs.md`. If it does not exist, ask the user before you create it.
   3. If the document has a `## Q<n>` heading for the current quarter, add the entry with `obsidian vault=vault append path="<path>" heading="Q<n>" content="<text>"`.
   4. If the heading does not exist, add the section with `obsidian vault=vault prepend path="<path>" content="## Q<n>\n\n<entry>"`. The newest quarter comes first in the document.
   5. Read both files back with `obsidian vault=vault read path="<path>"`. Make sure that the note is complete and that the entry is under the correct heading. If a write went to the wrong place or failed, stop and tell the user. Do not repair the file with filesystem tools.

11. Log the work. Append one entry to the memory log with the rules of the `remember` skill.

12. Report in the chat: the path of the note, the brag entry, the open monitoring items with their dates, and any claim that is still unverified. Ask the user what to do with the intent and fact files. Do not delete them yourself.
