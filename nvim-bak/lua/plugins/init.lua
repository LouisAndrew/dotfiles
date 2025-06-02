local icons = require("theme.icons")
return {
	"yamatsum/nvim-nonicons",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
	},
	priority = 999,
	config = function()
		local devicons = require("nvim-web-devicons")
		devicons.setup({
			color_icons = false,
		})
		require("nvim-nonicons").setup({})
		devicons.set_icon_by_filetype({
			js = "Js",
			ts = "Ts",
		})

		local icon_overrides = {}
		local test_extensions = { "spec", "test" }
		for _, file_extension in ipairs({ "ts", "tsx", "js", "jsx" }) do
			for _, test_extension in ipairs(test_extensions) do
				icon_overrides[test_extension .. "." .. file_extension] = {
					icon = icons.Test,
				}
			end
		end

		devicons.set_icon(icon_overrides)
	end,
}
