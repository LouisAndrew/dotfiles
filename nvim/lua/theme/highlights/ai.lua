local lush = require("lush")
local H = require("theme.lush")
local colors = require("minimal_fedu")

---@diagnostic disable: undefined-global
return lush(function()
	return {
		AvanteSidebarNormal({ bg = H.hex(colors.background) }),
		AvanteSidebarWinHorizontalSeparator({ bg = H.hex(colors.background) }),
		AvanteSidebarWinSeparator({ fg = H.hex(colors.bg_accent), bg = H.hex(colors.background) }),
		AvanteInlineHint({ fg = H.hex(colors.palette.grey[8]) }),
		AvanteTitle({ fg = H.hex(colors.palette.grey[5]), bg = H.hex(colors.background) }),
		AvanteReversedTitle({ fg = H.hex(colors.background), bg = H.hex(colors.background) }),
		AvanteSubTitle({ AvanteTitle }),
		AvanteReversedSubtitle({ AvanteReversedTitle }),
		AvanteThirdTitle({ AvanteTitle }),
		AvanteReversedThirdTitle({ AvanteReversedTitle }),
	}
end)
