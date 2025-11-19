board="CCT"

function jira_status() {
  local ticket_status='In Progress'

  if [ ! -z "$1" ]; then
    ticket_status=$1

    if [[ $ticket_status == "ip" ]]; then
      ticket_status='In Progress'
    fi

    if [[ $ticket_status == "td" ]]; then
      ticket_status='Opened'
    fi

    if [[ $ticket_status == "dr" ]]; then
      ticket_status='Design-Check'
    fi

    if [[ $ticket_status == "cr" ]]; then
      ticket_status='In Review'
    fi

    if [[ $ticket_status == "rv" ]]; then
      ticket_status='In Review'
    fi

    if [[ $ticket_status == "rr" ]]; then
      ticket_status='Ready-For-Release'
    fi
  fi

  echo $ticket_status
}

function jai() {
  me=$(jira me)
  ticket_key=$1

  if [[ -z "$1" ]]; then
    ticket_key=$(echo `ticket`)
  fi

  if [[ $ticket_key != *"-"* ]]; then
    ticket_key="$board-$ticket_key"
  fi

  jira issue assign $ticket_key $me
}

function jli() {
  ticket_status="-s$(jira_status $1)"
  assigner="-a$(jira me)"
  columns='KEY,SUMMARY'

  if [[ "$2" == *"a"* ]]; then
    assigner=""
    columns="KEY,SUMMARY,ASSIGNEE"
  fi

  if [[ "$2" == *"k"* ]]; then
    columns="KEY"
  fi

  if [[ "$1" == *"a"* ]]; then
    columns="KEY,SUMMARY,STATUS"
    ticket_status=""
  fi

  jira issue list $assigner $ticket_status --plain --no-headers --columns $columns
}

function jb() {
  q="project = $board AND (labels not in (Experiment) OR labels is EMPTY) AND statusCategory != Done AND status != Backlog"
  columns="KEY,SUMMARY,STATUS,ASIGNEE"

  jira issue list --no-headers --columns $columns -q $q --order-by status
}

function jmi() {
  ticket_status=$(jira_status $1)
  ticket_key=$2

  if [[ -z "$2" ]]; then
    ticket_key=$(echo `ticket`)
  fi

  if [[ $ticket_key != *"-"* ]]; then
    ticket_key="$board-$ticket_key"
  fi

  jira issue move $ticket_key $ticket_status
}

function jvi() {
  ticket_key=$1

  if [[ -z "$1" ]]; then
    ticket_key=$(echo `ticket`)
  fi

  if [[ $ticket_key != *"-"* ]]; then
    ticket_key="$board-$ticket_key"
  fi

  jira issue view $ticket_key
}
