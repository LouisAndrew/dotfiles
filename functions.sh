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

function glmr() {
  glab mr create --fill --web
}

function ywp() {
  yw $PBN/$1 ${@:2:99}
}

function ywm() {
  yw $MC/$1 ${@:2:99}
}

# Find content of files and open in nvim
function gr() {
  ifsOld=$IFS
  IFS=":"

  # can be done using cut, but it will try to print the 
  # file and number in the sameline, separated by delimiter.
  rg -e $1 --line-number --no-heading --color=always \
    --smart-case | fzf -d ':' -n 2.. --ansi --no-sort \
    --preview "$DOTFILES_PATH/batpager.sh {1} {2}" \
    | read filename linenumber content 

  IFS=$ifsOld
  $editor $filename +$linenumber
}

function f() {
  local query=""
  # checks if the first argument is empty
  if [ ! -z "$1" ]; then
    query="-q $1"
  fi

  # can use xargs, but seems that newly touched files
  # are not properly opened.
  fd --type f --hidden --exclude .git | fzf $query \
    --preview='bat -n --color=always {}' | read filename

  $editor $filename
}
