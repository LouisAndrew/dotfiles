local emmet_capabilities = vim.lsp.protocol.make_client_capabilities()
emmet_capabilities.textDocument.completion.completionItem.snippetSupport = true

return {
	capabilities = emmet_capabilities,
	filetypes = {
		"css",
		"eruby",
		"html",
		"javascript",
		"javascriptreact",
		"less",
		"sass",
		"scss",
		"svelte",
		"pug",
		"typescriptreact",
	},
	init_options = {
		html = {
			options = {
				["bem.enabled"] = true,
			},
		},
	},
}
