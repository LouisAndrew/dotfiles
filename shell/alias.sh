alias t="tmux"
alias ll="ls -la"

alias fsc="fs-cli && cd \$(clipboard)"
alias rtm="source ~/.zshrc"
alias df="$DOTFILES_PATH"
alias kn="k9s -n default"

alias l="eza"
alias ls="l"
alias lt="ls -T --git-ignore"
alias c-="cd -"

alias dcu="docker compose up"
alias dcd="docker compose down"
alias icloud='~/Library/Mobile\ Documents/com~apple~CloudDocs'

for f in $DOTFILES_PATH/shell/alias/*.sh; do
  source $f
done
