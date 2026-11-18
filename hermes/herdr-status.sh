#!/usr/bin/env bash
# Hermes shell hook. herdr lists a terminal as an agent when its program reports a status
# with OSC 7501, and Hermes cannot do that on its own. The hook subprocess shares the Hermes
# terminal, so it writes the code to /dev/tty. stdout is read by Hermes as JSON, so it stays empty.
[ -n "${HC_TERMINAL_ID:-}" ] || exit 0
event=$(jq -r '.hook_event_name // empty' 2>/dev/null)
case "$event" in
    pre_llm_call | post_approval_response) state=working ;;
    on_human_input_request) state=blocked ;;
    # "done" is herdr's to set when a turn ends unseen.
    on_session_end) state=idle ;;
    on_session_finalize) state=clear ;;
    *) exit 0 ;;
esac
fields="state=$state"
[ "$state" = clear ] || fields+=":app=hermes"
printf '\033]7501;%s\007' "$fields" >/dev/tty 2>/dev/null
exit 0
