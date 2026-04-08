local lush = require("lush")
local H = require("theme.lush")
local colors = require("minimal_fedu")

---@diagnostic disable: undefined-global
return lush(function()
	return {
		SnacksInputNormal({ fg = H.hex(colors.white), bg = H.hex(colors.bg_shade) }),
		SnacksInputTitle({ fg = H.hex(colors.palette.grey[5]) }),

		SnacksPicker({ bg = H.hex(colors.background) }),
		SnacksPickerBorder({ fg = H.hex(colors.background) }),
		SnacksPickerDir({ fg = H.hex(colors.palette.grey[7]) }),
		SnacksPickerFile({ fg = H.hex(colors.palette.grey[4]) }),
		SnacksPickerMatch({ fg = H.hex(colors.white) }),
		SnacksPickerRow({ fg = H.hex(colors.palette.grey[5]) }),
		SnacksPickerCol({ fg = H.hex(colors.palette.grey[5]) }),

		SnacksStatusColumnMark({ fg = H.hex(colors.palette.grey[7]) }),
	}
end)
