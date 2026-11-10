# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

Local keymap: `gD` opens the LSP definition in a horizontal split.

Local jump navigation: `<C-p>` goes to the previous jumplist location.
`<C-i>` goes to the next (Neovim default). `<C-o>` opens the Snacks file picker.

Flash is disabled; native search and character motions are unchanged.

TypeScript: `vtsls` allows up to 8192 MB of TS server heap in `lua/plugins/lsp.lua`.
Large monorepos exceed the default 3072 MB cap and can crash with out-of-memory errors.
Restart Neovim after changing this limit.

## tmux terminal integration

Ghostty hosts tmux; `smart-splits.nvim` handles `Ctrl+h/j/k/l` navigation
inside Neovim and across tmux pane edges. `Alt+h/j/k/l` resizes panes,
and `Ctrl+\` selects the previous pane.

The shell startup session picker and `t` alias use tmux. `fs` scopes the
project picker to the current tmux session when it matches a development directory.
Bootstrap installs tmux and TPM, and links the root `.tmux.conf` to
`~/.tmux.conf`. For an existing machine, install tmux and TPM if missing,
then link the config without replacing an existing non-symlink file:

```sh
brew install tmux
git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
ln -s "$DOTFILES_PATH/.tmux.conf" "$HOME/.tmux.conf"
tmux
```

Prefix is `Ctrl+i`; press prefix, `I` to install TPM plugins.
The Nova theme and previous split, copy-mode, scratch-session popup, and
detach bindings are restored. Press prefix, `r` to reload the config.
Inside tmux, `Ctrl+i` is reserved for the prefix rather than Neovim's jumplist.

