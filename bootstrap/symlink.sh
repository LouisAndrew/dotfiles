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
link_resource "$DOTFILES_PATH/herdr/config.toml" "$XDG_CONFIG/herdr/config.toml"
# The Herdr app writes its own state into ~/.config/herdr-app, so link only my files.
for resource in keys.json settings.json layouts/ghostty.json mods/ghostty-bar mods/leader mods/nav mods/copy mods/agents-plus; do
    link_resource "$DOTFILES_PATH/herdr-app/$resource" "$XDG_CONFIG/herdr-app/$resource"
done
# WSL-only ghostty overrides (font size etc.), included via `config-file = ?config.local`
[ "$(uname)" != "Darwin" ] && link_resource "$DOTFILES_PATH/ghostty/config.wsl" "$DOTFILES_PATH/ghostty/config.local"

# Noctty (native Windows terminal, Ghostty core) on WSL: point its Windows-side
# config at dotfiles. Windows symlinks need admin (Developer Mode is off), so the
# first run shows a UAC prompt; later runs skip once the link exists.
link_noctty_windows() {
    command -v powershell.exe >/dev/null 2>&1 || return 0
    local appdata
    appdata=$(cd /mnt/c && cmd.exe /c 'echo %LOCALAPPDATA%' 2>/dev/null | tr -d '\r') || return 0
    local dir dest dest_win target_win
    dir="$(wslpath -u "$appdata")/noctty"
    dest="$dir/config.ghostty"
    [ -L "$dest" ] && return 0
    if [ -e "$dest" ]; then
        printf 'Refusing to replace existing resource: %s\n' "$dest" >&2
        return 1
    fi
    mkdir -p "$dir"
    dest_win=$(wslpath -w "$dest")
    target_win=$(wslpath -w "$DOTFILES_PATH/noctty/config.ghostty")
    (cd /mnt/c && powershell.exe -NoProfile -Command \
        "Start-Process powershell -Verb RunAs -Wait -WindowStyle Hidden -ArgumentList '-NoProfile','-Command',\"New-Item -ItemType SymbolicLink -Path '$dest_win' -Target '$target_win'\"")
}
grep -qi microsoft /proc/version 2>/dev/null && link_noctty_windows
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
# Share one global instruction file across agents. OpenCode loads it through opencode.json.
mkdir -p "$HOME/.codex"
link_resource "$DOTFILES_PATH/agents/AGENTS.md" "$HOME/.claude/CLAUDE.md"
link_resource "$DOTFILES_PATH/agents/AGENTS.md" "$HOME/.codex/AGENTS.md"
# Codex gets the shared memory skill. OpenCode and Oh My Pi get it through their skills folders.
mkdir -p "$HOME/.codex/skills"
link_resource "$DOTFILES_PATH/claude/skills/remember" "$HOME/.codex/skills/remember"

link_resource "$DOTFILES_PATH/httpie.json" "$XDG_CONFIG/httpie.json"
link_resource "$DOTFILES_PATH/starship.toml" "$XDG_CONFIG/starship.toml"
link_resource "$DOTFILES_PATH/.tmux.conf" "$HOME/.tmux.conf"
link_resource "$DOTFILES_PATH/.prettierrc" "$HOME/.prettierrc"
link_resource "$DOTFILES_PATH/.vimrc" "$HOME/.vimrc"
link_resource "$DOTFILES_PATH/opencode" "$XDG_CONFIG/opencode"
# Claude Code and Codex rewrite their own config files, so merge the shared keys instead of linking.
bash "$DOTFILES_PATH/scripts/agent-config.sh"
