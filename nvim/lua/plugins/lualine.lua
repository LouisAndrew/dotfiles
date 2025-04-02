return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local minimal_fedu = require("minimal_fedu")
		local lualine = require("lualine")
		local icons = require("theme.icons")
		local search_count = require("search").search_count
		local utils = require("utils")

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

		local function ins_winbar_left(component, inactive_color)
			table.insert(config.winbar.lualine_c, component)

			local inactive_component = vim.deepcopy(component)
			inactive_component.color = inactive_color
			table.insert(config.inactive_winbar.lualine_c, inactive_component)
		end

		local function ins_winbar_right(component, inactive_color)
			table.insert(config.winbar.lualine_x, component)

			local inactive_component = vim.deepcopy(component)
			inactive_component.color = inactive_color
			table.insert(config.inactive_winbar.lualine_x, inactive_component)
		end

		ins_winbar_left({
			"navic",
			fmt = function(text)
				if vim.g.DISPLAY_NAVIC == utils.CONST.falsy then
					return ""
				end

				return string.gsub(text, "%%%*$", "")
			end,
		})

		ins_winbar_right({
			"filename",
			file_status = true, -- Displays file status (readonly status, modified status)
			newfile_status = true, -- Display new file status (new file means no write after created)
			path = 4, -- 0: Just the filename
			color = { fg = minimal_fedu.noir_2 },
			shorting_target = 60,
			symbols = {
				modified = icons.Modified,
				readonly = "",
				unnamed = "",
				newfile = "[New]",
			},
			padding = { left = -1 },
		}, { fg = minimal_fedu.noir_6 })

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
			-- mode component
			function()
				local mode = vim.fn.mode()
				local mode_info = {
					n = "normal",
					i = "insert",
					c = "command",
					v = "visual",
					[""] = "visual",
				}
				return mode_info[mode] or mode
			end,
			padding = { right = 0, left = 1 },
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
				local mode = require("noice").api.status.mode.get()
				if mode:find("^recording") then
					return mode
				end

				return ""
			end,
			cond = require("noice").api.status.mode.has,
			-- color = { fg = minimal_fedu.dimmed_white },
			padding = { left = 2 },
		})

		ins_right({
			search_count,
			padding = { right = 1 },
			color = { fg = minimal_fedu.palette.yellow_fg },
		})

		ins_right({ "location", color = { fg = minimal_fedu.dimmed_white } })

		ins_right({
			"buffers",
			show_filename_only = true, -- Shows shortened relative path when set to false.
			hide_filename_extension = false, -- Hide filename extension when set to true.
			show_modified_status = true, -- Shows indicator when the buffer is modified.

			mode = 0,

			max_length = vim.o.columns * 3 / 5, -- Maximum width of buffers component,
			-- it can also be a function that returns
			-- the value of `max_length` dynamically.
			filetype_names = {
				TelescopePrompt = "",
			},
			use_mode_colors = false,
			buffers_color = {
				-- Same values as the general color option can be used here.
				active = {
					fg = minimal_fedu.white,
				}, -- Color for active buffer.
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

		ins_right({
			function()
				local msg = "| no lsp"
				local buf_ft = vim.api.nvim_get_option_value("filetype", {
					buf = 0,
				})
				local clients = vim.lsp.get_clients()

				if next(clients) == nil then
					return msg
				end

				---
				---@class Client
				---@field name string
				---@field count number
				local client_map = {}

				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						local n = client.name
						if n == "emmet_language_server" then
							n = "emmet"
						elseif n == "typescript-tools" then
							n = "tss"
						end

						local entry = client_map[n]
						if entry then
							entry.count = entry.count + 1
						else
							client_map[n] = { name = n, count = 1 }
						end
					end
				end

				local client_names = {}
				local display_count = true
				for _, client in pairs(client_map) do
					local count = (client.count == 1 or display_count == false) and "" or " (" .. client.count .. ")"
					table.insert(client_names, client.name .. count)
				end

				if #client_names == 0 then
					return msg
				end

				if #client_names == 1 or vim.g.EXPAND_LSP == "true" then
					return "| " .. table.concat(client_names, ", ")
				elseif #client_names > 0 then
					return "| " .. #client_names .. " LSPs"
				end
			end,
			padding = {
				left = -1,
			},
		})

		lualine.setup(config)
	end,
}
