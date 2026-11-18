#!/bin/sh
# Reports the Codex state to herdr-core with OSC 7501, so `hc wait` and the parent agent see a Codex child that waits
# for a person or ends its turn. Codex sends no status of its own.
# Codex runs hooks with no controlling terminal, so the report goes to the terminal device of the nearest parent
# process that has one.
# Usage, from ~/.codex/hooks.json: hc-status.sh working|blocked|done

cat >/dev/null
[ -n "${HC_TERMINAL_ID:-}" ] || exit 0
case "${1:-}" in
working | blocked | done) ;;
*) exit 0 ;;
esac

pid=$PPID
while [ "${pid:-1}" -gt 1 ]; do
    tty=$(ps -o tty= -p "$pid" 2>/dev/null | tr -d ' ')
    if [ -n "$tty" ] && [ "$tty" != "??" ]; then
        printf '\033]7501;state=%s:app=codex\007' "$1" >"/dev/$tty" 2>/dev/null || true
        exit 0
    fi
    pid=$(ps -o ppid= -p "$pid" 2>/dev/null | tr -d ' ')
done
exit 0
