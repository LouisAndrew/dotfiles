export ZSH="$HOME/.oh-my-zsh"
export ZSH_TMUX_AUTOSTART="true"

plugins=(vi-mode zsh-syntax-highlighting zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

export DENO_INSTALL="$HOME/.deno"
eval "$(starship init zsh)"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/aws-okta aws-okta

export STARSHIP_CONFIG="$DOTFILES_PATH/starship.toml"

source $DOTFILES_PATH/shell/alias.sh
source $DOTFILES_PATH/shell/functions.sh
brew_path=$(brew --prefix)

zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit

export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

zstyle ':completion:*:git:*' group-order 'main commands' 'alias commands' 'external commands'

# bun
export BUN_INSTALL="$HOME/.bun"

source $DOTFILES_PATH/asdf.sh

export GOBIN=`go env GOBIN`

PATH="$DENO_INSTALL/bin:$PATH"
PATH="$BUN_INSTALL/bin:$PATH"
PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
PATH="$brew_path/opt/curl/bin:$PATH"
PATH="$GOBIN:$PATH"
export PATH

BG_COLOR="#131313"
BG_COLOR_DARK="#0a0a0a"

BG=$BG_COLOR_DARK
BORDER=$BG_COLOR

export LS_COLORS=$LS_COLORS:"di=0;$COLOR_MAGENTA";
export EZA_COLORS="sc=0;$COLOR_CYAN:di=0;$COLOR_MAGENTA:bu=0;$COLOR_YELLOW"
export MASON="$HOME/.local/share/nvim/mason/packages"
export VOLAR_GLOBAL="$HOME/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server/out/index.js"
export EDITOR="zed"
export KUBE_EDITOR="$EDITOR"
export NEOVIDE_FRAME="none"
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=white'

PROMPT_ICON=""
export FZF_DEFAULT_OPTS="--layout reverse --bind 'ctrl-/:toggle-preview,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' --no-bold"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
  --color=fg:#9a9a9a,fg+:#ffffff,bg:$BG,bg+:$BG
  --color=hl:#678CB1,hl+:#97CCF1,info:#afaf87,marker:#aeaeae
  --color=prompt:#aeaeae,spinner:#af5fff,pointer:#aeaeae,header:#87afaf
  --color=border:$BORDER,preview-fg:-1,label:#aeaeae,query:#d9d9d9
  --preview-window=\"border-rounded\" --padding=\"1\" --prompt=\"$PROMPT_ICON \" --marker=\"◆\"
  --pointer=\"\" --separator=\"\" --scrollbar=\"│\""

export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export BAT_THEME="minimalfedu"

zle -N open_project
zle -N f
zle -N fs
zle -N rgf
zle -N ngowrapper
zle -N m
zle -N qn
zle -N grep_notes
zle -N tlt

bindkey '^o' open_project
bindkey '^f' rgf
bindkey '^g' ngowrapper
bindkey '^e' fs
bindkey "^b" m
bindkey '^q' qn
bindkey '^v' grep_notes
bindkey '^t' tlt

# tmux
source $DOTFILES_PATH/shell/tmux.sh
