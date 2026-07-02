return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local icons = require("utils.icons")

      opts.diagnostics = {
        virtual_text = {
          prefix = "",
        },
        signs = false,
        float = {
          border = "single",
          severity_sort = true,
          source = true,
          prefix = { " ", "NoiceHoverNormal" },
          suffix = { " ", "NoiceHoverNormal" },
          header = "",
        },
      }

      local signs = {
        { name = "DiagnosticSignError", text = icons.ArrowClosed },
        { name = "DiagnosticSignWarn", text = icons.ArrowClosed },
        { name = "DiagnosticSignHint", text = icons.ArrowClosed },
        { name = "DiagnosticSignInfo", text = icons.ArrowClosed },
      }

      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, {
          texthl = sign.name,
          text = sign.text,
          numhl = "",
        })
      end

      local keys = opts.servers["*"].keys
      for _, key in ipairs(keys) do
        if key[1] == "gD" then
          key[2] = function()
            vim.cmd.vsplit()
            vim.lsp.buf.definition()
          end
          key.desc = "Definition (Vsplit)"
          key.has = "definition"
          return opts
        end
      end

      return opts
    end,
  },
}
