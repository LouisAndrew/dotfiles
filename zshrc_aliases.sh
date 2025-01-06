# export variable $ALIAS_FILE_PATH and $DOTFILES_PATH on your `.zshrc` file that's pointing to the absolute path of this filealias
source "$DOTFILES_PATH/variables.sh"
FUNCTIONS_PATH="$DOTFILES_PATH/functions.sh"

alias vsc=$vscodium
alias n:config="$editor $HOME/.config/nvim"
alias nvd="$nvd"
alias gnm="$gnm"
alias n="$editor"
alias ngo="nvim -c DiffviewOpen"
alias ngd="nvim -c 'DiffviewOpen main'"
alias ngl="nvim -c DiffviewFileHistory"
alias nconfig="$EDITOR $HOME/.config/nvim"
alias t="tmux"

alias ll="ls -la"
alias gh-cpr="gh pr create -w"
alias gh-vpr="gh pr view -w"
alias gh-lpr="gh pr list"
alias nv="$nv"
alias nushell="/opt/homebrew/Cellar/nushell/0.87.1/bin/nu"

alias pre="npm t && gcm"

# Git commands
alias gcm="git commit -m"
alias gcc="git checkout main || git checkout master && gl"
alias gp="git push"
alias gpf="git push -f"
alias gl="git pull"
alias gb="git symbolic-ref --short -q HEAD"
alias gba="git branch -a"
alias gc="git checkout"
alias gcb="gc -b"
alias gpu="gp -u origin \$(gb)"
alias ga="git add *"
alias gn="echo `gb` | sed  's/^.*\([0-9]\{4\}\).*$/\1/g'"
alias gd="git diff"
alias gdn="gd --name-only"
alias gcma="git commit --amend --no-edit"
alias gbd="git branch -d"
alias gm="git branch -M main"
alias lg="lazygit"
alias gundo="git reset --soft HEAD~"
alias greset="git reset --hard"
alias grh="git reset --hard HEAD"
alias gclean="git branch -D `git branch --merged | grep -v \* | xargs`" # delete all merged branches
alias gsync="git fetch --all -Pp && gclean"
alias gs="git stash"
alias gcub="git rev-parse --abbrev-ref HEAD" # current branch

alias changed="gdn"
alias staged="gdn --cached"
alias changed:full="gd"
alias staged="gd --cached"

alias ch="changed"
alias stg="staged"

alias discard="git reset --hard"
alias g-dc="discard"

alias cl="clear"

alias pb-latest="npm i @plattenbau/component-library@latest"
alias fsc="fs-cli && cd \$(clipboard)"
alias nrun="select-run"
alias re-term="source ~/.zshrc"
alias rtm="re-term"
alias main="gcc"
alias m="gcc"

# `cd` to iCloud directory
alias icl="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs"
alias icloud="icl"
alias obsidian="~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/vault"
alias obs="obsidian"

alias vsc:config="$editor $VSCODE_SETTINGS_PATH"
alias zsh:config="$editor ~/.zshrc"
alias fn:config="$editor $FUNCTIONS_PATH"
alias al:config="$editor $ALIAS_FILE_PATH"
alias hyper:config="$editor ~/.hyper.js"
alias gh-dash:config="$editor /Users/louis.andrew/Library/'Application Support'/gh-dash"
alias dotfiles="$DOTFILES_PATH"
alias df="dotfiles"
alias dotfiles:config="$editor $DOTFILES_PATH"
alias obsd="~/dev/documents/"

alias config="echo vsc-config alias-config dotfiles hyper-config"

alias glocal="git config user.email louisandrew3@gmail.com"
alias g-delete-origin="git push origin --delete"
alias gfetch="git fetch"
alias gf="git fetch"
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
alias nx="npx"
alias ntu="nr test:unit"
alias nsw="nr serve"
alias nc="npm-check -u"

alias vsc="$vscode ."
alias vc="$vscodium ."
alias c="$editor"
alias cdot="$editor ."
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
alias bwli="bw list items"
alias ghpr="gh-cpr"

alias rbrew="/usr/local/bin/brew"

# NVM
alias n16="nvm use 16"
alias n18="nvm use 18"
alias ndef="nvm use default"
alias clc="cl & c"
alias ca="c -a"
alias k9="k9s -n default"
alias z="eza"
alias zt="eza -T --git-ignore"
alias notes="cd $NOTES"
alias l="z"
alias ls="z"
alias lt="zt"
alias c-="cd -"

# vars
export PBN="@plattenbau-next"
export MC="@mops"
alias cb="clipboard"

alias py=python3

# nvim
alias ncp="nvim -c PackerSync"
alias ng="pnpm add -g"
alias cte="EDITOR=nvim crontab -e"

alias got="go test"
alias pgpaste="$DOTFILES_PATH/pngpaste.sh"
alias ai="aichat"

source $FUNCTIONS_PATH 
source "$DOTFILES_PATH/glab.sh"
source "$DOTFILES_PATH/jira.sh"
