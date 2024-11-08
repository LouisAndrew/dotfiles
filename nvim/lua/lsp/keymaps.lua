local keymaps = require("keymaps")
local diag_float_config = {
	severity_sort = true,
	source = true,
	prefix = "",
	suffix = "",
	header = "",
}

return {
	generate_keymaps = function(bufnr)
		local opts = { buffer = bufnr, remap = false }

		local M = {
			n = {
				{ "go", vim.lsp.buf.definition },
				{
					"K",
					function()
						local winid = require("ufo").peekFoldedLinesUnderCursor()
						if not winid then
							vim.lsp.buf.hover()
						end
					end,
				},
				{ "<leader>is", vim.lsp.buf.workspace_symbol },
				{
					"<space>id",
					function()
						vim.diagnostic.open_float(diag_float_config)
					end,
				},
				{ "<leader>ia", vim.lsp.buf.code_action },
				{ "<leader>it", "<cmd>Outline<CR>" },
				{ "<leader>in", vim.lsp.buf.rename },
				{ "<leader>rr", "<cmd>LspRestart<CR>" },
				{
					"[d",
					function()
						vim.diagnostic.jump({
							count = -1,
							float = diag_float_config,
						})
					end,
				}, -- jump to previous diagnostic in buffer
				{
					"]d",
					function()
						vim.diagnostic.jump({
							count = 1,
							float = diag_float_config,
						})
					end,
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
				},
				{ "<leader>ir", vim.lsp.buf.references },
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
				},
				{ "<C-h>", "<Left>", opts },
			},
			v = {
				{ "<leader>ir", vim.lsp.buf.references, opts },
			},
		}

		keymaps.build_keymaps(M, opts)
	end,
}
