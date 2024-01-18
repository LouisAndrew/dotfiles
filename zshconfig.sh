export ZSH="$HOME/.oh-my-zsh"

source $ZSH/oh-my-zsh.sh

# Env related
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
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

alias docker="/Applications/Docker.app/Contents/Resources/bin/docker"

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

LS_COLORS=$LS_COLORS:'di=1;35'; 
export LS_COLORS
export MASON="/Users/louis.andrew/.local/share/nvim/mason/packages"
export VOLAR_GLOBAL="/Users/louis.andrew/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server/out/index.js"
export EDITOR="nvim"
export NEOVIDE_FRAME="none"
