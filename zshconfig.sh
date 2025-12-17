export ZSH="$HOME/.oh-my-zsh"
export ZSH_TMUX_AUTOSTART="true"

plugins=(zsh-vi-mode zsh-syntax-highlighting zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

export DENO_INSTALL="$HOME/.deno"

# Check that the function `starship_zle-keymap-select()` is defined.
# xref: https://github.com/starship/starship/issues/3418
type starship_zle-keymap-select >/dev/null || \
  {
    eval "$(/opt/homebrew/bin/starship init zsh)"
  }

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

PATH="$DENO_INSTALL/bin:$PATH"
PATH="$BUN_INSTALL/bin:$PATH"
PATH="$brew_path/opt/curl/bin:$PATH"
PATH="$GOBIN:$PATH"
export PATH



# tmux
source $DOTFILES_PATH/shell/tmux.sh
