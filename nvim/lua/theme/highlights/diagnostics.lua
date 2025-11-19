local colors = require("minimal_fedu")

local M = {
	prefix = "Diagnostic",
	{ "Source", colors.primary },
	{ "Pos", colors.mfed_7 },
	{ "Word", colors.secondary },
	{ "VirtualTextError", colors.diagnostic.error, colors.misc.remove },
}

local prefixes = {
	"",
	"Floating",
	"Underline",
}

local levels = {}

local utils = require("utils")
for name, hl in pairs(colors.diagnostic) do
	levels[utils.capitalize(name)] = hl
end

for _, p in ipairs(prefixes) do
	for name, hl in pairs(levels) do
		local cfg = { p .. name, hl }
		if p == "Underline" then
			cfg.underline = true
			cfg.sp = hl
			cfg[2] = nil
		end

		table.insert(M, cfg)
	end
end

return M
