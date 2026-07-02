return {
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
    },
  },
  {
    "Bekaboo/dropbar.nvim",
    build = "make",
    event = "BufEnter",
    keys = {
      {
        "<Leader>;",
        function()
          require("dropbar.api").pick()
        end,
        desc = "Pick symbols in winbar",
      },
      {
        "[;",
        function()
          require("dropbar.api").goto_context_start()
        end,
        desc = "Go to start of current context",
      },
      {
        "];",
        function()
          require("dropbar.api").select_next_context()
        end,
        desc = "Select next context",
      },
    },
    config = function()
      local icons = require("utils.icons")

      require("dropbar").setup({
        menu = {
          win_configs = {
            border = "rounded",
          },
        },
        icons = {
          kinds = {
            symbols = {
              Array = icons.Array,
              Boolean = icons.Boolean,
              Class = icons.Class,
              Color = icons.Color,
              Constant = icons.Constant,
              Constructor = icons.Constructor,
              Enum = icons.Enum,
              EnumMember = icons.EnumMember,
              Event = icons.Event,
              Field = icons.Field,
              File = icons.File,
              Folder = icons.Folder,
              Function = icons.Function,
              Identifier = icons.Variable,
              Interface = icons.Interface,
              Keyword = icons.Keyword,
              Method = icons.Method,
              Module = icons.Module,
              Namespace = icons.Namespace,
              Null = icons.Null,
              Number = icons.Number,
              Object = icons.Object,
              Operator = icons.Operator,
              Package = icons.Package,
              Property = icons.Property,
              Reference = icons.Reference,
              Snippet = icons.Snippet,
              String = icons.String,
              Struct = icons.Struct,
              Text = icons.Text,
              TypeParameter = icons.TypeParameter,
              Unit = icons.Unit,
              Value = icons.Value,
              Variable = icons.Variable,
            },
          },
        },
      })

      vim.ui.select = require("dropbar.utils.menu").select
    end,
  },
}
