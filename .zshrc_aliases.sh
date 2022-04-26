# export variable $ALIAS_FILE_PATH and $DOTFILES_PATH on your `.zshrc` file that's pointing to the absolute path of this file
source "$DOTFILES_PATH/variables.sh"

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

alias clc="clear"

alias pb-latest="npm i @plattenbau/component-library@latest"
alias fs="fs-cli && cd \$(clipboard)"
alias nrun="select-run"
alias re-term="source ~/.zshrc"
alias rtm="re-term"

# `cd` to iCloud directory
alias icl="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs"
alias icloud="icl"

alias vsc:config="code $VSCODE_SETTINGS_PATH"
alias zsh:config="code ~/.zshrc"
alias alias:config="code $ALIAS_FILE_PATH"
alias dotfies="code $DOTFILES_PATH"
alias hyper:config="code ~/.hyper.js"
alias config="echo vsc-config alias-config dotfiles hyper-config"

alias g-local="git config user.email louisandrew3@gmail.com"
alias g-delete-origin="git push origin --delete"
alias g-fetch="git fetch"
alias dj-start='python ./boilerplate/manage.py runserver'

alias alias:custom="cat $ALIAS_FILE_PATH"
alias vsc-to-dotfiles="cat $VSCODE_SETTINGS_PATH >> $DOTFILES_PATH/.vscode/settings.json"
alias backup:vsc="vsc-to-dotfiles && $DOTFILES_PATH && git add .vscode && g-cm 'chore: backup vscode config' && g-pu"

# Watch vue tests
alias tvw="npx vue-cli-service test:unit --watch"

# NPM `ni` alias
alias ns="nr start"
alias nt="nr test"
alias nun="npm uninstall"

source "$DOTFILES_PATH/functions.sh" 