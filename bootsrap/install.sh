# Install zsh and their plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode

# Install brew
if [[ $(uname) == "Darwin" ]];then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    alias install="brew install"
    alias install-gui="brew install --cask"
fi

pkgs=(
    starship
    asdf
    tmux
    fzf
    jq
    ripgrep
    neovim
    kubernetes-cli
    derailed/k9s/k9s
    carapace
    fd
    ni
    gh
)

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
    install $pkg
done

for gui in "${gui_pkgs[@]}"; do
    if command -v "$gui" >/dev/null 2>&1; then
        echo "$gui is installed; skipping"
    else
        install-gui $gui
    fi
done

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
