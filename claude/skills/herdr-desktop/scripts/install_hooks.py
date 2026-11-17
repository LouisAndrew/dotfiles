#!/usr/bin/env python3
# Adds hook.py to ~/.claude/settings.json for the events it handles, once.
# settings.json is not in dotfiles: other tools (herdr, Orca) write their hooks there too.

import json
import os
import shutil
import sys

EVENTS = ["UserPromptSubmit", "PostToolUse", "PermissionRequest", "Notification", "Stop", "SessionEnd"]

hook = sys.argv[1]
command = f"python3 -I '{hook}'"
path = os.path.expanduser("~/.claude/settings.json")
settings = json.load(open(path))
hooks = settings.setdefault("hooks", {})

changed = False
for event in EVENTS:
    groups = hooks.setdefault(event, [])
    if any(h.get("command") == command for g in groups for h in g.get("hooks", [])):
        continue
    groups.append({"hooks": [{"type": "command", "command": command, "timeout": 5}]})
    changed = True

if changed:
    shutil.copy(path, path + ".bak-herdr-desktop")
    with open(path + ".tmp", "w") as f:
        json.dump(settings, f, indent=2)
        f.write("\n")
    os.replace(path + ".tmp", path)
    print(f"Added the herdr-desktop hooks to {path}. A backup is at {path}.bak-herdr-desktop.")
