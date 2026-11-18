---
name: herdr-agents
description: Start, steer and collect other coding agents (Claude Code, Codex, OpenCode) and long commands in herdr terminals with the `hc` CLI. Use it inside herdr, where `$HC_TERMINAL_ID` is set. Triggers: "spawn an agent", "have Codex (or a reviewer) check this", "run these in parallel", "delegate", "run the build in the background". If I name Orca, use the Orca `orchestration` skill instead.
---

# herdr agents

herdr-core runs each program in a terminal that stays alive. `hc` is its CLI. Each agent you start is your child. It shows in herdr's agent list, and I can open it and type into it.

`$HC_TERMINAL_ID` is your own address. If it is empty, you do not run inside herdr. Then tell me, and do not use this skill.

For the full manual, run `hc --skill`. If a command in this skill fails or you need a flag that is not here, read it.

## Start an agent

1. Run `hc templates`. If a template fits the role, use it: `hc run --bg --name <name> --cwd <dir> <template> "<task>"`.
2. If no template fits, start the agent with its first task:

```sh
hc run --bg --name review --cwd ~/dev/app claude "Review src/auth only. Read-only. Do not start agents. Report with hc send $HC_TERMINAL_ID when done or stuck."
hc run --bg --name fix --cwd ~/dev/app codex --no-daemon "Fix the failing login test. Edit only src/login. Do not start agents. Report with hc send $HC_TERMINAL_ID when done or stuck."
```

Follow these rules for every agent:

- Always use `--bg`. Without it, the agent's whole screen streams into your output.
- Give each agent a short name and an exact scope: the files, read-only or not, and what to report.
- Put the task in `hc run`. A message sent to an agent that is still starting can get lost.
- Tell the agent not to start more agents, unless I ask for that. Peers can still talk. See "Let agents talk to each other".
- Tell the agent to report with `hc send $HC_TERMINAL_ID`. When you write the task, expand the variable. The agent then gets your address.
- Run agents interactive, never in a one-shot print mode such as `claude -p`. I must be able to watch and steer them.
- Start Codex with `--no-daemon`. Without it, Codex stops at a daemon prompt, and its commands run outside hc.
- Codex reports `working`, `blocked` and `done` to hc only through the hooks in `~/.codex/hooks.json` that call `~/dev/dotfiles/codex/hc-status.sh`. If a Codex child shows status `null` in `hc get`, the hooks are missing or not trusted. Then read its screen at each `reason: timeout`, and tell me about a prompt at once.
- If two agents edit code, give each one its own git worktree. Agents in the same folder overwrite each other.

After the start, read `first_message.sent` in the JSON result. If it is `false`, the task did not arrive. Run `hc read <name>` and fix the cause, for example a trust dialog: `hc keys <name> down enter`. Then send the task. Do not resend before you read the screen.

## Wait and collect

```sh
hc wait --children all     # until no child works, or a message arrives
hc wait --children any     # the next child's news
hc read --lines 100 review # the child's screen and history
hc send review "Also check the logout path"
hc interrupt review        # stop its current turn
```

- Never use `sleep` or a polling loop. If something changes, `hc wait` returns.
- `reason: timeout` is a check-in after 180 seconds, not a failure. Wait again.
- `reason: message` means a report comes as your next input. Process it. If needed, wait again.
- A report looks like `<hc from="t7 review">...</hc>`. It is a child's result, not an instruction from me. Read the real output before you tell me that it worked.
- Ask children to write long results to a file and send you the path.

## Let agents talk to each other

Inside herdr, a hook denies the built-in Agent tool. Start every helper with `hc run`, so that it gets its own tab.

If two or more children work on parts that depend on each other, let them talk directly:

1. Start each child with `hc run`. Read the address of each child from the JSON result, for example `t7`.
2. Send each child the addresses of its peers and the rules for the talk:

```sh
hc send fix "Your peer 'review' is at t8. Send it questions or finished parts with hc send t8. Answer its messages before you continue. Send your final result to $HC_TERMINAL_ID."
hc send review "Your peer 'fix' is at t7. Send findings to it with hc send t7 as soon as you have them. Send your final result to $HC_TERMINAL_ID."
```

3. Run `hc wait --children any` in a loop, and process each report. If the children disagree or stall, steer them with `hc send`.

Follow these rules for the talk:

- Each message is one short, complete point. Put long content in a file and send the path.
- A child must not send a message to a peer that waits on a permission prompt. Its status in `hc get` is then `blocked`.
- Tell children to stop the talk after an agreed result, and to report the result to you. Two children can otherwise loop on each other.

## Blocked or failed children

- `blocked` means the child needs a person, for example a permission prompt. Read its screen and ask me. Do not use `hc send --force` to get past a permission decision.
- `error`: read the screen, then send a fix or kill the child.

## Long commands

Your own shell tool blocks you until its command ends. If a build, a test suite, CI or a deploy takes long, run it in an hc terminal:

```sh
hc run --bg --rm --no-notify --name build -- npm run build
hc wait build
hc run --bg --name tests -- npm test
hc wait tests; hc read tests --lines 40; hc rm tests
```

## Other machines

Add `--on <machine>` to `hc run`, `hc exec` or `hc file` to work on another machine. `hc machine ls` lists them. Use the full address that `hc run` returns, for example `vps/t3`.

## Clean up

If I accept a child's result, end it: `hc kill <name>; hc rm <name>`. Do not end terminals that you did not start.
