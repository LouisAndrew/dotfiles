#!/usr/bin/env bash
# PreToolUse hook for the Agent tool. Inside herdr, deny built-in subagents so that
# Claude starts the helper in a herdr tab with `hc run` instead (herdr-agents skill).
# Set HERDR_ALLOW_SUBAGENTS=1 to turn the guard off for one session.

[ -n "${HC_TERMINAL_ID:-}" ] || exit 0
[ "${HERDR_ALLOW_SUBAGENTS:-}" = "1" ] && exit 0
command -v jq >/dev/null 2>&1 || exit 0

input=$(cat)
type=$(printf '%s' "$input" | jq -r '.tool_input.subagent_type // ""')

# web-fetch stands in for the WebFetch tool in some sessions, so it is not a helper agent.
case "$type" in
  web-fetch) exit 0 ;;
esac

reason="You run inside herdr (\$HC_TERMINAL_ID=$HC_TERMINAL_ID). Do not use the built-in Agent tool. \
Load the herdr-agents skill and start the helper in its own herdr tab: \
hc run --bg --name <name> --cwd <dir> claude \"<task>. Report with hc send $HC_TERMINAL_ID when done or stuck.\" \
Then collect results with hc wait --children any."

jq -n --arg r "$reason" '{
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    permissionDecision: "deny",
    permissionDecisionReason: $r
  }
}'
