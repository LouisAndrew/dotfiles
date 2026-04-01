local lush = require("lush")
local H = require("theme.lush")
local colors = require("minimal_fedu")

---@diagnostic disable: undefined-global
return lush(function()
	return {
		MiniHiPatternsTodo({ fg = H.hex(colors.misc.remove_fg) }),
		MiniHiPatternsMdDate({ fg = H.hex(colors.palette.magenta[2]) }),
		MiniHiPatternsMdDone({ fg = H.hex(colors.misc.add_fg) }),
		MiniHiPatternsMDStuff({ fg = H.hex(colors.palette.blue[2]) }),

		UfoFoldVirtualText({ fg = H.hex(colors.palette.grey[8]) }),
		UfoFoldPeekNormal({ bg = H.hex(colors.bg_shade) }),

		FlashMatch({ fg = H.hex(colors.palette.grey[5]) }),
		FlashCurrent({ fg = H.hex(colors.palette.grey[6]) }),
		FlashLabel({ fg = H.hex(colors.palette.indigo[2]), bg = H.hex(colors.palette.indigo[4]) }),

		BqfPreviewFloat({ bg = H.hex(colors.background) }),
		QuickFixLine({ fg = H.hex(colors.palette.grey[1]) }),
		Delimiter({ fg = H.hex(colors.bg_shade) }),

		TelescopeBorder({ fg = H.hex(colors.bg_accent), bg = H.hex(colors.background) }),
	}
end)
