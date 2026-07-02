return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local keys = opts.servers["*"].keys

      for _, key in ipairs(keys) do
        if key[1] == "gD" then
          key[2] = function()
            vim.cmd.vsplit()
            vim.lsp.buf.definition()
          end
          key.desc = "Definition (Vsplit)"
          key.has = "definition"
          return
        end
      end
    end,
  },
}
