function ntv() {
 nt -- $1.$SPEC
}

function ntvw() {
 nt -- --watch $1.$SPEC
}

function cm() {
 ticket_number=$([[ -z "$4" ]] && echo `ticket` || echo $4)
 echo "🎊 Committing for $ticket_number"
 g-cm "$1($2): $3 ($ticket_number)"
}

function mcm() {
 ticket_number=$([[ -z "$4" ]] && echo `ticket` || echo $4)
 echo "🎊 Committing for $ticket_number"
 pre "$1($2): $3 ($ticket_number)"
}

function ticket() {
 branch_name=`g-b`
 branch_without_prefix=${branch_name//(*\/)/""}
 branch_details=$(awk -F-- '{print $2}' <<< $branch_without_prefix)
 if [[ -z "$branch_details" ]];
 then
  echo "MOPS-0"
 else
  echo $(awk -F-- '{print $1}' <<< $branch_without_prefix)
 fi
}