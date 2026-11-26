# In a herdr space or Rex session named after a Jira key (leader I), export the key as $TN,
# for example TN=rad-885. The first shell of a new space starts before the space has its name,
# and a space can be renamed, so read the name again at each prompt.
[[ -n $HC_TERMINAL_ID || -n $REX_BLOCK ]] || return 0

# The rex CLI takes about 0.2s to answer, so in Rex read the name at most every 10 seconds.
_herdr_ticket_checked=0

function _herdr_ticket_space() {
  local json
  if [[ -n $HC_TERMINAL_ID ]]; then
    json=$(hc get "$HC_TERMINAL_ID" --json 2>/dev/null) || return 1
    [[ $json =~ '"where":"([^"]*)"' ]] || return 1
    print -r -- "${match[1]%% / *}"
  else
    json=$(rex session inspect --json 2>/dev/null) || return 1
    [[ $json =~ '"label": *"([^"]*)"' ]] || return 1
    print -r -- "${match[1]}"
  fi
}

function _herdr_ticket_precmd() {
  local space
  if [[ -z $HC_TERMINAL_ID ]]; then
    (( EPOCHSECONDS - _herdr_ticket_checked < 10 )) && return
    _herdr_ticket_checked=$EPOCHSECONDS
  fi
  space=$(_herdr_ticket_space) || return
  if [[ $space =~ '^[A-Za-z]+-[0-9]+$' ]]; then
    export TN=${space:l}
  elif [[ $TN == $_herdr_ticket_tn ]]; then
    unset TN
  fi
  _herdr_ticket_tn=$TN
}

zmodload zsh/datetime
autoload -Uz add-zsh-hook
add-zsh-hook precmd _herdr_ticket_precmd
