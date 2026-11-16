This file holds the global instructions that all of my coding agents share: Claude Code, Codex, OpenCode and Oh My Pi. Each tool loads this one file, so a change here reaches every agent. Put an instruction for one tool only in that tool's own configuration, not here.

## How each tool loads this file

- Claude Code reads `~/.claude/CLAUDE.md`, which is a symlink to this file.
- Codex reads `~/.codex/AGENTS.md`, which is a symlink to this file.
- OpenCode loads this file through the `instructions` list in `opencode/opencode.json`.
- Oh My Pi reads the Claude Code and Codex files above.

`bootstrap/symlink.sh` creates the two symlinks.

## Obsidian vault

My Obsidian vault is my shared knowledge base. It holds my notes, project plans, weekly reviews, and facts about my setup.

The vault location depends on the host:

- Work MacBook: `~/Obsidian/vault` (Obsidian vault name `vault`)
- VPS: `~/vault`, used by the Hermes agent

If the `OBSIDIAN_VAULT_PATH` environment variable is set, use its value instead of the list.

### When to use the vault

- If I mention a note, a project, my vault, or my notes, look in the vault. Do not ask me for the path.
- If you need context about me, my setup, or my projects, search the vault before you ask me.

### How to use the vault

1. Read `AGENTS.md` at the vault root before you change a note. It holds the write rules.
2. On the MacBook, write through the Obsidian CLI. Run `obsidian vault=vault` to list the commands.
3. Read and search the notes with normal file tools.

The vault syncs through the private GitHub repository `LouisAndrew/vault`. The Hermes agent on the VPS pulls every 10 minutes. A local change reaches the VPS only after a commit and a push.

## Shared memory

The `memory/` folder in the vault is the memory that all of my agents share. It tells you who I am, what I work on now, and what comes next.

At the start of a session, read these three notes, unless they are already in your context:

- `memory/User.md`: who I am
- `memory/Memory.md`: lasting facts about my setup
- `memory/Now.md`: my current focus and next steps

On the Windows PC and the VPS, also read `memory/Personal.md`: my finance, fitness and personal goals. On the work MacBook, never read `memory/Personal.md`.

Claude Code gets these notes from a SessionStart hook, `agents/memory-context.sh`. The hook skips `Personal.md` on macOS.

If you need more detail, open the review or project note that these notes link to. Do not read whole folders.

To write to memory, use the `remember` skill. If your tool has no skill support, follow the "Shared Memory" rules in the vault `AGENTS.md`. In short:

1. At the end of real work, append one entry to `memory/log/<YYWww> <host>.md`. The host is `mac` on the MacBook, `pc` in WSL on the Windows PC, and `vps` on the VPS.
2. If you learn a lasting fact about my setup, add one line to `memory/Memory.md`.
3. If you learn a lasting fact about me, add one line under "Learned by agents" in `memory/User.md`.
4. Do not edit `memory/Now.md` without my request.

Keep work entries general. Do not write code, customer data, credentials or secrets to memory.
