export ZSH="$HOME/.oh-my-zsh"

source $ZSH/oh-my-zsh.sh

# # Env related
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export DENO_INSTALL="/Users/louis.andrew/.deno"

eval "$(starship init zsh)"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/aws-okta aws-okta
export DOTFILES_PATH="/Users/louis.andrew/dev/utils/dotfiles"
export STARSHIP_CONFIG="$DOTFILES_PATH/starship.toml"
export ALIAS_FILE_PATH="$DOTFILES_PATH/zshrc_aliases.sh"
export FS_CLI_CONFIG="~/.fs-cli.json"

source $DOTFILES_PATH/vim.sh
source $ALIAS_FILE_PATH


export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/opt/homebrew/share/zsh-syntax-highlighting/highlighters
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

zstyle :compinstall filename '/home/louis.andrew/.zshrc'
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' rehash true
zmodload zsh/complist
compinit

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

export JQ_COLORS="0;90:$JQ_PROP:$JQ_PROP:$JQ_PROP:$JQ_STRING:$JQ_OBJECT:$JQ_OBJECT:$JQ_OBJECT"

export LS_COLORS=$LS_COLORS:'di=1;35'; 
export MASON="/Users/louis.andrew/.local/share/nvim/mason/packages"
export VOLAR_GLOBAL="/Users/louis.andrew/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server/out/index.js"
export EDITOR="nvim"
export KUBE_EDITOR="$EDITOR"
export NEOVIDE_FRAME="none"

export FZF_DEFAULT_OPTS="--bind 'ctrl-/:toggle-preview,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down'"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#9a9a9a,fg+:#ffffff,bg:-1,bg+:#121212
  --color=hl:#678CB1,hl+:#97CCF1,info:#afaf87,marker:#ffcfa7
  --color=prompt:#f2eaea,spinner:#af5fff,pointer:#ffcfa7,header:#87afaf
  --color=border:#262626,preview-fg:-1,label:#aeaeae,query:#d9d9d9
  --preview-window="border-rounded" --padding="1" --prompt="  " --marker="◆"
  --pointer=">" --separator="─" --scrollbar="│"'

export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export BAT_THEME="minimalfedu"

source $DOTFILES_PATH/asdf.sh
