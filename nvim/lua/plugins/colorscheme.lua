local palettes = {
  -- Everything defined under `all` will be applied to each style.
  all = {
    -- Each palette defines these colors:
    --   black, gray, blue, green, magenta, pink, red, white, yellow, cyan
    --
    -- These colors have 2 shades: base, and bright

    -- Passing a string sets the base
    black = "#0a0a0a",
    gray = {
      base = "#9a9a9a",
      bright = "#d5d5d5",
    },
    blue = {
      base = "#172554",
      bright = "#93c5fd",
    },
    green = {
      base = "#173626",
      bright = "#81ffbb",
    },
    magenta = {
      base = "#291A2E",
      bright = "#e879f9",
    },
    red = {
      base = "#42191b",
      bright = "#ff8185",
    },
    white = "#ffffff",
    yellow = {
      base = "#713f12",
      bright = "#fed7aa",
    },
    cyan = "#97CCF1",

    bg0 = "#131313",
    bg1 = "#0a0a0a",
    bg2 = "#1a1a1a",
    bg3 = "#1f2425",
    bg4 = "#323232",
    fg0 = "#ffffff",
    fg1 = "#ffffff",
    fg2 = "#d5d5d5",
    fg3 = "#9a9a9a",
    sel0 = "#242536",
    sel1 = "#221f36",
    sel2 = "#1e1b4b",
    comment = "#737373",
  },
}

local specs = {
  all = {
    syntax = {
      bracket = "fg3",
      builtin0 = "#ff8185",
      builtin1 = "#93c5fd",
      builtin2 = "#fed7aa",
      comment = "comment",
      conditional = "#ff8185",
      const = "#ff8185",
      field = "fg1",
      func = "#ffcfa7",
      ident = "fg1",
      keyword = "#ff8185",
      number = "#ffd6b3",
      operator = "fg3",
      param = "fg1",
      preproc = "#e879f9",
      regex = "#97CCF1",
      string = "#81ffbb",
      tag = "#93c5fd",
      type = "#a5b4fc",
      variable = "fg1",
    },
    diag = {
      error = "#ff8185",
      warn = "#fed7aa",
      info = "#93c5fd",
      hint = "fg3",
    },
    diff = {
      add = "#173626",
      change = "#221f36",
      delete = "#42191b",
      text = "#242536",
    },
    git = {
      add = "#81ffbb",
      changed = "#a5b4fc",
      removed = "#ff8185",
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
    Visual = { bg = "#242536" },

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
