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
	float = {
		nil,
		minimal_fedu.background,
	},
}

M.mergeHlConfig = function(configlist)
	local P = {}

	for _, cfg in pairs(configlist) do
		local p = cfg.prefix or ""
		for _, n in ipairs(cfg) do
			n[1] = p .. n[1]
			P[#P + 1] = n
		end
	end

	return P
end

return M
