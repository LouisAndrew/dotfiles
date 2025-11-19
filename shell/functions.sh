function open_project() {
    $EDITOR .
}

function cmo() {
  echo "Committing without end-parantheses"
  gcm "$1($2): $3" ${@:4}
}

function cmto() {
  npm t && cmo $1 $2 $3
}

function cm() {
 ticket_number=$([[ -z "$4" ]] && echo `ticket` || echo $4)
 echo "🎊 Committing for $ticket_number"
 gcm "$1($2): $3 ($ticket_number)" ${@:5}
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
  echo "BAY-0"
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
  nvim -c PickFiles
}

function gcho() {
  jli $1 | fzf | grep -o '[0-9]\+' | read t
  read b
  read desc
  gchb $b $t $desc
}

function gchb() {
  type=$1
  ticket=CCT-$2
  description=$3
  git checkout -b $type/$ticket--$description
}

function e() {
  local filename=$1
  mkdir -p "$(dirname "$1")" && touch $filename && $editor $filename
}

function lsd() {
  fd . $1 -t d -d 1
}

GO_BACK=".."
CLONE="Clone from clipboard"
GO_HERE="CD here"
function fs() {
  scope_list=$(lsd $DEV_HOME | sed "s,$DEV_HOME/,,")
  echo $scope_list | fzf \
    --preview "fd . $DEV_HOME/{} -t d -d 1 | sed \
    s,$DEV_HOME/{},," | read scope

  if [ -z "$scope" ]; then
    return 0
  fi

  project_list=$(lsd $DEV_HOME/$scope | sed "s,$DEV_HOME/$scope,,")
  project_list+=("\n$GO_BACK\n$CLONE\n$GO_HERE")

  echo $project_list | fzf | read project

  if [ "$project" = "$GO_HERE" ]; then
    cd $DEV_HOME/$scope
    return 0
  fi

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
  echo "hh"
}

alias gco="git branch -a | fzf | sed 's/\*//' | sed 's/remotes\/origin\///' | xargs git checkout"
alias gcd="git branch -r | fzf | xargs git checkout"

function rgf() {
  nvim -c Grep
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

function ngowrapper() { ngo; }
function tlt() {
  tmux split-window -v -p 25
  tmux split-window -h
  tmux select-pane -U

  tmux

  f
}

function m() {
  nvim -c ObsidianQuickSwitch
}

function on() {
  nvim -c ObsidianNew "$@"
}

function qn() {
  nvim $COMMONPLACE
}

function grep_notes() {
  nvim -c ObsidianSearch
}

function tsh() {
  sh $DOTFILES_PATH/tmux.sh
}

function br() {
  profile="${1:-default}"
  credentials="$(aws configure export-credentials --profile "$profile")"
  access_key=$(jq -r '.AccessKeyId' <<<"$credentials")
  secret_key=$(jq -r '.SecretAccessKey' <<<"$credentials")
  session_token=$(jq -r '.SessionToken' <<<"$credentials")
  region=$(aws configure get region --profile "$profile")
  export AWS_ACCESS_KEY=$access_key
  export AWS_SECRET_KEY=$secret_key
  export AWS_SESSION_TOKEN=$session_token
  export BEDROCK_KEYS="$access_key,$secret_key,$region,$session_token"
}

for f in $DOTFILES_PATH/shell/functions/*.sh; do
  source $f
done
