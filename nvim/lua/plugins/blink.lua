local icons = require("theme.minimal_fedu.icons")
local config = require("theme.minimal_fedu.config")

local blink_keymap = {
  ["<C-e>"] = { "show", "hide" },
  ["<CR>"] = { "accept", "fallback" },
  ["<Tab>"] = {},
  ["<Space>"] = { "accept", "fallback" },
  ["<C-r>"] = { "show_documentation", "hide_documentation" },
  ["<C-u>"] = { "scroll_documentation_up", "fallback" },
  ["<C-d>"] = { "scroll_documentation_down", "fallback" },
}

return {
  "saghen/blink.cmp",
  opts = {
    appearance = {
      kind_icons = icons,
    },
    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
      accept = {
        auto_brackets = {
          enabled = false,
        },
      },
      menu = {
        border = config.winborder,
        winblend = config.winblend,
        draw = {
          columns = { { "kind_icon", "label" } },
        },
      },
      documentation = {
        window = {
          border = config.winborder,
          winblend = config.winblend,
        },
      },
    },
    keymap = blink_keymap,
    -- snippets = {
    --   preset = "luasnip",
    -- },
    cmdline = {
      enabled = true,
      keymap = blink_keymap,
      completion = {
        list = {
          selection = {
            preselect = false,
            auto_insert = false,
          },
        },
        menu = { auto_show = true },
        ghost_text = { enabled = false },
      },
    },
  },
}
