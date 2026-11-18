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
# On WSL the app runs on Windows, and link_windows_resources links its files.
grep -qi microsoft /proc/version 2>/dev/null || for resource in keys.json settings.json layouts/ghostty.json themes/ghostty.json mods/ghostty-bar mods/leader mods/nav mods/copy programs.json my-icons; do
    link_resource "$DOTFILES_PATH/herdr-app/$resource" "$XDG_CONFIG/herdr-app/$resource"
done
# WSL-only ghostty overrides (font size etc.), included via `config-file = ?config.local`
[ "$(uname)" != "Darwin" ] && link_resource "$DOTFILES_PATH/ghostty/config.wsl" "$DOTFILES_PATH/ghostty/config.local"

# On WSL, Windows apps read their configuration from Windows folders. Windows
# symlinks need admin (Developer Mode is off), so one UAC prompt creates every
# missing link. Later runs skip the links that exist.
link_windows_resources() {
    command -v powershell.exe >/dev/null 2>&1 || return 0
    local env
    env=$(cd /mnt/c && cmd.exe /c 'echo %LOCALAPPDATA%^|%APPDATA%^|%USERPROFILE%^|%TEMP%' 2>/dev/null | tr -d '\r') || return 0
    local localappdata appdata home temp
    IFS='|' read -r localappdata appdata home temp <<<"$env"
    localappdata=$(wslpath -u "$localappdata")
    appdata=$(wslpath -u "$appdata")
    home=$(wslpath -u "$home")

    local pairs=(
        "noctty/config.ghostty" "$localappdata/noctty/config.ghostty"
        "herdr-core/config.windows.toml" "$appdata/herdr-core/config.toml"
        "herdr-app/keys.windows.json" "$home/.config/herdr-app/keys.json"
    )
    local resource
    for resource in settings.json programs.json my-icons layouts/ghostty.json themes/ghostty.json mods/ghostty-bar mods/leader mods/nav mods/copy; do
        pairs+=("herdr-app/$resource" "$home/.config/herdr-app/$resource")
    done

    local script="" i source dest
    for ((i = 0; i < ${#pairs[@]}; i += 2)); do
        source="$DOTFILES_PATH/${pairs[i]}"
        dest="${pairs[i + 1]}"
        [ -L "$dest" ] && continue
        if [ -e "$dest" ]; then
            printf 'Refusing to replace existing resource: %s\n' "$dest" >&2
            continue
        fi
        mkdir -p "$(dirname "$dest")"
        script+="New-Item -ItemType SymbolicLink -Path '$(wslpath -w "$dest")' -Target '$(wslpath -w "$source")'"$'\r\n'
    done
    [ -n "$script" ] || return 0

    local ps1="$(wslpath -u "$temp")/dotfiles-links.ps1"
    printf '%s' "$script" >"$ps1"
    (cd /mnt/c && powershell.exe -NoProfile -Command \
        "Start-Process powershell -Verb RunAs -Wait -WindowStyle Hidden -ArgumentList '-NoProfile','-ExecutionPolicy','Bypass','-File','$(wslpath -w "$ps1")'")
    rm -f "$ps1"
}
grep -qi microsoft /proc/version 2>/dev/null && link_windows_resources
# Machine-local global tools can go in ~/.config/mise/conf.d/*.toml
link_resource "$DOTFILES_PATH/mise/config.toml" "$XDG_CONFIG/mise/config.toml"

# Keep OMP credentials and session state local; link only versioned resources.
mkdir -p "$HOME/.omp/agent"
link_resource "$DOTFILES_PATH/omp/config.yml" "$HOME/.omp/agent/config.yml"
link_resource "$DOTFILES_PATH/omp/keybindings.yml" "$HOME/.omp/agent/keybindings.yml"
link_resource "$DOTFILES_PATH/omp/mcp.json" "$HOME/.omp/agent/mcp.json"
link_resource "$DOTFILES_PATH/omp/skills" "$HOME/.omp/agent/skills"
link_resource "$DOTFILES_PATH/claude/keybindings.json" "$HOME/.claude/keybindings.json"
mkdir -p "$HOME/.claude/themes"
link_resource "$DOTFILES_PATH/claude/themes/x.json" "$HOME/.claude/themes/x.json"
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

# Hermes reports its status to herdr through this shell hook.
[ -d "$HOME/.hermes" ] && link_resource "$DOTFILES_PATH/hermes/herdr-status.sh" "$HOME/.hermes/agent-hooks/herdr-status.sh"

link_resource "$DOTFILES_PATH/httpie.json" "$XDG_CONFIG/httpie.json"
link_resource "$DOTFILES_PATH/starship.toml" "$XDG_CONFIG/starship.toml"
link_resource "$DOTFILES_PATH/.tmux.conf" "$HOME/.tmux.conf"
link_resource "$DOTFILES_PATH/.prettierrc" "$HOME/.prettierrc"
link_resource "$DOTFILES_PATH/.vimrc" "$HOME/.vimrc"
link_resource "$DOTFILES_PATH/opencode" "$XDG_CONFIG/opencode"
# Claude Code and Codex rewrite their own config files, so merge the shared keys instead of linking.
bash "$DOTFILES_PATH/scripts/agent-config.sh"
