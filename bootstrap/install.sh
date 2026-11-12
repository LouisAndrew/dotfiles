# Installs shell, CLI tools and fonts. Works on macOS and Linux (incl. WSL).
OS="$(uname)"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

clone_if_missing() {
    [ -d "$2" ] || git clone --depth 1 "$1" "$2"
}

# System packages (Linux only)
if [ "$OS" = "Linux" ]; then
    sudo apt-get update
    sudo apt-get install -y build-essential curl git zsh tmux unzip fontconfig wl-clipboard xclip wslu
fi

# Install zsh and their plugins
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi
clone_if_missing https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
clone_if_missing https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_if_missing https://github.com/jeffreytse/zsh-vi-mode "$ZSH_CUSTOM/plugins/zsh-vi-mode"

# Install brew (Homebrew on Linux works too)
if ! command -v brew >/dev/null 2>&1; then
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
for brew_bin in /opt/homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
    [ -x "$brew_bin" ] && eval "$("$brew_bin" shellenv)" && break
done

pkgs=(
    starship
    tmux
    fzf
    jq
    ripgrep
    neovim
    kubernetes-cli
    derailed/k9s/k9s
    carapace
    fd
    bat
    eza
    lazygit
    ni
    gh
)
# mise may already be installed via https://mise.run
command -v mise >/dev/null 2>&1 || pkgs+=(mise)

gui_pkgs=(
    zed
    espanso
    obsidian
    raycast
    notion-calendar
    ghostty
    brave-browser
    spotify
)

for pkg in "${pkgs[@]}"; do
    brew install "$pkg"
done

if [ "$OS" = "Darwin" ]; then
    for gui in "${gui_pkgs[@]}"; do
        if command -v "$gui" >/dev/null 2>&1; then
            echo "$gui is installed; skipping"
        else
            brew install --cask "$gui"
        fi
    done
fi

# Fonts used by the ghostty config (Linux: Ghostty runs inside WSLg, so fonts must live in WSL)
if [ "$OS" = "Linux" ]; then
    font_dir="$HOME/.local/share/fonts"
    mkdir -p "$font_dir"
    if ! fc-list | grep -qi "CommitMono"; then
        tmp="$(mktemp -d)"
        curl -fsSL -o "$tmp/commit-mono.zip" \
            "https://github.com/eigilnikolajsen/commit-mono/releases/download/v1.143/CommitMono-1.143.zip"
        python3 -m zipfile -e "$tmp/commit-mono.zip" "$tmp/commit-mono"
        find "$tmp/commit-mono" -name '*.otf' -exec cp {} "$font_dir/" \;
        rm -rf "$tmp"
    fi
    [ -f "$font_dir/nonicons.ttf" ] || curl -fsSL -o "$font_dir/nonicons.ttf" \
        "https://raw.githubusercontent.com/ya2s/nonicons/master/dist/nonicons.ttf"
    fc-cache -f "$font_dir"
fi

clone_if_missing https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

command -v mise >/dev/null 2>&1 && mise install
