# In a herdr space named after a Jira key (leader I), export the key as $TN, for example TN=rad-885.
# The first shell of a new space starts before the space has its name, and a space can be renamed,
# so read the name again at each prompt.
[[ -n $HC_TERMINAL_ID ]] || return 0

function _herdr_ticket_precmd() {
  local json space
  json=$(hc get "$HC_TERMINAL_ID" --json 2>/dev/null) || return
  [[ $json =~ '"where":"([^"]*)"' ]] || return
  space=${match[1]%% / *}
  if [[ $space =~ '^[A-Za-z]+-[0-9]+$' ]]; then
    export TN=${space:l}
  elif [[ $TN == $_herdr_ticket_tn ]]; then
    unset TN
  fi
  _herdr_ticket_tn=$TN
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _herdr_ticket_precmd
