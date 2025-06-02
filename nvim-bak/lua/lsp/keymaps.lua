local keymaps = require("keymaps")
local diag_float_config = {
  severity_sort = true,
  source = true,
  prefix = { " ", "NoiceHoverNormal" },
  suffix = { " ", "NoiceHoverNormal" },
  header = "",
}

return {
  generate_keymaps = function(bufnr)
    local opts = { buffer = bufnr, remap = false }

    local M = {
      n = {
        { "go", vim.lsp.buf.definition, opts = { desc = "Go to definition" } },
        {
          "K",
          function()
            local winid = require("ufo").peekFoldedLinesUnderCursor()
            if not winid then
              require("noice.lsp").hover()
            end
          end,
          opts = {
            desc = "Hover",
          },
        },
        {
          "<leader>is",
          vim.lsp.buf.document_symbol,
          opts = { desc = "Document symbols" },
        },
        {
          "<space>id",
          function()
            vim.diagnostic.open_float(diag_float_config)
          end,
          opts = {
            desc = "Open diagnostic in float",
          },
        },
        {
          "J",
          function()
            vim.diagnostic.open_float(diag_float_config)
          end,
          opts = {
            desc = "Open diagnostic in float",
          },
        },
        {
          "M",
          require("fastaction").code_action,
          opts = { desc = "Code actions" },
        },
        { "<leader>in", vim.lsp.buf.rename, opts = { desc = "Rename" } },
        { "<leader>rr", "<cmd>LspRestart<CR>" },
        {
          "[d",
          function()
            vim.diagnostic.jump({
              count = -1,
              float = diag_float_config,
            })
          end,
          opts = { desc = "Prev diagnostic" },
        },
        {
          "]d",
          function()
            vim.diagnostic.jump({
              count = 1,
              float = diag_float_config,
            })
          end,
          opts = { desc = "Next diagnostic" },
        },
        {
          "[e",
          function()
            vim.diagnostic.jump({
              count = -1,
              float = diag_float_config,
              severity = vim.diagnostic.severity.ERROR,
            })
          end,
          opts = { desc = "Prev error" },
        },
        {
          "]e",
          function()
            vim.diagnostic.jump({
              count = 1,
              float = diag_float_config,
              severity = vim.diagnostic.severity.ERROR,
            })
          end,
          opts = { desc = "Next error" },
        },
        {
          "[w",
          function()
            vim.diagnostic.jump({
              count = -1,
              float = diag_float_config,
              severity = vim.diagnostic.severity.WARN,
            })
          end,
          opts = { desc = "Prev warning" },
        },
        {
          "]w",
          function()
            vim.diagnostic.jump({
              count = 1,
              float = diag_float_config,
              severity = vim.diagnostic.severity.WARN,
            })
          end,
          opts = { desc = "Next warning" },
        },
        { "<leader>ir", vim.lsp.buf.references, opts = { desc = "Find references" } },
        {
          "<leader>rl",
          function()
            if vim.g.EXPAND_LSP == "true" then
              vim.g.EXPAND_LSP = "false"
            else
              vim.g.EXPAND_LSP = "true"
            end
          end,
          "toggle lualine lsp expand",
        },
      },
      i = {
        {
          "<c-b>",
          vim.lsp.buf.signature_help,
          opts = { desc = "Signature help" },
        },
        { "<C-h>", "<Left>" },
      },
      v = {
        {
          "<leader>ir",
          vim.lsp.buf.references,
          {
            desc = "Find references",
          },
        },
      },
    }

    keymaps.build_keymaps(M, opts)
  end,
}
