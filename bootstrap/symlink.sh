# Considering $DOTFILES_PATH is setup
XDG_CONFIG="$HOME/.config"
if [ "$(uname)" = "Darwin" ]; then
    APP_CONFIG="$HOME/Library/Application Support"
else
    APP_CONFIG="$XDG_CONFIG"
fi

link_resource() {
    local source=$1
    local destination=$2

    if [ -e "$destination" ] && [ ! -L "$destination" ]; then
        printf 'Refusing to replace existing resource: %s\n' "$destination" >&2
        return 1
    fi

    mkdir -p "$(dirname "$destination")"
    ln -sfn "$source" "$destination"
}

# espanso is a desktop app; on WSL it runs on the Windows side instead
[ "$(uname)" = "Darwin" ] && link_resource "$DOTFILES_PATH/espanso" "$APP_CONFIG/espanso"
link_resource "$DOTFILES_PATH/lazygit" "$APP_CONFIG/lazygit"
link_resource "$DOTFILES_PATH/zed" "$XDG_CONFIG/zed"
link_resource "$DOTFILES_PATH/nvim" "$XDG_CONFIG/nvim"
link_resource "$DOTFILES_PATH/ghostty" "$XDG_CONFIG/ghostty"
# Machine-local global tools can go in ~/.config/mise/conf.d/*.toml
link_resource "$DOTFILES_PATH/mise/config.toml" "$XDG_CONFIG/mise/config.toml"

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

link_resource "$DOTFILES_PATH/httpie.json" "$XDG_CONFIG/httpie.json"
link_resource "$DOTFILES_PATH/starship.toml" "$XDG_CONFIG/starship.toml"
link_resource "$DOTFILES_PATH/.tmux.conf" "$HOME/.tmux.conf"
link_resource "$DOTFILES_PATH/.prettierrc" "$HOME/.prettierrc"
