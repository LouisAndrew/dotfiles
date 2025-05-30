local colors = require("minimal_fedu")

local ufo = {
	prefix = "UfoFold",
	{ "VirtualText", "Comment", link = true },
	{ "PeekNormal", nil, colors.bg_shade },
}

local flash = {
	prefix = "Flash",
	{ "Match", colors.palette.grey[5] },
	{ "Current", colors.palette.grey[6] },
	{ "Label", colors.palette.indigo[2], colors.palette.indigo[4] },
}

local M = {}

for _, cfg in pairs({ flash, ufo }) do
	for _, n in ipairs(cfg) do
		n[1] = cfg.prefix .. n[1]
		M[#M + 1] = n
	end
end

return M
