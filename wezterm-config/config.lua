local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

local modules = {
	"font",
	"colors",
	"window",
	"actions",
	"keymaps",
	"tab",
}

for _, module in ipairs(modules) do
	require(module)(wezterm, config)
end

return config
