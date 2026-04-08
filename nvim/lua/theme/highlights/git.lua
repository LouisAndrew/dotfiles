local lush = require("lush")
local H = require("theme.lush")
local colors = require("minimal_fedu")

---@diagnostic disable: undefined-global
return lush(function()
	return {
		DiffviewFolderSign({ fg = H.hex(colors.palette.grey[6]) }),
		Added({ fg = H.hex(colors.misc.add_fg) }),
		Removed({ fg = H.hex(colors.misc.remove_fg) }),
		Changed({ fg = H.hex(colors.misc.change_fg) }),
		DiffAdd({ bg = H.hex(colors.misc.add) }),
		DiffDelete({ bg = H.hex(colors.misc.remove) }),
		DiffChange({ bg = H.hex(colors.misc.change) }),
		DiffText({ bg = H.hex(colors.misc.change) }),
		diffAdded({ Added }),
		DiffRemoved({ Removed }),
		DiffChanged({ Changed }),
	}
end)
