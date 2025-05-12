local keymaps = require("lsp.keymaps")

local navic = require("nvim-navic")
local utils = require("utils")

vim.diagnostic.config({
	virtual_lines = false,
	virtual_text = false,
	signs = false,
	severity_sort = true,
	update_in_insert = false,
	underline = true,
	float = {
		border = "single",
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp", {}),
	callback = function(args)
		-- commenting for now; it stops clients e.g. on preview buffers
		-- local clients = vim.lsp.get_clients({ bufnr = args.buf })
		--
		-- local t = {}
		-- for _, c in ipairs(clients) do
		-- 	if t[c.name] ~= nil then
		-- 		local old = t[c.name]
		-- 		print("stopping duplicate LSP: ", c.name)
		-- 		old.stop()
		-- 	end
		--
		-- 	t[c.name] = c
		-- end

		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if
			client.server_capabilities["documentSymbolProvide"]
			and utils.has_value({
				"graphql",
				"vtsls",
			}, client.name) ~= true
		then
			navic.attach(client, args.buf)
		end

		keymaps.generate_keymaps(args.buf)
	end,
})

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"rust_analyzer",
		"lua_ls",
		"tailwindcss",
		"cssls",
		"html",
		"volar",
	},
	automatic_enable = true,
})

-- custom configs
local servers = {
	"eslint",
	"graphql",
	"vtsls",
	"jsonls",
	"emmet_ls",
	"yamlls",
	"cssls",
	"tailwindcss",
}

for _, srv in ipairs(servers) do
	vim.lsp.config(srv, require("lsp." .. srv))
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
vim.lsp.config("kulala_ls", {
	capabilities = capabilities,
})

local icons = require("theme.icons")

local signs = {
	{ name = "DiagnosticSignError", text = icons.ArrowClosed },
	{ name = "DiagnosticSignWarn", text = icons.ArrowClosed },
	{ name = "DiagnosticSignHint", text = icons.ArrowClosed },
	{ name = "DiagnosticSignInfo", text = icons.ArrowClosed },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end
