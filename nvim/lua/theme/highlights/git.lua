local colors = require("minimal_fedu")

return {
	{ "Added", colors.misc.add_fg },
	{ "Removed", colors.misc.remove_fg },
	{ "Changed", colors.misc.change_fg },
	{ "DiffAdd", nil, colors.misc.add },
	{ "DiffDelete", nil, colors.misc.remove },
	{ "DiffChange", nil, colors.misc.change },
	{ "DiffText", nil, colors.misc.change },
}
