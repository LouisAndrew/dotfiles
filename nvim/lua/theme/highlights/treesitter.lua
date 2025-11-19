local colors = require("minimal_fedu")

local syn_hl = {
	keyword = colors.palette.navy[1],
	-- keyword = colors.palette.grey[7],
	return_keyword = colors.palette.cyan[1],
	-- return_keyword = colors.palette.grey[7],
	fn = colors.palette.grey[3],
	fn_call = colors.palette.grey[6],
	-- fn_call = colors.palette.yellow[2], -- NestJS like
	property = colors.palette.grey[4],
	const = colors.palette.grey[6],
}

---@type _HlConfig
local md_config = {
	{ "@spell.markdown", colors.palette.grey[3] },
	{ "@markup", colors.palette.grey[5] },
	{ "@markup.link", colors.palette.grey[1] },
	{ "@markup.heading", colors.white, bold = true },
	{ "@markup.italic", italic = true },
	{ "@markup.list", colors.palette.grey[3] },
	{ "@markup.raw", colors.palette.yellow[2] },
}

---@type _HlConfig
local config = {
	{ "@character", colors.white },
	{ "@character.special", colors.palette.grey[3] },
	{ "@conditional", colors.palette.grey[3] },

	{ "@constructor", colors.palette.grey[2] },
	{ "@debug", colors.palette.grey[3] },
	{ "@define", colors.palette.grey[3] },
	{ "@exception", colors.cyan },
	{ "@field", colors.palette.grey[3] },

	-- keywords
	{ "@keyword", syn_hl.keyword },
	{ "@include", colors.palette.grey[7] },
	{ "@keyword.function", syn_hl.keyword },
	{ "@keyword.operator", colors.palette.grey[7] },
	{ "@keyword.conditional.ternary", colors.palette.grey[7] },

	-- Breaking keywords
	{ "@keyword.return", syn_hl.return_keyword },

	-- Macros
	{ "@lsp.type.macro", syn_hl.return_keyword },
	{ "@function.macro", syn_hl.return_keyword },
	{ "@macro", syn_hl.return_keyword },
	{ "@constant.macro", syn_hl.return_keyword },

	{ "@label", colors.palette.grey[3] },

	-- Methods + functions
	{ "@method", syn_hl.fn },
	{ "@lsp.mod.declaration", syn_hl.fn },
	{ "@lsp.type.function", syn_hl.fn },
	{ "@function", syn_hl.fn },
	{ "@function.builtin", syn_hl.fn },

	-- Methods + function calls
	{ "@function.call", syn_hl.fn_call },
	{ "@method.call", syn_hl.fn_call },
	{ "@lsp.type.method", syn_hl.fn_call },
	{ "@function.method.call", syn_hl.fn_call },

	{ "@namespace", colors.palette.grey[3] },
	{ "@none", colors.palette.grey[4] },
	{ "@operator", colors.palette.grey[7] },
	{ "@parameter", colors.palette.grey[3] },
	{ "@preproc", colors.palette.grey[3] },
	{ "@property", syn_hl.property },
	{ "@punctuation", colors.palette.grey[3] },
	{ "@punctuation.delimiter", colors.palette.grey[7] },
	{ "@repeat", colors.navy },
	{ "@storageclass", colors.palette.grey[3] },
	{ "@string", colors.primary },
	{ "@string.escape", colors.palette.grey[3] },
	{ "@string.special", colors.palette.grey[3] },
	{ "@structure", colors.palette.grey[3] },
	{ "@tag", colors.palette.grey[5] },
	{ "@tag.attribute", colors.palette.grey[6] },
	{ "@tag.delimiter", colors.palette.grey[4] },
	{ "@text.literal", colors.palette.grey[2] },
	{ "@text.reference", colors.white },
	{ "@text.title", colors.palette.grey[3], bold = true },
	{ "@text.underline", colors.palette.grey[3] },
	{ "@text.uri", colors.palette.grey[3] },
	{ "@type", colors.palette.grey[3] },
	{ "@identifier", colors.palette.grey[1] },
	{ "@type.builtin", colors.palette.grey[7] },
	{ "@type.definition", colors.palette.grey[3] },
	{ "@variable", colors.white },
	{ "@attribute", colors.palette.grey[4] },
	{ "@variable.builtin", colors.palette.grey[2] },

	{ "@punctuation.special", colors.palette.grey[8] }, -- incl. separator on border hover
	{ "@punctuation.bracket", colors.palette.grey[7] },

	{ "Identifier", colors.palette.grey[1] },
	{ "@type.qualifier", colors.palette.navy[1] }, -- rust `mut`
	{ "@include", colors.palette.cyan[1] },
	{ "@punctuation.delimiter", colors.palette.grey[5] },
	{ "@tag", colors.white },
	{ "@type.builtin", colors.palette.grey[5] },

	{ "@number", colors.misc.number },
	{ "@float", colors.misc.number },

	{ "@conditional", colors.palette.cyan[1] },
	{ "@text.strong", bold = true },
	{ "@text.emphasis", italic = true },
	{ "LspSignatureActiveParameter", colors.palette.cyan[1] },

	-- Consts
	{ "@constant", syn_hl.const },
	{ "@constant.builtin", syn_hl.const },
	{ "@boolean", colors.misc.bool },
	{ "Constant", colors.misc.bool },

	{ "Comment", colors.palette.grey[8] },
	{ "Character", colors.palette.grey[6] },
	{ "Identifier", colors.palette.grey[1] },
	{ "Statement", colors.palette.grey[2] },
	{ "PreProc", colors.primary },
	{ "Type", colors.white },
	{ "Special", colors.palette.grey[5] },
	{ "Error", colors.primary },
	{ "Function", colors.palette.grey[1] },
}

config = vim.tbl_deep_extend("force", config, md_config)

return config
