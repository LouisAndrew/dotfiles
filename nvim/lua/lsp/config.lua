local keymaps = require("lsp.keymaps")

local lsp_zero = require("lsp-zero")
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

lsp_zero.on_attach(function(client, bufnr)
	if
		client.server_capabilities["documentSymbolProvider"]
		and utils.has_value({
			"graphql",
			"vtsls",
		}, client.name) ~= true
	then
		navic.attach(client, bufnr)
	end

	keymaps.generate_keymaps(bufnr)
end)

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
	handlers = {
		lsp_zero.default_setup,
		rust_analyzer = function()
			require("lspconfig").rust_analyzer.setup({
				on_attach = lsp_zero.on_attach,
				settings = {
					["rust-analyzer"] = {
						checkOnSave = {
							command = "clippy",
						},
					},
				},
			})
		end,
	},
})

local lspconfig = require("lspconfig")

lspconfig.graphql.setup({
	filetypes = { "graphql", "javascript", "typescript", "typescriptreact" },
})

lspconfig.eslint.setup({
	on_attach = function(_, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
})

lspconfig.tailwindcss.setup({
	root_dir = lspconfig.util.root_pattern(
		"tailwind.config.js",
		"tailwind.config.cjs",
		"tailwind.config.ts",
		"tailwind.config.mjs"
	),
	filetypes = { "html", "css", "scss", "typescriptreact", "svelte", "vue", "javascriptreact", "astro" },
})

lspconfig.volar.setup({
	root_dir = lspconfig.util.root_pattern("*.vue"),
	filetypes = { "vue" },
	init_options = {
		vue = {
			hybridMode = true,
		},
	},
})

lspconfig.vtsls.setup({
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
	on_attach = function(client, bufnr)
		if vim.bo.filetype == "vue" then
			return
		end

		navic.attach(client, bufnr)
	end,
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					{
						name = "@vue/typescript-plugin",
						location = require("mason-registry").get_package("vue-language-server"):get_install_path()
							.. "/node_modules/@vue/language-server",
						languages = { "vue" },
						configNamespace = "typescript",
						enableForWorkspaceTypeScriptVersions = true,
					},
				},
			},
		},
	},
})

require("lspconfig").jsonls.setup({
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
	init_options = {
		provideFormatter = true,
	},
})

local emmet_capabilities = vim.lsp.protocol.make_client_capabilities()
emmet_capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.emmet_ls.setup({
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
		"vue",
	},
	init_options = {
		html = {
			options = {
				["bem.enabled"] = true,
			},
		},
	},
})

require("lspconfig").yamlls.setup({
	settings = {
		yaml = {
			schemaStore = {
				enable = false,
				url = "",
			},
			schemas = require("schemastore").yaml.schemas(),
		},
	},
})

require("lspconfig").cssls.setup({
	settings = {
		css = {
			validate = true,
			lint = {
				unknownAtRules = "ignore",
			},
		},
		scss = {
			validate = true,
			lint = {
				unknownAtRules = "ignore",
			},
		},
		less = {
			validate = true,
			lint = {
				unknownAtRules = "ignore",
			},
		},
	},
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
