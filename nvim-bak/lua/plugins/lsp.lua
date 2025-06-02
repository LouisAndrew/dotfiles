local icons = require("theme.icons")

return {
  "neovim/nvim-lspconfig",
  event = { "BufEnter", "BufWinEnter" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    {
      "rmagatti/goto-preview",
      event = "BufEnter",
      config = true,
      keys = {
        { "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>" },
        { "gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>" },
        { "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>" },
      },
      desc = "definition preview in a floating window",
    },
    {
      "stevearc/conform.nvim",
      lazy = true,
      desc = "Formatter",
    },
    {
      "kevinhwang91/nvim-ufo",
      dependencies = {
        "kevinhwang91/promise-async",
      },
      desc = "Folds",
    },
    -- json schema
    "b0o/SchemaStore.nvim",
    {
      -- Lua LSP
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "luvit-meta/library", words = { "vim%.uv" } },
        },
      },
    },
    { "Bilal2453/luvit-meta", lazy = true },
    {
      "folke/trouble.nvim",
      lazy = true,
      keys = {
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Toggle trouble tab" },
      },
      ---@module 'trouble'
      ---@type trouble.Config
      opts = {
        auto_preview = false,
      },
    },
    {
      "hedyhli/outline.nvim",
      lazy = true,
      keys = {
        { "<leader>it", "<cmd>:Outline<cr>" },
      },
      opts = {
        keymaps = {
          fold_toggle = "za",
          down_and_jump = "<C-n>",
          up_and_jump = "<C-p>",
          fold_all = "zM",
          unfold_all = "zR",
        },
        symbols = {
          icons = require("theme.outline-icons"),
        },
      },
      desc = "Outline",
    },
  },
  config = function()
    require("lsp")
  end,
}
