local lush = require("lush")
local H = require("theme.lush")
local colors = require("minimal_fedu")

---@diagnostic disable: undefined-global
return lush(function()
	return {
		NoiceCmdlinePrompt({ fg = H.hex(colors.white) }),
		NoiceCmdlinePopup({ bg = H.hex(colors.bg_shade) }),
		NoiceCmdlinePopupBorder({ fg = H.hex(colors.debug), bg = H.hex(colors.background) }),
		NoiceCmdlineIcon({ fg = H.hex(colors.palette.grey[4]), gui = "bold" }),
		NoiceCmdlineIconSearch({ fg = H.hex(colors.palette.grey[3]), gui = "bold" }),
		NoiceCmdlinePopupTitle({ fg = H.hex(colors.palette.grey[5]) }),
		NoiceCursor({ fg = H.hex(colors.palette.grey[3]), bg = H.hex(colors.palette.grey[10]) }),
		NoiceVirtualText({ fg = H.hex(colors.palette.grey[8]) }),
		NoicePopup({ bg = H.hex(colors.background) }),
		NoiceCmdlineSearch({ fg = H.hex(colors.palette.grey[3]), bg = H.hex(colors.background) }),
		NoiceCmdlineSearchBorder({ fg = H.hex(colors.background), bg = H.hex(colors.yellow_fg) }),
		NoiceCmdline({ fg = H.hex(colors.white), bg = H.hex(colors.background) }),
		NoiceCmdlineScript({ fg = H.hex(colors.white) }),
		NoiceCmdlineScriptBorder({ fg = H.hex(colors.debug), bg = H.hex(colors.background) }),
		NoiceInputNormal({ fg = H.hex(colors.white), bg = H.hex(colors.bg_shade) }),
		NoiceConfirmBorder({ fg = H.hex(colors.bg_accent), bg = H.hex(colors.background) }),
	}
end)
