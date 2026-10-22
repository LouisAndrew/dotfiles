export EDITOR="zed"
export KUBE_EDITOR="$EDITOR"
export AI_HARNESS="omp"
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=white'

open-editor-cwd() {
  zle -I
  $EDITOR .
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

zle -N open-editor-cwd
zle -N open-lazygit
zle -N open-ai-harness

bindkey '^O' open-editor-cwd
bindkey -M viins '^O' open-editor-cwd
bindkey -M vicmd '^O' open-editor-cwd
bindkey -M emacs '^O' open-editor-cwd

bindkey '^G' open-lazygit
bindkey -M viins '^G' open-lazygit
bindkey -M vicmd '^G' open-lazygit
bindkey -M emacs '^G' open-lazygit

bindkey '^E' open-ai-harness
bindkey -M viins '^E' open-ai-harness
bindkey -M vicmd '^E' open-ai-harness
bindkey -M emacs '^E' open-ai-harness
