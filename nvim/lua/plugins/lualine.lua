return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local minimal_fedu = require("minimal_fedu")
		local lualine = require("lualine")
		local icons = require("theme.icons")
		local search_count = require("search").search_count

		local config = {
			options = {
				section_separators = "",
				component_separators = "",
				theme = {
					normal = { c = { bg = minimal_fedu.background } },
					inactive = { c = { bg = minimal_fedu.background } },
				},
			},
			disabled_filetypes = {
				statusline = {
					"packer",
					"NvimTree",
					"NeoGit",
				},
				winbar = {
					"packer",
					"NvimTree",
					"NeoGit",
				},
			},
			sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				-- These will be filled later
				lualine_c = {},
				lualine_x = {},
			},
			inactive_sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
			winbar = {
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
			inactive_winbar = {
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
		}

		-- Inserts a component in lualine_c at left section
		local function ins_left(component)
			table.insert(config.sections.lualine_c, component)
		end

		-- Inserts a component in lualine_x at right section
		local function ins_right(component)
			table.insert(config.sections.lualine_x, component)
		end

		ins_left({
			function()
				local root = vim.fn.getcwd()
				return string.gsub(root, "^.*/(.*)$", "%1")
			end,
			padding = { left = 1, right = 0 },
			color = {
				fg = minimal_fedu.white,
			},
		})

		ins_left({
			"branch",
			icon = "",
			color = {
				fg = minimal_fedu.dimmed_white,
			},
			padding = { right = 0, left = 0 },
		})

		ins_left({
			"diagnostics",
			sources = { "nvim_diagnostic" },
			symbols = {
				error = icons.Error,
				warn = icons.Warn,
				info = icons.Info,
				hint = icons.Hint,
			},
			padding = { left = 1, right = 1 },
		})

		ins_left({
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
			color = { fg = minimal_fedu.palette.grey[7] },
			padding = { left = 2 },
		})

		ins_left({
			function()
				local ok, pomo = pcall(require, "pomo")
				if not ok then
					return ""
				end

				local timer = pomo.get_first_to_finish()
				if timer == nil then
					return ""
				end

				return " " .. tostring(timer)
			end,
			padding = { left = 1 },
			color = { fg = minimal_fedu.palette.grey[5] },
		})

		ins_right({
			search_count,
			padding = { right = 1 },
			color = { fg = minimal_fedu.palette.indigo[3] },
		})

		ins_right({
			"buffers",
			filetype_names = {
				TelescopePrompt = "",
			},
			buffers_color = {
				active = {
					fg = minimal_fedu.white,
				},
				inactive = {
					fg = minimal_fedu.dimmed_white,
				}, -- Color for inactive buffer.
			},

			symbols = {
				modified = " " .. icons.Modified, -- Text to show when the buffer is modified
				alternate_file = "", -- Text to show to identify the alternate file
				directory = "", -- Text to show when the buffer is a directory
			},
		})

		lualine.setup(config)
	end,
}
