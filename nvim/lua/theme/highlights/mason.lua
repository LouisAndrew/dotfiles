local lush = require("lush")
local H = require("theme.lush")
local colors = require("minimal_fedu")

---@diagnostic disable: undefined-global
return lush(function()
	return {
		MasonHeader({ fg = H.hex(colors.white), bg = H.hex(colors.palette.grey[10]) }),
		MasonHeaderSecondary({ fg = H.hex(colors.white) }),
		MasonHighlight({ fg = H.hex(colors.primary) }),
		MasonHighlightBlock({ fg = H.hex(colors.primary) }),
		MasonHighlightBlockBold({ fg = H.hex(colors.white), bg = H.hex(colors.palette.grey[10]) }),
		MasonHighlightSecondary({ fg = H.hex(colors.primary) }),
		MasonHighlightBlockSecondary({ fg = H.hex(colors.primary) }),
		MasonHighlightBlockBoldSecondary({ fg = H.hex(colors.white), bg = H.hex(colors.palette.grey[10]) }),
		MasonMuted({ fg = H.hex(colors.palette.grey[6]) }),
		MasonMutedBlock({ fg = H.hex(colors.palette.grey[6]) }),
		MasonMutedBlockBold({ fg = H.hex(colors.palette.grey[6]) }),
		MasonError({ fg = H.hex(colors.misc.remove_fg) }),
	}
end)
