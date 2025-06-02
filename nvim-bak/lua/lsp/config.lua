local keymaps = require("lsp.keymaps")

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp", {}),
	callback = function(args)
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
	},
	automatic_enable = true,
})

local servers = require("utils").loaddir("lua/lsp/servers/*.lua")

for name, cfg in pairs(servers) do
	vim.lsp.config(name:gsub("lsp.servers.", ""), cfg)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
vim.lsp.config("kulala_ls", {
	capabilities = capabilities,
})
