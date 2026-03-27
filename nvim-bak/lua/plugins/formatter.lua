local utils = require("utils")

local lsp_fallback_format_ft = {
	"css",
	"scss",
	"docker",
	"json",
}

return {
	"stevearc/conform.nvim",
	event = "LspAttach",
	desc = "Formatter",
	opts = {
		formatters = {
			kulala = {
				command = "kulala-fmt",
				args = { "format", "$FILENAME" },
				stdin = false,
			},
		},
		formatters_by_ft = {
			lua = { "stylua" },
			rust = { "rust_analyzer" },
			astro = { "eslint_d" },
			go = { "gofmt" },
			markdown = { "prettierd" },
			http = { "kulala" },

			-- enable for biome projects
			-- typescriptreact = { "biome" },
			-- typescript = { "biome" },
		},
		format_on_save = function(bufnr)
			-- Disable with a global or buffer-local variable
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end

			local file = vim.api.nvim_buf_get_name(bufnr)
			local extension = vim.fn.fnamemodify(file, ":e")

			if utils.has_value(lsp_fallback_format_ft, extension) then
				vim.lsp.buf.format()
				return
			end

			return {
				timeout_ms = 500,
			}
		end,
	},
}
