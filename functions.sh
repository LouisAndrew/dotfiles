
function ntv() {
 nt -- $1.$SPEC
}

function ntvw() {
 nt -- --watch $1.$SPEC $2
}

function devlog() {
  g-cm "log: add journal entry [JOURNAL]"
}

function cmo() {
  echo "Committing without end-parantheses"
  g-cm "$1($2): $3"
}

function cmto() {
  npm t && cmo $1 $2 $3
}

function cm() {
 ticket_number=$([[ -z "$4" ]] && echo `ticket` || echo $4)
 echo "🎊 Committing for $ticket_number"
 g-cm "$1($2): $3"
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

function isWork() {
 work_email="louis.andrew@share-now.com"
 current=`git config user.email`
 if [[ $current == $work_email ]];
 then
   echo 1
 else
  echo 0
 fi
}

function g-rename() {
  git branch -m `g-b` $1
}

function ghpr() {
  num=`ticket`
  body="Closes #${num}"
  gh pr create -b $body -w
}

function glmr() {
  project=`basename "$PWD"`
  branch_name=`g-b`
  encoded_branch=${branch_name//(\/)/"%2F"}
  open "https://gitlab.share-now.com/mops/$project/-/merge_requests/new?merge_request%5Bsource_branch%5D=$encoded_branch"
}