---
name: codex-review
allowed-tools: Bash(hc:*), Skill(herdr-agents)
description: Let Codex review the code of the current branch after development. Codex says whether the code does what the ticket intended. Start Codex CLI (model gpt-6.1-sol, medium reasoning) in a herdr terminal. It reads the branch changes and <ticket>-intent.md and <ticket>-fact.md, read-only, and writes a report. Then make sure that each finding is true, and report the result in the chat. Triggers: /codex-review, "have Codex review the code", "Codex review", "did we do what was intended", "second opinion on the branch". Run it after development and before /intent check or a pull request. Needs herdr ($HC_TERMINAL_ID).
---

A second agent reviews the branch with no knowledge of this conversation. It finds bugs in the changes, and it compares the changes with the intent of the ticket. You then decide which findings are true. A finding from Codex is a claim, not a fact.

This skill does not check off plan items. The intent skill does that in check mode. This skill gives the review that check mode and the pull request can use.

## Rules

- Codex reads only. It changes no file in a repo. It writes only its report file.
- Always use the model gpt-6.1-sol with medium reasoning. Do not change the model or the reasoning effort.
- The skill allows all `hc` commands and the herdr-agents skill without a permission prompt.
- You approve each Codex permission prompt that the review needs, without a question to the user. The review needs these actions:
  - Read a file.
  - Run a git command that changes nothing: `diff`, `log`, `show`, `status`, `blame` or `merge-base`.
  - Run the build and test commands of the repo.
  - Write the report file.

  For each other action, ask the user.
- Codex is your child in herdr. The user can open its terminal and type into it. Run it interactive, never with `codex exec`.
- You change no file in this skill. You report in the chat. If the user asks, you fix the true findings after the report.
- If you are not sure that a finding is true, and you have no authoritative source, say that it is unverified.

## Steps

1. Make sure that you run inside herdr. If `$HC_TERMINAL_ID` is empty, tell the user and stop. Read the herdr-agents skill for the `hc` commands.

2. Find the ticket and the files. Use the steps in "Find the ticket and the files" of the intent skill. If there is no intent file and no fact file, ask the user for the goal in one or two sentences. If the user gives no goal, Codex reviews for bugs only, and the report says that no intent was checked.

3. Find the changes in each repo. Use the repos in the "Repos" section of the fact file. If there is no fact file, use the current repo.
   - Find the base: `git merge-base HEAD origin/<default branch>`. Get the default branch from `git symbolic-ref refs/remotes/origin/HEAD`.
   - The changes are the commits since the base, the uncommitted changes and the untracked files. Leave out the intent file, the fact file and other planning files.
   - If there are no changes, tell the user and stop.

4. Make a report path: `<dir>/<ticket>-codex-review.md`. Use your scratchpad directory as `<dir>`. If you have no scratchpad, make a directory with `mktemp -d`. If there is no ticket, use the branch name in place of `<ticket>`.

5. Start Codex in the main repo. Expand `$HC_TERMINAL_ID`, the paths, the base and the ticket in the task before you run it. If the work has more than one repo, add each other repo with one more `--add-dir`. Name each repo and its base in the task.

   ```sh
   hc run --bg --name codex-review-<ticket> --cwd <main repo> \
     codex --no-daemon -m gpt-6.1-sol -c model_reasoning_effort=medium -s workspace-write --add-dir <report dir> "<task>"
   ```

   Use this task. If there is no intent file, replace the intent files with the user's goal, or remove points 2 to 4 if there is no goal:

   ```text
   Review the code changes for <TICKET>, and say if they do what was intended. Read-only: do not change any file in this repo, do not commit, do not run a formatter, and do not start other agents. You can run the repo's build and test commands.

   Read <ticket>-intent.md and <ticket>-fact.md at the repo root, and the repo's CLAUDE.md or AGENTS.md. The changes are: git diff <base>...HEAD, the uncommitted changes (git diff, git diff --staged) and the untracked files (git status). Read the whole changed files and their callers, not only the diff lines. Ignore the intent and fact files as code.

   Check these points:
   1. Bugs: a wrong result, a crash, a race, a leak, or a broken caller. Give the input or the state that causes it.
   2. Intent: for each goal in the intent file and each plan item in the fact file, say if the changes do it. Give file:line as evidence, or say what is missing.
   3. Decisions: find a change that breaks a decision in the fact file.
   4. Scope: find a change that no goal or plan item asks for, and scope that the fact file puts out of scope.
   5. Tests: for each behavior in points 2 and 3, name the test that covers it, or say that no test covers it. Run the tests that cover the changes, and report the result.
   6. Repo rules: find a change that breaks a rule in CLAUDE.md or AGENTS.md.

   Write the report to <report path>. Start with a verdict in one or two sentences: are the goals met, partly met, or not met. Then, for each finding, give: the number of the point, a severity (high, medium or low), the file:line, the evidence, and a suggested fix. Put the goals and plan items that you confirmed in one short list at the end. Mark each claim without a source in the code as unverified.

   When the report is written, end your turn. Do not run hc send.
   ```

6. Read `first_message.sent` in the JSON result. If it is `false`, follow the herdr-agents skill: read the screen, fix the cause, then send the task. Then show the child in a split pane beside you. Use the address of the child from the JSON result, for example `t7`: `herdr-app do terminal.keep '{"terminal":"t7","place":"right"}'`. Without this step, the child is a sub-agent with no pane. If the command fails, tell the user and continue.

7. Wait with `hc wait --children any`. The Codex sandbox blocks `hc send`, so Codex does not message you. The status `done` shows that its turn ended. Repeat on `reason: timeout`. If the child is `blocked`, read its screen with `hc read codex-review-<ticket> --lines 60`. If the prompt asks for an action that the review needs (see "Rules"), approve it with `hc keys`. If the screen shows an option that approves it for the session, use that option. Else use the option that approves it once. Read the screen again to make sure that Codex continues. Do not approve a different action, for example a change to a repo file, a commit, a push, a package install or a delete. For such an action, ask the user at once with your question tool, so that the user gets a notification. Quote what the prompt asks. If `hc get` shows status `null` for the child, the Codex status hooks do not work. Then read its screen at each `reason: timeout` to find a prompt.

8. Read the report file. If the file does not exist, read the screen of the child and find out why.

9. Make sure that each finding is true. Open the evidence that Codex gives, and read the code around it. If a finding is about behavior and a test can settle it, run the test. Sort each finding:
   - True: the evidence shows it.
   - False: the evidence shows something else. Note why.
   - Unverified: neither of you can settle it with a source. Name what can settle it.

   Do the same for the verdict. If you disagree with a high finding or with the verdict, send your reason to Codex with `hc send codex-review-<ticket> "<reason>"`, and wait for its answer once. Then decide.

10. Report in the chat as a short summary. If the user asks for detail, give it:
    1. The verdict: are the goals met, partly met, or not met, in one or two sentences.
    2. One line: how many findings were true, false and unverified.
    3. The true findings, most severe first, each in one line with file:line.
    4. The false findings, each with your reason.
    5. The unverified findings, each with what can settle it.
    6. The goals or plan items that the changes do not cover.

    If a true finding is out of scope for the ticket, follow the repo's rule for such items, for example an `agent-feedback/` folder. If the goals are met, offer `/intent check`.

11. Ask the user to accept or reject the result. Also ask whether you must fix the true findings. If the user accepts it, end the child: `hc kill codex-review-<ticket>; hc rm codex-review-<ticket>`. If the user rejects it, keep the child, so the user or you can send it more questions.
