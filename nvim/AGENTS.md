# AGENTS.md

Scope: applies to everything under `nvim/`.

## Goal

Maintain this directory as a small, opinionated [LazyVim](https://www.lazyvim.org/) config.
Prefer LazyVim-native patterns over bespoke Neovim setup code.

LazyVim model:

- `init.lua` should stay thin and bootstrap `config.lazy`
- `lua/config/*.lua` holds local options, keymaps, autocmds, and lazy bootstrap
- `lua/plugins/*.lua` holds lazy.nvim plugin specs and LazyVim overrides
- `lazyvim.json` tracks enabled LazyVim extras and install metadata
- `lazy-lock.json` is generated lock state; change it only when plugin versions actually change

## Current Shape

- Base distro: `LazyVim/LazyVim`
- Plugin manager: `folke/lazy.nvim`
- Custom colorscheme: `lua/lush_theme/zed_minimal.lua` via `rktjmp/lush.nvim`
- Extra plugins already added locally: `smart-splits.nvim`, `snacks.nvim` tweaks, `neogit`, `nvim-nonicons`
- Enabled LazyVim extras in `lazyvim.json`:
  - `lazyvim.plugins.extras.coding.mini-surround`
  - `lazyvim.plugins.extras.lang.dotnet`

## Edit Rules

- Prefer extending or overriding LazyVim plugin specs instead of adding ad hoc `require(...)` setup blocks elsewhere.
- Put plugin changes in `lua/plugins/*.lua`. Keep each file focused by concern.
- Put editor behavior not tied to one plugin in `lua/config/options.lua`, `lua/config/keymaps.lua`, or `lua/config/autocmds.lua`.
- Reuse LazyVim defaults when possible. Do not copy upstream config into this repo unless local behavior truly diverges.
- If disabling built-in LazyVim behavior, do it with plugin spec `enabled = false` or documented override points.
- Keep `init.lua` minimal.
- Keep comments sparse and useful.

## LazyVim Conventions

- Plugin specs return tables consumable by `require("lazy").setup(...)`.
- For existing plugins, prefer `opts = function(_, opts) ... end` when merging with upstream defaults.
- Use plain `opts = { ... }` only when additive merge is sufficient.
- Use `dependencies`, `keys`, `cmd`, `event`, and `ft` to match lazy-loading conventions instead of eager startup loading unless startup behavior needs it.
- Before introducing custom keymaps for built-in features, check whether LazyVim already exposes one.
- Prefer LazyVim extras from docs when feature already exists there.

## Theme Rules

- `lua/lush_theme/zed_minimal.lua` is hand-authored theme source of truth.
- Theme edits should preserve palette-driven structure and existing naming style.
- If changing active colorscheme, update `lua/plugins/colorscheme.lua` rather than scattering `vim.cmd.colorscheme(...)` calls.

## Validation

After non-trivial changes, run relevant checks from `nvim/`:

1. `nvim --headless '+Lazy! sync' +qa` when plugin specs, extras, or lock state change.
2. `nvim --headless '+checkhealth' +qa` when runtime/tooling behavior may be affected.
3. `stylua lua/**/*.lua init.lua` when Lua files were edited and `stylua` exists.

If command is too heavy for task, at least ensure edited Lua files stay syntactically valid and stylistically consistent.

## Avoid

- Do not rewrite this into raw `packer`, `mini.deps`, or manual package loading.
- Do not move plugin config into `init.lua`.
- Do not edit `lazy-lock.json` by hand for cosmetic reasons.
- Do not add fallback compatibility layers unless user asks for support across multiple Neovim or LazyVim versions.

## Useful References

- Docs: `https://www.lazyvim.org/`
- LazyVim default config patterns: `https://www.lazyvim.org/configuration`
- Plugin override patterns and extras: `https://www.lazyvim.org/plugins` and `https://www.lazyvim.org/extras`
