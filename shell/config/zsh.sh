export EDITOR="nvim"
export KUBE_EDITOR="$EDITOR"
export AI_HARNESS="omp"
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

open-ai-harness() {
  zle -I
  $AI_HARNESS
  zle reset-prompt
}

zle -N open-nvim-cwd
zle -N open-lazygit
zle -N open-ai-harness

bindkey '^O' open-nvim-cwd
bindkey -M viins '^O' open-nvim-cwd
bindkey -M vicmd '^O' open-nvim-cwd
bindkey -M emacs '^O' open-nvim-cwd

bindkey '^G' open-lazygit
bindkey -M viins '^G' open-lazygit
bindkey -M vicmd '^G' open-lazygit
bindkey -M emacs '^G' open-lazygit

bindkey '^E' open-ai-harness
bindkey -M viins '^E' open-ai-harness
bindkey -M vicmd '^E' open-ai-harness
bindkey -M emacs '^E' open-ai-harness
