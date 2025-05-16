local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
local volar_path = mason_packages .. "/vue-language-server/node_modules/@vue/language-server"

return {
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					{
						name = "@vue/typescript-plugin",
						location = volar_path,
						languages = { "vue" },
						configNamespace = "typescript",
						enableForWorkspaceTypeScriptVersions = true,
					},
				},
			},
		},
	},
}
