export ZSH="$HOME/.oh-my-zsh"
export ZSH_TMUX_AUTOSTART="true"

plugins=(vi-mode)
source $ZSH/oh-my-zsh.sh

# # Env related
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export DENO_INSTALL="/Users/louis.andrew/.deno"

eval "$(starship init zsh)"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/aws-okta aws-okta
export STARSHIP_CONFIG="$DOTFILES_PATH/starship.toml"
export ALIAS_FILE_PATH="$DOTFILES_PATH/zshrc_aliases.sh"
export FS_CLI_CONFIG="~/.fs-cli.json"

source $ALIAS_FILE_PATH

export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/opt/homebrew/share/zsh-syntax-highlighting/highlighters
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

zstyle :compinstall filename '/home/louis.andrew/.zshrc'
autoload -Uz compinit

export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)
#
# zstyle ':completion:*' menu select
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*' rehash true
# zmodload zsh/complist
# compinit

zstyle ':completion:*:git:*' group-order 'main commands' 'alias commands' 'external commands'

# bun completions
[ -s "/Users/louis.andrew/.bun/_bun" ] && source "/Users/louis.andrew/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export GOPATH="$HOME/go"
# export PATH="$BUN_INSTALL/bin:$PATH"autoload -U compinit; compinit
PATH="$DENO_INSTALL/bin:$PATH"
PATH="$BUN_INSTALL/bin:$PATH"
PATH="$GOPATH/bin:$PATH"
export PATH
# Add it to your shell init files
[[ -d /Applications/WezTerm.app/Contents/MacOS ]] && export PATH="/Applications/WezTerm.app/Contents/MacOS:$PATH"

# Run once to enable wezterm undercurl for nvim
# $ curl https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo | tic -x -
export TERM="wezterm"

COLOR_BLACK="30"
COLOR_RED="31"
COLOR_GREEN="32"
COLOR_YELLOW="33"
COLOR_BLUE="34"
COLOR_MAGENTA="35"
COLOR_CYAN="36"
COLOR_WHITE="37"

JQ_OBJECT="0;$COLOR_WHITE"
JQ_PROP="0;$COLOR_YELLOW"
BG_COLOR="#131313"
BG_COLOR_DARK="#0a0a0a"

export JQ_COLORS="0;90:$JQ_PROP:$JQ_PROP:$JQ_PROP:$JQ_STRING:$JQ_OBJECT:$JQ_OBJECT:$JQ_OBJECT"

export LS_COLORS=$LS_COLORS:"di=1;$COLOR_MAGENTA"; 
export EZA_COLORS="sc=0;$COLOR_CYAN:di=0;30;45:bu=0;$COLOR_YELLOW"
export MASON="/Users/louis.andrew/.local/share/nvim/mason/packages"
export VOLAR_GLOBAL="/Users/louis.andrew/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server/out/index.js"
export EDITOR="nvim"
export KUBE_EDITOR="$EDITOR"
export NEOVIDE_FRAME="none"

export FZF_DEFAULT_OPTS="--bind 'ctrl-/:toggle-preview,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down'"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
  --color=fg:#9a9a9a,fg+:#ffffff,bg:$BG_COLOR,bg+:$BG_COLOR
  --color=hl:#678CB1,hl+:#97CCF1,info:#afaf87,marker:#ffcfa7
  --color=prompt:#f2eaea,spinner:#af5fff,pointer:#ffcfa7,header:#87afaf
  --color=border:$BG_COLOR,preview-fg:-1,label:#aeaeae,query:#d9d9d9
  --preview-window=\"border-rounded\" --padding=\"1\" --prompt=\"  \" --marker=\"◆\"
  --pointer=\"\" --separator=\"\" --scrollbar=\"│\""

export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export BAT_THEME="minimalfedu"

source $DOTFILES_PATH/asdf.sh

function ngowrapper() { ngo; }

zle -N f
zle -N fs
zle -N rgf
zle -N ngowrapper 

bindkey '^o' f
bindkey '^f' rgf
bindkey '^g' ngowrapper 
bindkey '^e' fs 

# tmux
if [[ ! -n $TMUX  ]]; then
  # Get the session IDs
  session_ids="$(tmux list-sessions)"

  # Create new session if no sessions exist
  if [[ -z "$session_ids" ]]; then
    tmux new-session
  fi

  # Select from following choices
  #   - Attach existing session
  #   - Create new session
  #   - Start without tmux
  create_new_session="Create new session"
  start_without_tmux="Start without tmux"
  choices="$session_ids\n${create_new_session}:\n${start_without_tmux}:"
  choice="$(echo $choices | fzf | cut -d: -f1)"

  if expr "$choice" : "[0-9]*$" >&/dev/null; then
    # Attach existing session
    tmux attach-session -t "$choice"
  elif [[ "$choice" = "${create_new_session}" ]]; then
    # Create new session
    tmux new-session
  elif [[ "$choice" = "${start_without_tmux}" ]]; then
    # Start without tmux
    :
  fi
fi
