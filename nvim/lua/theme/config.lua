local minimal_fedu = require("minimal_fedu")
local M = {}

M.winconfig = {
	winblend = 0,
	border = "single",
}

M.hl = {
	border = {
		minimal_fedu.bg_accent,
		minimal_fedu.background,
	},
	normal = {
		nil,
		minimal_fedu.background,
	},
}

return M
