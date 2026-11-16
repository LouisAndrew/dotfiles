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
