---
name: todo
description: Work through the open tasks in memory/TODO.md in my Obsidian vault. Do each open #agent task for this host and check it off. List the tasks that are left for me. Also add a new task to the note. Use it for /todo, "do my todos", "run the open tasks", "add a todo", or "leave this for me to do".
---

# Todo

The task list is `memory/TODO.md` in my Obsidian vault. The global `AGENTS.md` gives the vault path for each host. Read the vault `AGENTS.md` before your first write in a session.

## Tags

Each task is one checkbox line with one owner tag and one host tag.

| Tag | Meaning |
| --- | --- |
| `#agent` | An agent can do the task alone. |
| `#me` | I must do the task, for example to accept a UAC prompt or to log in. |
| `#mac`, `#pc`, `#vps` | The host where the task must run. |

The host is `mac` on the MacBook, `pc` in WSL on the Windows PC, and `vps` on the VPS.

## Run the open tasks

1. Read `memory/TODO.md`. Find the host from the platform.
2. Select the open tasks that have `#agent` and the tag of this host. Keep the order of the note.
3. Show me the selected tasks in one short list. Then start.
4. Do each task from top to bottom.
   - If a task depends on an open task above it for another host or for me, skip it.
   - Before a task that is hard to undo, ask me once. Examples are a push, a delete, and a message to another person.
   - After the task, make sure that the result works. Run the check that the task names, or the nearest check.
5. If a task succeeds, change `- [ ]` to `- [x]`, add `(done <YYYY-MM-DD>, <host>)`, and move the line under "Done".
6. If a task fails, leave it open. Add one indented line under it: `- <YYYY-MM-DD>: <why it failed>`.
7. Report three groups: done, failed, and left. "Left" holds the `#me` tasks and the tasks for other hosts. Keep the report short.
8. At the end, log the work with the `remember` skill.

## Add a task

If I ask for a task, add it. If your work leaves a step that you cannot do on this host, add that step as a task.

1. Write one line under "Open": `- [ ] <task> #agent|#me #<host>`.
2. Write the task so that an agent with no context can do it. Name the files, the commands and the check.
3. If the task depends on another task, place it below that task.

## Write the note

- On the MacBook, use the Obsidian CLI: `obsidian vault=vault` lists the commands.
- In WSL on the Windows PC, edit the file directly.
- On the VPS, edit the file, commit, and push.

Read the note back to make sure that the write succeeded.

## Do not

- Do a `#me` task. This rule applies also when you have the access.
- Do a task for another host.
- Write code, customer data, credentials or secrets to the note.
- Remove a line under "Done" that is less than 30 days old.
