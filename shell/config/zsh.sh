export EDITOR="nvim"
export KUBE_EDITOR="$EDITOR"
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=white'

open-nvim-cwd() {
  zle -I
  nvim
  zle reset-prompt
}

open-lazygit() {
  zle -I
  lazygit
  zle reset-prompt
}

zle -N open-nvim-cwd
zle -N open-lazygit
bindkey '^O' open-nvim-cwd
bindkey -M viins '^O' open-nvim-cwd
bindkey -M vicmd '^O' open-nvim-cwd
bindkey -M emacs '^O' open-nvim-cwd
bindkey '^G' open-lazygit
bindkey -M viins '^G' open-lazygit
bindkey -M vicmd '^G' open-lazygit
bindkey -M emacs '^G' open-lazygit
