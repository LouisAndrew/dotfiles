function jira_status() {
  local ticket_status='In Progress'

  if [ ! -z "$1" ]; then
    ticket_status=$1

    if [[ $ticket_status == "td" ]]; then
      ticket_status='ToDo'
    fi

    if [[ $ticket_status == "cr" ]]; then
      ticket_status='Code Review'
    fi

    if [[ $ticket_status == "rv" ]]; then
      ticket_status='Review'
    fi

    if [[ $ticket_status == "rr" ]]; then
      ticket_status='Ready to Release'
    fi
  fi

  echo $ticket_status
}

function jli() {
  ticket_status=$(jira_status $1)
  jira issue list -a$(jira me) -s$ticket_status --plain --no-headers --columns 'KEY,SUMMARY'
}

function jmi() {
  ticket_status=$(jira_status $1)
  ticket_key=$2
  
  if [[ $ticket_key != *"-"* ]]; then
    ticket_key="MOPS-$ticket_key"
  fi

  jira issue move $2 $ticket_status
}
