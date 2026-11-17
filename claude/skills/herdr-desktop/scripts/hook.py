#!/usr/bin/env python3
# Shows Claude Desktop sessions in herdr's Agents list. Two modes:
#   hook.py                 Claude Code hook for every session (reads the event on stdin).
#   hook.py name "<title>"  The skill: names this session's tab, onboarding it first if needed.
# A Desktop session is onboarded on its first prompt: one tab in the "guis" space runs
# bridge.py, which reports the state written here. bridge.py offboards it after 2 hours.

import json
import os
import re
import subprocess
import sys

STATE_ROOT = os.path.expanduser("~/.local/state/herdr-desktop")
SPACE = "guis"
BRIDGE = os.path.join(os.path.dirname(os.path.abspath(__file__)), "bridge.py")


def herdr(command, args):
    out = subprocess.run(["herdr-app", "do", command, json.dumps(args)], capture_output=True, text=True, timeout=5)
    result = json.loads(out.stdout or "{}")
    if out.returncode != 0 or "error" in result:
        raise RuntimeError(result.get("error") or out.stderr.strip() or f"herdr-app do {command} failed")
    return result


def desktop_space():
    out = subprocess.run(["herdr-app", "ls"], capture_output=True, text=True, timeout=5)
    for space in json.loads(out.stdout or "{}").get("spaces", []):
        if space.get("name") == SPACE and not space.get("machine"):
            return space["id"]
    return None


def title_from(prompt):
    words = " ".join((prompt or "").split())
    if len(words) <= 30:
        return words or "Claude Desktop"
    return re.sub(r"\s+\S*$", "", words[:31]) + "…"


def onboard(session, title, folder, state):
    path = os.path.join(STATE_ROOT, session)
    os.makedirs(path)
    write(path, state)
    argv = ["python3", "-I", BRIDGE, session, title]
    try:
        space = desktop_space()
        if space:
            result = herdr("tab.new", {"space": space, "name": title, "folder": folder, "argv": argv, "focus": False})
        else:
            result = herdr("space.new", {"name": SPACE, "tab": title, "folder": folder, "argv": argv, "focus": False})
    except Exception:
        subprocess.run(["rm", "-rf", path])
        raise
    with open(os.path.join(path, "tab"), "w") as f:
        f.write(result.get("tab") or "")


def write(path, state):
    with open(os.path.join(path, "state"), "w") as f:
        f.write(state)


def hook():
    try:
        event = json.load(sys.stdin)
    except Exception:
        return
    session = str(event.get("session_id") or "")
    if not session:
        return
    name = event.get("hook_event_name")
    if name == "Notification":
        state = "blocked" if event.get("notification_type") == "permission_prompt" else None
    else:
        state = {
            "UserPromptSubmit": "working",
            "PostToolUse": "working",
            "PermissionRequest": "blocked",
            "Stop": "idle",
            "SessionEnd": "end",
        }.get(name)
    if not state:
        return
    path = os.path.join(STATE_ROOT, session)
    if os.path.isdir(path):
        write(path, state)
    elif name == "UserPromptSubmit" and os.environ.get("CLAUDE_CODE_ENTRYPOINT") == "claude-desktop":
        # UserPromptSubmit adds a hook's stdout to the prompt, so a failure stays silent.
        try:
            onboard(session, title_from(event.get("prompt")), event.get("cwd") or os.getcwd(), state)
        except Exception:
            pass


def name(title):
    session = os.environ.get("CLAUDE_CODE_SESSION_ID")
    if not session:
        sys.exit("CLAUDE_CODE_SESSION_ID is not set: run this from a Claude Code session.")
    path = os.path.join(STATE_ROOT, session)
    if not os.path.isdir(path):
        onboard(session, title, os.getcwd(), "working")
        print(f"Onboarded this session to the herdr space \"{SPACE}\" as \"{title}\".")
        return
    try:
        tab = open(os.path.join(path, "tab")).read().strip()
    except FileNotFoundError:
        sys.exit("This session's herdr tab is unknown. Rename it in herdr with Leader e.")
    herdr("tab.rename", {"id": tab, "name": title})
    print(f"Renamed this session's herdr tab to \"{title}\".")


if __name__ == "__main__":
    if sys.argv[1:2] == ["name"] and len(sys.argv) == 3:
        name(sys.argv[2])
    else:
        hook()
