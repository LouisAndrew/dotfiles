---
name: herdr-desktop
description: Name this Claude Desktop (Code tab) session in the Herdr app's Agents list, or onboard it now. Triggers: "rename this in herdr", "name this session in herdr", "onboard to herdr", "show this in herdr", /herdr-desktop. A session that runs in a herdr terminal names its own tab with Leader e.
---

# herdr desktop

Claude Desktop sessions do not run in herdr terminals, so herdr cannot see them. Hooks in `~/.claude/settings.json` fix that:

- On its first prompt, a Desktop session gets a tab in the herdr space "guis". The tab name is the start of that prompt.
- A program in the tab reports the session status to herdr: working, needs you, or done.
- After 2 hours with no activity, the tab closes. A session that waits on a permission prompt stays. The next prompt opens a new tab.

This skill gives the tab a better name.

## Name the session

1. If `$HC_TERMINAL_ID` is set, this session runs in a herdr terminal. Tell me to rename its tab with Leader e, and stop.
2. If I gave a name, use it. If not, pick two to five words for the work in this session.
3. Run:

```sh
python3 -I ~/.claude/skills/herdr-desktop/scripts/hook.py name "<name>"
```

4. Tell me in one sentence what the script printed. If it fails, give me its error text as it is.

## Setup on a new machine

If the hooks are not in `~/.claude/settings.json`, run this once:

```sh
python3 -I ~/.claude/skills/herdr-desktop/scripts/install_hooks.py ~/.claude/skills/herdr-desktop/scripts/hook.py
```
