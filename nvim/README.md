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

## Herdr terminal integration

Ghostty hosts Herdr; [`vim-herdr-navigation`](https://github.com/paulbkim-dev/vim-herdr-navigation)
handles `Ctrl+h/j/k/l` inside Neovim and across Herdr pane edges. Its upstream
editor script loads after LazyVim's keymaps so those mappings win. Smart-splits
remains installed for resizing, buffer swaps, and the previous-window mapping,
but its multiplexer integration is disabled inside Herdr.
`herdr/config.toml` in the dotfiles root replaces `.tmux.conf`. Shells no longer
start a multiplexer automatically; run `herdr` (or `t` after loading the updated
shell aliases). Requires Herdr >= 0.7.0 and `jq`.

For an existing machine, install Herdr and the navigation bridge from the
dotfiles root:

```sh
brew install herdr jq
herdr plugin install paulbkim-dev/vim-herdr-navigation \
  --ref "$(jq -er '."vim-herdr-navigation".commit' "$DOTFILES_PATH/nvim/lazy-lock.json")" \
  --yes
mkdir -p "$HOME/.config/herdr"
ln -s "$DOTFILES_PATH/herdr/config.toml" "$HOME/.config/herdr/config.toml"
herdr
```

`DOTFILES_PATH` must point to this checkout. If the destination config already
exists, inspect and migrate it before linking; do not overwrite it. Only the
config file is linked: Herdr's sessions, logs, plugin installs, and state stay
local. Fresh-machine bootstrap installs Herdr and the same pinned bridge, and
links the config. Keep the bridge revision aligned with `nvim/lazy-lock.json`
when updating vim-herdr-navigation; rerun the plugin install command after a
revision change. Agent integrations are opt-in (`herdr integration install omp`, for
example).

If `Ctrl+h/j/k/l` reports `Action rejected: plugin not found`, check
`herdr plugin list`. The Neovim plugin and Herdr bridge are separate installs:
rerun the pinned `herdr plugin install` command above, then
`herdr server reload-config`. `herdr plugin action list --plugin vim-herdr-navigation`
should show the `left`, `down`, `up`, and `right` actions.

Herdr reuses the former tmux Nova palette: `#0a0a0a` backgrounds, `#f5f5f5`
active text, `#737373` muted text, and the `#818cf8` accent. Semantic status
colors still follow Ghostty's ANSI palette. The tab bar sits at the bottom;
pane splits have no outer frame or gaps. Borders and separators use `#303030`,
slightly lighter than the `#0a0a0a` background. These overrides live in
`herdr/config.toml` under `[theme.custom]` and `[ui]`.

The sidebar starts expanded so workspace names remain visible, with a 22-column
default width and automatic sizing between 18 and 26 columns. Press `Ctrl+i`,
then `b` to toggle it. On Herdr 0.9.5, collapsed rows are fixed compact indicators;
custom sidebar row layouts only apply while expanded. Width changes apply on
reload, but `sidebar_start_collapsed = false` takes effect on the next launch.

After editing, run `herdr config check`, then press `Ctrl+i`, `r` in Herdr
to reload both the client's theme and the server config. The CLI equivalent
for the server alone is `herdr server reload-config`.

Prefix is `Ctrl+i`. Ghostty's extended keyboard reporting distinguishes it
from Tab; terminals without that distinction need a different prefix.
Within Neovim, this still reserves `Ctrl+i` for Herdr rather than jumplist
navigation.

| Action | Binding |
| --- | --- |
| Split right / down | prefix, `l` / `j` |
| New tab (confirm its name with Enter) | prefix, `t` |
| Previous / next tab | prefix, `[` / `]` |
| New workspace / Goto picker | prefix, `n` / `s` |
| Previous / next workspace | prefix, `{` / `}` |
| Previous / next agent | prefix, `Shift+h` / `Shift+l` (`H` / `L`) |
| Navigate Neovim windows and Herdr panes | `Ctrl+h/j/k/l` |
| Navigate Herdr panes without editor routing | `Ctrl+Alt+h/j/k/l` |
| Resize Herdr pane | prefix, `Alt+h/j/k/l`, or prefix, `Shift+r` for resize mode |
| Zoom / copy mode | prefix, `f` / `c` |
| Close pane / tab | prefix, `q` / `Shift+q` |
| Scratch popup shell | prefix, `Shift+o`; `exit` closes it |
| Reload config / settings | prefix, `r` / `Shift+s` |
| Detach without stopping processes | `Ctrl+x` |

The scratch popup is not the old persistent tmux scratch session; use a
workspace for a long-lived scratch shell. `Alt+h/j/k/l` still invokes
smart-splits resizing inside Neovim, but shell-side resizing now uses the
prefixed bindings above. `Ctrl+\` remains an editor mapping, not a Herdr
last-pane binding. Tmux break/join bindings and Nova status formatting are
not carried over.

`fs` uses the existing project picker without consulting a multiplexer
session name; `fs <scope>` selects a scope explicitly. Detach/reattach keeps
live processes running. Stopping the Herdr server does not: layout restore is
not process persistence.

### Revert to smart-splits navigation

The old Herdr bridge is left installed on this machine; it has no keybindings
while vim-herdr-navigation is selected. To roll back only this change without
discarding unrelated config edits:

1. Restore `lua/plugins/splits.lua` to:

   ```lua
   return { "mrjones2014/smart-splits.nvim", lazy = false }
   ```

   This also removes the Herdr-specific multiplexer opt-out.
2. Add these normal-mode mappings back to `lua/config/keymaps.lua`:

   ```lua
   vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
   vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
   vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
   vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
   ```

3. In `herdr/config.toml`, change only the four action prefixes from
   `vim-herdr-navigation.` to `smart-splits.nvim.`. In `bootstrap/install.sh`,
   restore the repository to `mrjones2014/smart-splits.nvim` and the lockfile
   lookup to `."smart-splits.nvim".commit`. Remove the `vim-herdr-navigation`
   entry from `lazy-lock.json`; leave the existing smart-splits pin unchanged.
4. Ensure the old bridge is installed, validate, and reload:

   ```sh
   herdr plugin install mrjones2014/smart-splits.nvim \
     --ref "$(jq -er '."smart-splits.nvim".commit' "$DOTFILES_PATH/nvim/lazy-lock.json")" \
     --yes
   herdr config check
   herdr server reload-config
   ```

Restart Neovim and press `Ctrl+i`, `r` in the Herdr client. The unused
vim-herdr-navigation install can remain; neither configuration references it.
