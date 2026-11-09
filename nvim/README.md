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
