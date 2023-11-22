function cmo() {
  echo "Committing without end-parantheses"
  gcm "$1($2): $3"
}

function cmto() {
  npm t && cmo $1 $2 $3
}

function cm() {
 ticket_number=$([[ -z "$4" ]] && echo `ticket` || echo $4)
 echo "🎊 Committing for $ticket_number"
 gcm "$1($2): $3"
}

function mcm() {
 ticket_number=$([[ -z "$4" ]] && echo `ticket` || echo $4)
 echo "🎊 Committing for $ticket_number"
 pre "$1($2): $3 ($ticket_number)"
}

function mcmo() {
 ticket_number=$([[ -z "$4" ]] && echo `ticket` || echo $4)
 echo "🎊 Committing for $ticket_number"
 gcm "$1($2): $3 ($ticket_number)"
}

function mcm:nt() {
  pre "$1($2): $3"
}

function mcmo:nt() {
 gcm "$1($2): $3"
}

function ticket() {
 branch_name=`gb`
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
  git branch -m `gb` $1
}

# function ghpr() {
#   num=`ticket`
#   body="Closes #${num}"
#   gh pr create -b $body -w
# }

function glmr() {
  # project=`basename "$PWD"`
  # branch_name=`g-b`
  # encoded_branch=${branch_name//(\/)/"%2F"}
  # open "https://gitlab.share-now.com/mops/$project/-/merge_requests/new?merge_request%5Bsource_branch%5D=$encoded_branch"

  glab mr create --fill --web
}

function ywp() {
  yw $PBN/$1 ${@:2:99}
}

function ywm() {
  yw $MC/$1 ${@:2:99}
}