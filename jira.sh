function jira_status() {
  local ticket_status='In Progress'

  if [ ! -z "$1" ]; then
    ticket_status=$1

    if [[ $ticket_status == "ip" ]]; then
      ticket_status='In Progress'
    fi

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
      ticket_status='Ready for Release'
    fi
  fi

  echo $ticket_status
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

function jmi() {
  ticket_status=$(jira_status $1)
  ticket_key=$2

  if [[ -z "$2" ]]; then
    ticket_key=$(echo `ticket`)
  fi
  
  if [[ $ticket_key != *"-"* ]]; then
    ticket_key="MOPS-$ticket_key"
  fi

  jira issue move $ticket_key $ticket_status
}
