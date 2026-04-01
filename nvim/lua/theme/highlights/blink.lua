local lush = require("lush")
local H = require("theme.lush")
local colors = require("minimal_fedu")

---@diagnostic disable: undefined-global
return lush(function()
	return {
		BlinkCmpMenu({ bg = H.hex(colors.background) }),
		BlinkCmpMenuBorder({ fg = H.hex(colors.bg_accent), bg = H.hex(colors.background) }),
		BlinkCmpDoc({ bg = H.hex(colors.background) }),
		BlinkCmpDocBorder({ fg = H.hex(colors.bg_accent), bg = H.hex(colors.background) }),
		BlinkCmpDocSeparator({ fg = H.hex(colors.palette.grey[9]) }),

		BlinkCmpKindFile({ fg = H.hex(colors.palette.grey[3]) }),
		BlinkCmpKindModule({ fg = H.hex(colors.palette.grey[3]) }),
		BlinkCmpKindNamespace({ fg = H.hex(colors.palette.grey[3]) }),
		BlinkCmpKindPackage({ fg = H.hex(colors.palette.grey[3]) }),
		BlinkCmpKindClass({ fg = H.hex(colors.palette.red[2]) }),
		BlinkCmpKindMethod({ fg = H.hex(colors.misc.bool) }),
		BlinkCmpKindProperty({ fg = H.hex(colors.palette.cyan[1]) }),
		BlinkCmpKindField({ fg = H.hex(colors.palette.cyan[1]) }),
		BlinkCmpKindConstructor({ fg = H.hex(colors.palette.grey[3]) }),
		BlinkCmpKindEnum({ fg = H.hex(colors.palette.green[2]) }),
		BlinkCmpKindInterface({ fg = H.hex(colors.palette.navy[1]) }),
		BlinkCmpKindFunction({ fg = H.hex(colors.misc.bool) }),
		BlinkCmpKindVariable({ fg = H.hex(colors.palette.navy[1]) }),
		BlinkCmpKindConstant({ fg = H.hex(colors.palette.grey[3]) }),
		BlinkCmpKindString({ fg = H.hex(colors.palette.green[2]) }),
		BlinkCmpKindNumber({ fg = H.hex(colors.palette.grey[3]) }),
		BlinkCmpKindBoolean({ fg = H.hex(colors.palette.grey[3]) }),
		BlinkCmpKindArray({ fg = H.hex(colors.palette.grey[3]) }),
		BlinkCmpKindObject({ fg = H.hex(colors.palette.grey[3]) }),
		BlinkCmpKindKey({ fg = H.hex(colors.palette.green[2]) }),
		BlinkCmpKindNull({ fg = H.hex(colors.palette.grey[3]) }),
		BlinkCmpKindEnumMember({ fg = H.hex(colors.palette.grey[3]) }),
		BlinkCmpKindStruct({ fg = H.hex(colors.palette.grey[3]) }),
		BlinkCmpKindEvent({ fg = H.hex(colors.palette.grey[3]) }),
		BlinkCmpKindOperator({ fg = H.hex(colors.palette.grey[3]) }),
		BlinkCmpKindTypeParameter({ fg = H.hex(colors.palette.grey[3]) }),
		BlinkCmpKindUnit({ fg = H.hex(colors.palette.cyan[1]) }),
		BlinkCmpKindText({ fg = H.hex(colors.palette.grey[3]) }),
		BlinkCmpKindSnippet({ fg = H.hex(colors.palette.grey[3]) }),
		BlinkCmpKindKeyword({ fg = H.hex(colors.palette.grey[3]) }),
	}
end)
