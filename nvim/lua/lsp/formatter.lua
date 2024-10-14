local null_ls = require("null-ls")
local conform = require("conform")

local utils = require("utils")

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		rust = { "rust_analyzer" },
		astro = { "eslint_d" },
		go = { "gofmt" },
		markdown = { "prettier" },
	},
	format_on_save = {
		timeout_ms = 500,
	},
})

local lsp_fallback_format_ft = {
	"json",
	"css",
	"scss",
	"docker",
}

vim.g.ENABLE_AUTOFORMAT = "true"
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		if vim.g.ENABLE_AUTOFORMAT == "true" then
			local file = args.file
			local extension = vim.fn.fnamemodify(file, ":e")
			if utils.has_value(lsp_fallback_format_ft, extension) and vim.g.ENABLE_AUTOFORMAT == "true" then
				vim.lsp.buf.format()
			end
		end
	end,
})

null_ls.setup({
	sources = {
		null_ls.builtins.diagnostics.markdownlint,
		null_ls.builtins.formatting.textlint,
		null_ls.builtins.diagnostics.spectral,
		null_ls.builtins.diagnostics.staticcheck,
	},
})
