---@diagnostic disable: undefined-global
local keymaps = require("keymaps")

return {
	generate_keymaps = function(bufnr)
		local opts = { buffer = bufnr, remap = false }

		local M = {
			n = {
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
					"J",
					vim.diagnostic.open_float,
					opts = {
						desc = "Open diagnostic in float",
					},
				},
				{
					"M",
					vim.lsp.buf.code_action,
					opts = { desc = "Code actions" },
				},
				{ "<leader>rr", "<cmd>LspRestart<CR>" },
				{
					"[d",
					function()
						vim.diagnostic.jump({
							count = -1,
						})
					end,
					opts = { desc = "Prev diagnostic" },
				},
				{
					"]d",
					function()
						vim.diagnostic.jump({
							count = 1,
						})
					end,
					opts = { desc = "Next diagnostic" },
				},
				{
					"[e",
					function()
						vim.diagnostic.jump({
							count = -1,
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
							severity = vim.diagnostic.severity.WARN,
						})
					end,
					opts = { desc = "Next warning" },
				},
				{ "gry", vim.lsp.buf.type_definition, opts = { desc = "goto typedef" } },
				{
					"gd",
					function()
						local ft = vim.bo.filetype
						if ft == "markdown" then
							vim.cmd("ObsidianFollowLink")
							return
						end

						vim.lsp.buf.definition()
					end,
					opts = { desc = "Go to definition" },
				},
				{ "grD", vim.lsp.buf.declaration, opts = { desc = "goto declaration" } },
				{ "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
				{
					"<leader>cC",
					vim.lsp.codelens.refresh,
					desc = "Refresh & Display Codelens",
					mode = { "n" },
					has = "codeLens",
				},
				{
					"]]",
					function()
						Snacks.words.jump(vim.v.count1)
					end,
					has = "documentHighlight",
					desc = "Next Reference",
					cond = function()
						return Snacks.words.is_enabled()
					end,
				},
				{
					"[[",
					function()
						Snacks.words.jump(-vim.v.count1)
					end,
					has = "documentHighlight",
					desc = "Prev Reference",
					cond = function()
						return Snacks.words.is_enabled()
					end,
				},
				{
					"<a-n>",
					function()
						Snacks.words.jump(vim.v.count1, true)
					end,
					has = "documentHighlight",
					desc = "Next Reference",
					cond = function()
						return Snacks.words.is_enabled()
					end,
				},
				{
					"<a-p>",
					function()
						Snacks.words.jump(-vim.v.count1, true)
					end,
					has = "documentHighlight",
					desc = "Prev Reference",
					cond = function()
						return Snacks.words.is_enabled()
					end,
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
