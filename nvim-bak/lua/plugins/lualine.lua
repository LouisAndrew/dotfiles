local icons = require("theme.icons")
local colors = require("minimal_fedu")

return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	opts = function()
		return {
			options = {
				section_separators = "",
				component_separators = "",
				theme = {
					normal = {
						c = { bg = colors.background, fg = colors.palette.grey[5] },
						x = { bg = colors.background },
					},
					inactive = { c = { bg = colors.background }, x = { bg = colors.background } },
				},
			},
			sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					{
						function()
							local root = vim.fn.getcwd()
							return string.gsub(root, "^.*/(.*)$", "%1")
						end,
						padding = { left = 1 },
						color = {
							fg = colors.white,
						},
					},
					{
						"branch",
						icon = "",
						padding = { right = 0, left = 0 },
					},
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = {
							error = icons.Error,
							warn = icons.Warn,
							info = icons.Info,
							hint = icons.Hint,
						},
						padding = { left = 1, right = 1 },
					},
					{
						function()
							---@diagnostic disable-next-line: undefined-field
							local mode = require("noice").api.status.mode.get()
							if mode:find("^recording") then
								return mode
							end

							return ""
						end,
						---@diagnostic disable-next-line: undefined-field
						cond = require("noice").api.status.mode.has,
						color = { fg = colors.palette.grey[7] },
					},
				},
				lualine_x = {
					{
						"buffers",
						filetype_names = {
							TelescopePrompt = "",
						},
						buffers_color = {
							active = {
								fg = colors.white,
							},
							inactive = {
								fg = colors.palette.grey[5],
							},
						},

						symbols = {
							modified = " " .. icons.Modified,
							alternate_file = "",
							directory = "",
						},
					},
				},
				lualine_y = {},
				lualine_z = {},
			},
		}
	end,
}
