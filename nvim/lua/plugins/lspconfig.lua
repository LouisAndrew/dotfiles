return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "b0o/SchemaStore.nvim", ft = { "json", "toml", "yaml" } },
  },
  opts = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    local opts = require("lazyvim.plugins.lsp")[1].opts()

    opts.diagnostics.virtual_text = false
    opts.diagnostics.float = {
      border = "single",
      header = "",
      prefix = { " ", "NoiceHoverNormal" },
      suffix = { " ", "NoiceHoverNormal" },
    }

    opts.diagnostics.signs = false
    keys[#keys + 1] = { "J", vim.diagnostic.open_float, desc = "Open diagnostic float" }
    keys[#keys + 1] = {
      "K",
      function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
          require("noice.lsp").hover()
        end
      end,
      desc = "Peek fold or hover",
    }

    local server_configs = require("utils").loaddir("lua/lsp/*.lua")
    for srv, cfg in pairs(server_configs) do
      opts.servers[srv:gsub("lsp.", "")] = cfg
    end

    return opts
  end,
}
