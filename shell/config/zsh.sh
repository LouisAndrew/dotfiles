export EDITOR="nvim"
export KUBE_EDITOR="$EDITOR"
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=white'

open-nvim-cwd() {
  zle -I
  nvim
  zle reset-prompt
}

zle -N open-nvim-cwd
bindkey '^O' open-nvim-cwd
bindkey -M viins '^O' open-nvim-cwd
bindkey -M vicmd '^O' open-nvim-cwd
bindkey -M emacs '^O' open-nvim-cwd
