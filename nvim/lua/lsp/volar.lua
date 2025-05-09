return {
	root_dir = require("lspconfig").util.root_pattern("*.vue"),
	filetypes = { "vue" },
	init_options = {
		vue = {
			hybridMode = true,
		},
	},
}
