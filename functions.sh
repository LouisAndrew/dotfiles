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

function ywp() {
  yw $PBN/$1 ${@:2:99}
}

function ywm() {
  yw $MC/$1 ${@:2:99}
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

  if [ ! -z "$filename" ]; then
    $editor $filename
    return 0
  fi
  
  return 1
}

function gchb() {
  type=$1
  ticket=$2
  description=$3
  git checkout -b $type/$ticket--$description
}

function e() {
  local filename=$1
  mkdir -p "$(dirname "$1")" && touch $filename && $editor $filenamefunc
}

function lsd() {
  fd . $1 -t d -d 1
}

GO_BACK=".."
CLONE="Clone from clipboard"
function fs() {
  scope_list=$(lsd $DEV_HOME | sed "s,$DEV_HOME/,,") 
  echo $scope_list | fzf \
    --preview "fd . $DEV_HOME/{} -t d -d 1 | sed \
    s,$DEV_HOME/{},," | read scope

  if [ -z "$scope" ]; then
    return 0
  fi

  project_list=$(lsd $DEV_HOME/$scope | sed "s,$DEV_HOME/$scope,,")
  project_list+=("\n$GO_BACK"); project_list+=("\n$CLONE")

  echo $project_list | fzf | read project

  if [ "$project" = "$CLONE" ]; then
    cd $DEV_HOME/$scope
    clone_url=$(pbpaste)
    echo $clone_url | xargs git clone
    echo $clone_url | sed -E 's/.*\/(.*)\.git/\1/' | read project
    cd $project

    return 0
  fi

  if [ "$project" = "$GO_BACK" ]; then
    fs
  fi

  if [ -z "$project" ]; then
    return 0
  fi

  cd $DEV_HOME/$scope/$project
}

alias gco="git branch -a | fzf | sed 's/\*//' | sed 's/remotes\/origin\///' | xargs git checkout"
alias gcd="git branch -r | fzf | xargs git checkout"

function rgf() {
  c="rg --column -nS --no-heading --color=always -e "

  query=""
  fzf_query=""
  if [ ! -z "$1" ]; then
    query=$(rg --column -nS --no-heading --color=always -e $1)
    fzf_query="-q $1"
  fi 

  a="$(echo $query | fzf $fzf_query --bind "change:reload:$c {q} || true" \
    --ansi --preview "$DOTFILES_PATH/bat-ripgrep.sh {}" \
    --header 'Search in files')"
  if [[ -n $a ]]; then
      IFS=':' read -r file line char _ <<< "$a"
      "$EDITOR" "$file" +"$line" -c "norm ${char}lh"
  fi
}

function loadenv() {
  local file=".env"
  if [[ ! -z "$1" ]]; then
    file=$1
  fi
  
  grep -v '^#' $file | xargs -0 | while read -r line; do
    if [[ ! -z "${line// }" ]]; then
      export "${line//\"/}"
    fi
  done
}
