local lush = require("lush")
local H = require("theme.lush")
local colors = require("minimal_fedu")

---@diagnostic disable: undefined-global
return lush(function()
	return {
		NeotestFailed({ fg = H.hex(colors.misc.remove_fg) }),
		NeotestPassed({ fg = H.hex(colors.misc.add_fg) }),
		NeotestRunning({ fg = H.hex(colors.misc.change_fg) }),
		NeotestSkipped({ fg = H.hex(colors.palette.grey[8]) }),
		NeotestAdapterName({ fg = H.hex(colors.white) }),
		NeotestDir({ fg = H.hex(colors.palette.grey[7]) }),
		NeotestFile({ fg = H.hex(colors.palette.grey[5]) }),
		NeotestNamespace({ fg = H.hex(colors.white) }),
		NeotestFocused({ NeotestAdapterName }),
		NeotestExpandMarker({ fg = H.hex(colors.palette.grey[7]) }),
	}
end)
