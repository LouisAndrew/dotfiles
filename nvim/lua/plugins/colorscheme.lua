local palettes = {
  -- Everything defined under `all` will be applied to each style.
  all = {
    -- Each palette defines these colors:
    --   black, gray, blue, green, magenta, pink, red, white, yellow, cyan
    --
    -- These colors have 2 shades: base, and bright

    -- Passing a string sets the base
    bg1 = "#121212",
  },
}

local specs = {
  all = {
    syntax = {
      field = "fg1",
      ident = "fg1",
      variable = "fg1",
    },
  },
}

local groups = {
  all = {
    Identifier = { fg = "fg1" },
    Cursor = { bg = "#818cf8" },
    CursorLine = { bg = "NONE" },
    CursorLineNr = { bg = "NONE" },
    Exception = { link = "Constant" },
    Visual = { bg = "#343950" },

    ["@variable"] = { fg = "fg1" },
    ["@variable.javascript"] = { fg = "fg1" },
    ["@variable.typescript"] = { fg = "fg1" },
    ["@variable.tsx"] = { fg = "fg1" },
    ["@variable.member"] = { fg = "fg1" },
    ["@variable.member.javascript"] = { fg = "fg1" },
    ["@variable.member.typescript"] = { fg = "fg1" },
    ["@variable.member.tsx"] = { fg = "fg1" },
    ["@property"] = { fg = "fg1" },
    ["@property.javascript"] = { fg = "fg1" },
    ["@property.typescript"] = { fg = "fg1" },
    ["@property.tsx"] = { fg = "fg1" },
    ["@keyword.exception"] = { link = "Constant" },
    ["@keyword.exception.typescript"] = { link = "Constant" },

    ["@lsp.type.property"] = { fg = "fg1" },
    ["@lsp.type.property.javascript"] = { fg = "fg1" },
    ["@lsp.type.property.typescript"] = { fg = "fg1" },
    ["@lsp.type.property.typescriptreact"] = { fg = "fg1" },
    ["@lsp.type.variable"] = { fg = "fg1" },
    ["@lsp.type.variable.javascript"] = { fg = "fg1" },
    ["@lsp.type.variable.typescript"] = { fg = "fg1" },
    ["@lsp.type.variable.typescriptreact"] = { fg = "fg1" },
  },
}

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = false,
    priority = 1000,
    opts = {
      no_italic = true,
      term_colors = true,
      transparent_background = false,
      color_overrides = {
        mocha = {
          base = "#0a0a0a",
          mantle = "#0a0a0a",
          crust = "#0a0a0a",
        },
      },
      integrations = {
        telescope = {
          enabled = true,
          style = "nvchad",
        },
        dropbar = {
          enabled = true,
          color_mode = true,
        },
      },
    },
  },

  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      palettes = palettes,
      specs = specs,
      groups = groups,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "github_dark_default",
    },
  },
}
