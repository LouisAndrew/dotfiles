---
name: remember
description: Write to the shared memory in the Obsidian vault that all of my agents use. Use it to log what changed at the end of real work. Use it to save a lasting fact about my setup or about me. Use it for "remember this", "log this", "save to memory", or "rebuild Now".
---

# Remember

The shared memory lives in `memory/` in my Obsidian vault. The global `AGENTS.md` gives the vault path for each host. The vault `AGENTS.md` holds the full rules under "Shared Memory". Read that section before your first write in a session.

## Pick the target

| What you have | Target | Rule |
| --- | --- | --- |
| The result of a piece of real work | `memory/log/<YYWww> <host>.md` | Append one entry |
| A lasting fact about my setup | `memory/Memory.md` | Add one line under the matching heading |
| A lasting fact about me | `memory/User.md` | Add one line under "Learned by agents" |
| A personal goal: finance, fitness or personal life | `memory/Personal.md` | Never on the MacBook |
| My request to rebuild Now | `memory/Now.md` | Rebuild it from the current reviews |

`<YYWww>` is the ISO week, for example `26W47`. Get it with `date +%gW%V`. `<host>` is `mac` on the MacBook, `pc` in WSL on the Windows PC, and `vps` on the VPS.

If a fact will not be true in a month, do not save it.

## Write

1. Read the target note first. If the fact is already there, stop. If the fact replaces an old line, change that line.
2. Check the size limit: `User.md` 1,400 characters, `Memory.md` 2,200, `Now.md` 3,000. If the note is full, merge or remove old lines first.
3. Write the change:
   - On the MacBook, use the Obsidian CLI. Append with `obsidian vault=vault append path="<path>" content="<text>"`. Use `\n` for a new line. If the note does not exist, use `create` with the same arguments.
   - In WSL on the Windows PC, edit the file directly, and only inside `memory/`.
   - On the VPS, edit the file, commit, and push.
4. Read the note back to make sure that the write succeeded.

A log entry is one line: `- <YYYY-MM-DD>, <agent>: <what changed>. Left: <what is left>.` Link to notes with wikilinks.

## Rebuild Now

Rebuild `memory/Now.md` only on my request, and only on the Windows PC or the VPS. Mac agents cannot read `proj30/`, so on the MacBook, tell me to run the rebuild on the PC. Read the current quarterly, monthly and weekly reviews in `proj30/`, and this week's logs. Keep the frontmatter and the paragraphs above "Last rebuilt". Replace the rest with the open Career goals and side projects, and link each goal to its review. Copy each career goal in full, because `Now.md` is the only copy of the career goals that Mac agents can read. Update the "Last rebuilt" line.

The Finance, Fitness and Personal goals go to `memory/Personal.md`, never to `Now.md`. Rebuild `Personal.md` only on the Windows PC or the VPS.

## Do not write

- Code, customer data, credentials or secrets
- Details of work for Rome2Rio beyond a general summary
- Text copied from other notes. Link to the note.
