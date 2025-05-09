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
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if
			client.server_capabilities["ocumentSymbolProvide"]
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

local custom_servers = {
	"kulala_ls",
}

local nvim_lsp = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()

for _, lsp in ipairs(custom_servers) do
	if nvim_lsp[lsp] ~= nil then
		if nvim_lsp[lsp].setup ~= nil then
			nvim_lsp[lsp].setup({
				capabilities = capabilities,
			})
		else
			vim.notify("LSP server " .. lsp .. " does not have a setup function", vim.log.levels.ERROR)
		end
	end
end

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

local lspconfig = require("lspconfig")

lspconfig.eslint.setup(require("lsp.eslint"))
lspconfig.graphql.setup(require("lsp.graphql"))
lspconfig.tailwindcss.setup(require("lsp.tailwindcss"))
lspconfig.volar.setup(require("lsp.volar"))
lspconfig.vtsls.setup(require("lsp.vtsls"))
lspconfig.jsonls.setup(require("lsp.jsonls"))
lspconfig.emmet_ls.setup(require("lsp.emmet_ls"))
lspconfig.yamlls.setup(require("lsp.yamlls"))
lspconfig.cssls.setup(require("lsp.cssls"))

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
