local lush = require("lush")
local H = require("theme.lush")
local colors = require("minimal_fedu")

local syn_hl = {
	keyword = colors.palette.navy[1],
	return_keyword = colors.palette.cyan[1],
	fn = colors.palette.grey[3],
	fn_call = colors.palette.grey[6],
	property = colors.palette.grey[4],
	const = colors.palette.grey[6],
}

---@diagnostic disable: undefined-global
return lush(function(injected)
	local sym = injected.sym

	return {
		sym("@spell.markdown")({ fg = H.hex(colors.palette.grey[3]) }),
		sym("@markup")({ fg = H.hex(colors.palette.grey[5]) }),
		sym("@markup.link")({ fg = H.hex(colors.palette.grey[1]) }),
		sym("@markup.heading")({ fg = H.hex(colors.white), gui = "bold" }),
		sym("@markup.italic")({ gui = "italic" }),
		sym("@markup.list")({ fg = H.hex(colors.palette.grey[3]) }),
		sym("@markup.raw")({ fg = H.hex(colors.palette.yellow[2]) }),

		sym("@character")({ fg = H.hex(colors.white) }),
		sym("@character.special")({ fg = H.hex(colors.palette.grey[3]) }),
		sym("@conditional")({ fg = H.hex(colors.palette.cyan[1]) }),
		sym("@constructor")({ fg = H.hex(colors.palette.grey[2]) }),
		sym("@debug")({ fg = H.hex(colors.palette.grey[3]) }),
		sym("@define")({ fg = H.hex(colors.palette.grey[3]) }),
		sym("@exception")({ fg = H.hex(colors.cyan) }),
		sym("@field")({ fg = H.hex(colors.palette.grey[3]) }),

		sym("@keyword")({ fg = H.hex(syn_hl.keyword) }),
		sym("@include")({ fg = H.hex(colors.palette.cyan[1]) }),
		sym("@keyword.function")({ fg = H.hex(syn_hl.keyword) }),
		sym("@keyword.operator")({ fg = H.hex(colors.palette.grey[7]) }),
		sym("@keyword.conditional.ternary")({ fg = H.hex(colors.palette.grey[7]) }),
		sym("@keyword.return")({ fg = H.hex(syn_hl.return_keyword) }),

		sym("@lsp.type.macro")({ fg = H.hex(syn_hl.return_keyword) }),
		sym("@function.macro")({ fg = H.hex(syn_hl.return_keyword) }),
		sym("@macro")({ fg = H.hex(syn_hl.return_keyword) }),
		sym("@constant.macro")({ fg = H.hex(syn_hl.return_keyword) }),

		sym("@label")({ fg = H.hex(colors.palette.grey[3]) }),

		sym("@method")({ fg = H.hex(syn_hl.fn) }),
		sym("@lsp.mod.declaration")({ fg = H.hex(syn_hl.fn) }),
		sym("@lsp.type.function")({ fg = H.hex(syn_hl.fn) }),
		sym("@function")({ fg = H.hex(syn_hl.fn) }),
		sym("@function.builtin")({ fg = H.hex(syn_hl.fn) }),

		sym("@function.call")({ fg = H.hex(syn_hl.fn_call) }),
		sym("@method.call")({ fg = H.hex(syn_hl.fn_call) }),
		sym("@lsp.type.method")({ fg = H.hex(syn_hl.fn_call) }),
		sym("@function.method.call")({ fg = H.hex(syn_hl.fn_call) }),

		sym("@namespace")({ fg = H.hex(colors.palette.grey[3]) }),
		sym("@none")({ fg = H.hex(colors.palette.grey[4]) }),
		sym("@operator")({ fg = H.hex(colors.palette.grey[7]) }),
		sym("@parameter")({ fg = H.hex(colors.palette.grey[3]) }),
		sym("@preproc")({ fg = H.hex(colors.palette.grey[3]) }),
		sym("@property")({ fg = H.hex(syn_hl.property) }),
		sym("@punctuation")({ fg = H.hex(colors.palette.grey[3]) }),
		sym("@punctuation.delimiter")({ fg = H.hex(colors.palette.grey[5]) }),
		sym("@repeat")({ fg = H.hex(colors.navy) }),
		sym("@storageclass")({ fg = H.hex(colors.palette.grey[3]) }),
		sym("@string")({ fg = H.hex(colors.primary) }),
		sym("@string.escape")({ fg = H.hex(colors.palette.grey[3]) }),
		sym("@string.special")({ fg = H.hex(colors.palette.grey[3]) }),
		sym("@structure")({ fg = H.hex(colors.palette.grey[3]) }),
		sym("@tag")({ fg = H.hex(colors.white) }),
		sym("@tag.attribute")({ fg = H.hex(colors.palette.grey[6]) }),
		sym("@tag.delimiter")({ fg = H.hex(colors.palette.grey[4]) }),
		sym("@text.literal")({ fg = H.hex(colors.palette.grey[2]) }),
		sym("@text.reference")({ fg = H.hex(colors.white) }),
		sym("@text.title")({ fg = H.hex(colors.palette.grey[3]), gui = "bold" }),
		sym("@text.underline")({ fg = H.hex(colors.palette.grey[3]) }),
		sym("@text.uri")({ fg = H.hex(colors.palette.grey[3]) }),
		sym("@type")({ fg = H.hex(colors.palette.grey[3]) }),
		sym("@identifier")({ fg = H.hex(colors.palette.grey[1]) }),
		sym("@type.builtin")({ fg = H.hex(colors.palette.grey[5]) }),
		sym("@type.definition")({ fg = H.hex(colors.palette.grey[3]) }),
		sym("@variable")({ fg = H.hex(colors.white) }),
		sym("@attribute")({ fg = H.hex(colors.palette.grey[4]) }),
		sym("@variable.builtin")({ fg = H.hex(colors.palette.grey[2]) }),
		sym("@punctuation.special")({ fg = H.hex(colors.palette.grey[8]) }),
		sym("@punctuation.bracket")({ fg = H.hex(colors.palette.grey[7]) }),
		sym("@type.qualifier")({ fg = H.hex(colors.palette.navy[1]) }),

		-- JSON
		sym("@property.json")({ fg = H.hex(colors.palette.grey[4]) }),
		sym("@string.json")({ fg = H.hex(colors.primary) }),
		sym("@string.special.key.json")({ fg = H.hex(colors.palette.grey[4]) }),
		sym("@number.json")({ fg = H.hex(colors.misc.number) }),
		sym("@boolean.json")({ fg = H.hex(colors.misc.bool) }),
		sym("@punctuation.bracket.json")({ fg = H.hex(colors.palette.grey[5]) }),
		sym("@punctuation.delimiter.json")({ fg = H.hex(colors.palette.grey[6]) }),

		sym("@number")({ fg = H.hex(colors.misc.number) }),
		sym("@float")({ fg = H.hex(colors.misc.number) }),
		sym("@text.strong")({ gui = "bold" }),
		sym("@text.emphasis")({ gui = "italic" }),
		LspSignatureActiveParameter({ fg = H.hex(colors.palette.cyan[1]) }),
		sym("@constant")({ fg = H.hex(syn_hl.const) }),
		sym("@constant.builtin")({ fg = H.hex(syn_hl.const) }),
		sym("@boolean")({ fg = H.hex(colors.misc.bool) }),
		Constant({ fg = H.hex(colors.misc.bool) }),
		Comment({ fg = H.hex(colors.palette.grey[8]) }),
		Character({ fg = H.hex(colors.palette.grey[6]) }),
		Identifier({ fg = H.hex(colors.palette.grey[1]) }),
		Statement({ fg = H.hex(colors.palette.grey[2]) }),
		PreProc({ fg = H.hex(colors.primary) }),
		Type({ fg = H.hex(colors.white) }),
		Special({ fg = H.hex(colors.palette.grey[5]) }),
		Error({ fg = H.hex(colors.primary) }),
		Function({ fg = H.hex(colors.palette.grey[1]) }),
	}
end)
