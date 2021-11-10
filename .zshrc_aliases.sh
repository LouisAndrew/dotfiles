# export variable $ALIAS_FILE_PATH on your `.zshrc` file that's pointing to the absolute path of this file

alias ll="ls -la"
alias gh-cpr="gh pr create -w"
alias gh-vpr="gh pr view -w"
alias gh-lpr="gh pr list"

alias zsh-config="code ~/.zshrc"

alias pre="npm run lint:fix; npm t && g-cm"

# Git commands
alias g-cm="git commit -m"
alias g-cc="git checkout master || git checkout main && g-l"
alias g-p="git push"
alias g-l="git pull"
alias g-b="git symbolic-ref --short -q HEAD"
alias g-c="git checkout"
alias g-cb="g-c -b"
alias g-pu="g-p -u origin \$(g-b)"
alias g-a="git add *"

alias cc="clear"

alias pb-latest="npm i @plattenbau/component-library@latest"
alias fs="fs-cli && cd \$(clipboard)"
alias nrun="select-run"
alias re-term="source ~/.zshrc"

alias icl="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs"

alias g-local="git config user.email louisandrew3@gmail.com"
alias g-delete-origin="git push origin --delete"
alias g-fetch="git fetch"
alias dj-start='python ./boilerplate/manage.py runserver'

alias aliases="cat $ALIAS_FILE_PATH"