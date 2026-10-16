# Considering $DOTFILES_PATH is setup
DARWIN_CONFIG=$HOME/Library/Application\ Support
XDG_CONFIG="$HOME/.config"

link_resource() {
    local source=$1
    local destination=$2

    if [ -e "$destination" ] && [ ! -L "$destination" ]; then
        if [ -f "$destination" ] && cmp -s "$source" "$destination"; then
            rm "$destination"
        else
            printf 'Refusing to replace existing resource: %s\n' "$destination" >&2
            return 1
        fi
    fi

    ln -sfn "$source" "$destination"
}

ln -s $DOTFILES_PATH/espanso $DARWIN_CONFIG/espanso
ln -s $DOTFILES_PATH/lazygit $DARWIN_CONFIG/lazygit
ln -s $DOTFILES_PATH/zed $XDG_CONFIG/zed
ln -s $DOTFILES_PATH/nvim $XDG_CONFIG/nvim
# Keep OMP credentials and session state local; link only versioned resources.
mkdir -p "$HOME/.omp/agent"
link_resource "$DOTFILES_PATH/omp/config.yml" "$HOME/.omp/agent/config.yml"
link_resource "$DOTFILES_PATH/omp/keybindings.yml" "$HOME/.omp/agent/keybindings.yml"
link_resource "$DOTFILES_PATH/omp/mcp.json" "$HOME/.omp/agent/mcp.json"
link_resource "$DOTFILES_PATH/omp/skills" "$HOME/.omp/agent/skills"
link_resource "$DOTFILES_PATH/claude/keybindings.json" "$HOME/.claude/keybindings.json"
# Keep Claude-managed skills (synced, plugin installs) local; link only versioned skills.
mkdir -p "$HOME/.claude/skills"
for skill in "$DOTFILES_PATH"/claude/skills/*/; do
    [ -d "$skill" ] || continue
    link_resource "${skill%/}" "$HOME/.claude/skills/$(basename "$skill")"
done

ln -s $DOTFILES_PATH/ghostty.config $XDG_CONFIG/ghostty.config
ln -s $DOTFILES_PATH/httpie.json $XDG_CONFIG/httpie.json
ln -s $DOTFILES_PATH/starship.toml $XDG_CONFIG/starship.toml
ln -s $DOTFILES_PATH/tmux.conf $HOME/tmux.conf
ln -s $DOTFILES_PATH/.prettierrc $HOME/.prettierrc
