# Considering $DOTFILES_PATH is setup
DARWIN_CONFIG=$HOME/Library/Application\ Support
XDG_CONFIG="$HOME/.config"

ln -s $DOTFILES_PATH/espanso $DARWIN_CONFIG/espanso
ln -s $DOTFILES_PATH/lazygit $DARWIN_CONFIG/lazygit
ln -s $DOTFILES_PATH/zed $XDG_CONFIG/zed
ln -s $DOTFILES_PATH/nvim $XDG_CONFIG/nvim

ln -s $DOTFILES_PATH/ghostty.config $XDG_CONFIG/ghostty.config
ln -s $DOTFILES_PATH/httpie.json $XDG_CONFIG/httpie.json
ln -s $DOTFILES_PATH/starship.toml $XDG_CONFIG/starship.toml
ln -s $DOTFILES_PATH/tmux.conf $HOME/tmux.conf
ln -s $DOTFILES_PATH/.asdfrc $HOME/.asdfrc
