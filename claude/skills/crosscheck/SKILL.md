---
name: crosscheck
description: Cross-check the plan of one ticket with a second agent. Start Codex CLI (model gpt-6.1-sol) in a herdr terminal, and let it review <ticket>-fact.md and <ticket>-intent.md against the code, read-only. Then make sure that each finding is true, update the fact file with the findings that are true, and report the rest in the chat. Triggers: /crosscheck, "cross-check the plan", "have Codex check the plan", "second opinion on the plan". Run it after /intent plan. Needs herdr ($HC_TERMINAL_ID).
---

# Crosscheck

A second agent reads the plan with no knowledge of this conversation. It finds facts that are wrong, gaps in the plan, and "Done when" lines that nobody can test. You then decide which findings are true. A finding from Codex is a claim, not a fact.

The inputs are the files of the intent skill: `<ticket>-intent.md` (written by the user) and `<ticket>-fact.md` (written by an agent), at the root of the main repo.

## Rules

- Codex reads only. It changes no file in a repo. It writes only its report file.
- Codex is your child in herdr. The user can open its terminal and type into it. Run it interactive, never with `codex exec`.
- You change only the fact file. Report faults in the intent file in the chat, as the intent skill does.
- If you are not sure that a finding is true, and you have no authoritative source, say that it is unverified.

## Steps

1. Make sure that you run inside herdr. If `$HC_TERMINAL_ID` is empty, tell the user and stop. Read the herdr-agents skill for the `hc` commands.

2. Find the ticket and the files. Use the steps in "Find the ticket and the files" of the intent skill. If there is no fact file, tell the user to run `/intent plan` first, and stop.

3. Make a report path: `<dir>/<ticket>-crosscheck.md`. Use your scratchpad directory as `<dir>`. If you have no scratchpad, make a directory with `mktemp -d`.

4. Start Codex in the main repo. Expand `$HC_TERMINAL_ID`, the paths and the ticket in the task before you run it:

   ```sh
   hc run --bg --name crosscheck-<ticket> --cwd <main repo> \
     codex --no-daemon -m gpt-6.1-sol -s workspace-write --add-dir <report dir> "<task>"
   ```

   Use this task:

   ```text
   Cross-check the plan for <TICKET>. Read <ticket>-intent.md and <ticket>-fact.md at the repo root, the repo's CLAUDE.md or AGENTS.md, and the code that the fact file names. Read-only: do not change any file in this repo, do not commit, and do not start other agents.

   Check these points:
   1. Each fact: open its source and say if it is still true. Give file:line.
   2. Each inference: say if the code settles it, and how.
   3. Decisions against the plan: find a plan item that breaks a decision, and a decision that no plan item carries out.
   4. The plan against the intent goal: find a goal that no plan item covers, and a plan item that no goal asks for.
   5. Gaps: code paths, callers, tests, launch arguments or edge cases that the plan does not name but that the change touches. Search the code for them.
   6. Each "Done when" line: say if a person can test it as written.
   7. The order of the plan items, and the risks of the change.

   Write the report to <report path>. For each finding, give: the number of the point, a severity (high, medium or low), the item or line in the fact file, the evidence with file:line, and a suggested change. Put the facts that you confirmed in one short list at the end. Mark each claim without a source in the code as unverified.

   When the report is written, end your turn. Do not run hc send.
   ```

5. Read `first_message.sent` in the JSON result. If it is `false`, follow the herdr-agents skill: read the screen, fix the cause, then send the task.

6. Wait with `hc wait --children any`. The Codex sandbox blocks `hc send`, so Codex does not message you. The status `done` shows that its turn ended. Repeat on `reason: timeout`. If the child is `blocked`, read its screen with `hc read crosscheck-<ticket> --lines 60` and ask the user. Do not approve a permission prompt for the user. Ask the user at once with your question tool, and quote what the prompt asks, so that the user gets a notification. If `hc get` shows status `null` for the child, the Codex status hooks do not work. Then read its screen at each `reason: timeout` to find a prompt.

7. Read the report file. If the file does not exist, read the screen of the child and find out why.

8. Make sure that each finding is true. Open the evidence that Codex gives, and read the code around it. Sort each finding:
   - True: the evidence shows it.
   - False: the evidence shows something else. Note why.
   - Unverified: neither of you can settle it with a source. Name what can settle it.

   If you disagree with a high finding, send your reason to Codex with `hc send crosscheck-<ticket> "<reason>"`, and wait for its answer once. Then decide.

9. Update the fact file with the true findings, in the short style that the intent skill sets: correct the facts, move settled inferences to facts, and change or add plan items with their "Done when" lines. Follow the file rules of the intent skill. If a true finding needs a decision from the user, add it under "Open decisions" and do not decide it.

10. Report in the chat as a short summary. If the user asks for detail, give it:
    1. One line: how many findings were true, false and unverified.
    2. The new information, one short line each. Do not list each edit of the fact file.
    3. The false findings, each with your reason.
    4. The unverified findings, each with what can settle it.
    5. The faults in the intent file, quoted, with a suggested fix.
    6. The new open decisions.

11. Ask the user to accept or reject the result. If the user accepts it, end the child: `hc kill crosscheck-<ticket>; hc rm crosscheck-<ticket>`. If the user rejects it, keep the child, so the user or you can send it more questions.
