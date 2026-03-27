vim.diagnostic.config({
	virtual_lines = false,
	virtual_text = false,
	signs = false,
	severity_sort = true,
	update_in_insert = false,
	underline = true,
	float = {
		border = "single",
		severity_sort = true,
		source = true,
		prefix = { " ", "NoiceHoverNormal" },
		suffix = { " ", "NoiceHoverNormal" },
		header = "",
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
	vim.fn.sign_define(sign.name, {
		texthl = sign.name,
		text = sign.text,
		numhl = "",
	})
end
