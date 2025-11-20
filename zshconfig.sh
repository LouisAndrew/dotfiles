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

for file in $DOTFILES_PATH/shell/config/*.sh; do
  source $file
done

# bun
export BUN_INSTALL="$HOME/.bun"
export GOBIN=`go env GOBIN`

PATH="$DENO_INSTALL/bin:$PATH"
PATH="$BUN_INSTALL/bin:$PATH"
PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
PATH="$brew_path/opt/curl/bin:$PATH"
PATH="$GOBIN:$PATH"
export PATH

zle -N open_project
bindkey '^o' open_project # binds ctrl-o to `$EDITOR .` - e.g. `nvim .` or `zed .`

# tmux
source $DOTFILES_PATH/shell/tmux.sh
