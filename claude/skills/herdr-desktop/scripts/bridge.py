#!/usr/bin/env python3
# Runs in a herdr tab for one onboarded Claude Desktop session. herdr lists a terminal as an
# agent when its program reports a status with OSC 7501, so this reports the state that
# hook.py writes for the session. Closing the tab offboards the session, and so do 2 hours
# without a hook event. The next prompt onboards it again.

import base64
import os
import select
import shutil
import signal
import subprocess
import sys
import termios
import time
import tty

STATE_ROOT = os.path.expanduser("~/.local/state/herdr-desktop")
# herdr's own words; "done" is herdr's to set when a turn ends unseen.
STATES = {"working", "blocked", "idle"}
IDLE_LIMIT_S = 2 * 3600


def osc(fields):
    sys.stdout.write("\033]7501;" + ":".join(fields) + "\007")
    sys.stdout.flush()


def b64(text):
    return base64.b64encode(text.encode()).decode()


def main():
    session, title = sys.argv[1], sys.argv[2]
    folder = os.path.join(STATE_ROOT, session)
    state_file = os.path.join(folder, "state")

    def offboard(*_):
        osc(["state=clear"])
        shutil.rmtree(folder, ignore_errors=True)
        # tab.new runs the bridge in a login shell that stays after it exits; ending the
        # terminal closes the tab.
        if os.environ.get("HC_TERMINAL_ID"):
            subprocess.run(["hc", "kill", os.environ["HC_TERMINAL_ID"]], check=False)
        sys.exit(0)

    signal.signal(signal.SIGHUP, offboard)
    signal.signal(signal.SIGTERM, offboard)

    print(f"Claude Desktop: {title}\n{session}\n\no: open Claude Desktop   q: hide until the next prompt\n")
    raw = sys.stdin.isatty()
    if raw:
        saved = termios.tcgetattr(sys.stdin)
        tty.setcbreak(sys.stdin)
    shown = None
    try:
        while True:
            try:
                state = open(state_file).read().strip()
                quiet = time.time() - os.path.getmtime(state_file)
            except FileNotFoundError:
                state, quiet = "end", 0
            # A session that waits on a permission prompt stays: it needs the person.
            if state == "end" or (quiet > IDLE_LIMIT_S and state != "blocked"):
                offboard()
            if state in STATES and state != shown:
                osc([f"state={state}", "app=claude-desktop", f"title={b64(title)}"])
                print(time.strftime("%H:%M"), state)
                shown = state
            ready, _, _ = select.select([sys.stdin], [], [], 0.5)
            if ready:
                key = sys.stdin.read(1)
                if key == "o":
                    subprocess.run(["open", "-a", "Claude"], check=False)
                elif key == "q":
                    offboard()
    finally:
        if raw:
            termios.tcsetattr(sys.stdin, termios.TCSADRAIN, saved)


if __name__ == "__main__":
    main()
