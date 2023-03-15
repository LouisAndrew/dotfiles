# export variable $ALIAS_FILE_PATH and $DOTFILES_PATH on your `.zshrc` file that's pointing to the absolute path of this file
source "$DOTFILES_PATH/variables.sh"
FUNCTIONS_PATH="$DOTFILES_PATH/functions.sh"

vscode="code"
vscodium="codium"
editor=$vscodium

alias ll="ls -la"
alias gh-cpr="gh pr create -w"
alias gh-vpr="gh pr view -w"
alias gh-lpr="gh pr list"

alias pre="npm run lint:fix; npm t && g-cm"

# Git commands
alias g-cm="git commit -m"
alias g-cc="git checkout master || git checkout main && g-l"
alias g-p="git push"
alias g-l="git pull"
alias g-b="git symbolic-ref --short -q HEAD"
alias g-ba="git branch -a"
alias g-c="git checkout"
alias g-cb="g-c -b"
alias g-pu="g-p -u origin \$(g-b)"
alias g-a="git add *"
alias g-n="echo `g-b` | sed  's/^.*\([0-9]\{4\}\).*$/\1/g'"
alias g-d="git diff"
alias g-dn="g-d --name-only"

alias changed="g-dn"
alias staged="g-dn --cached"
alias changed:full="g-d"
alias staged="g-d --cached"

alias ch="changed"
alias stg="staged"

alias discard="git reset --hard"
alias g-dc="discard"

alias clc="clear"

alias pb-latest="npm i @plattenbau/component-library@latest"
alias fs="fs-cli && cd \$(clipboard)"
alias nrun="select-run"
alias re-term="source ~/.zshrc"
alias rtm="re-term"
alias main="g-cc"

# `cd` to iCloud directory
alias icl="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs"
alias icloud="icl"

alias vsc:config="$editor $VSCODE_SETTINGS_PATH"
alias zsh:config="$editor ~/.zshrc"
alias fn:config="$editor $FUNCTIONS_PATH"
alias al:config="$editor $ALIAS_FILE_PATH"
alias hyper:config="$editor ~/.hyper.js"
alias gh-dash:config="$editor /Users/louis.andrew/Library/'Application Support'/gh-dash"
alias dotfiles="$editor $DOTFILES_PATH"

alias dotfies="$editor $DOTFILES_PATH"
alias config="echo vsc-config alias-config dotfiles hyper-config"

alias g-local="git config user.email louisandrew3@gmail.com"
alias g-delete-origin="git push origin --delete"
alias g-fetch="git fetch"
alias dj-start='python ./boilerplate/manage.py runserver'

alias al:cat="cat $ALIAS_FILE_PATH"
alias fn:cat="cat $FUNCTIONS_PATH"
alias vsc-to-dotfiles="cat $VSCODE_SETTINGS_PATH >> $DOTFILES_PATH/.vscode/settings.json"
alias backup:vsc="vsc-to-dotfiles && $DOTFILES_PATH && git add .vscode && g-cm 'chore: backup vscode config' && g-pu"

# Watch vue tests
alias tvw="npx vue-cli-service test:unit --watch"

# NPM `ni` alias
alias ns="nr start"
alias nt="nr test"
alias ntw="nr test:watch"
alias nb="nr build"
alias nd="nr dev"

alias vsc="$vscode ."
alias vc="$vscodium ."
alias c="$editor ."
alias yw="yarn workspace"

alias clone="git clone"

# TEMPORARY
alias first="ni -D @mops/component-library@latest @plattenbau/component-library @vue/eslint-config-typescript@11 @vue/eslint-config-prettier@7 eslint@7.28 eslint-plugin-vue@9.3 --legacy-peer-deps"
alias second="vue upgrade eslint -t v5.0.0-alpha.7"
export REGEX="\"/^(?!(.*)(vue|eslint|sass-loader|typescript|graphql|apollo)).*$/\""
alias commit="mcm feat node 'upgrade to v16'"
alias zero="echo 'engine-strict=true' >> .npmrc"
alias minus="ncu \"/^(?!(.*)(vue|eslint|sass-loader|typescript|graphql|apollo)).*$/\""

# BW
alias bwu="bw unlock --passwordenv BW_PASSWORD"
alias ghpr="gh-cpr"

alias rbrew="/usr/local/bin/brew"

# NVM
alias n16="nvm use 16"
alias nd="nvm use default"

# vars
export PBN="@plattenbau-next"
export MC="@mops"

source $FUNCTIONS_PATH 