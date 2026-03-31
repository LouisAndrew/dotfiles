local utils = require("utils")
local enable_copilot = utils.CONST.leet_arg ~= vim.fn.argv(0, -1)

return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = enable_copilot and "InsertEnter" or {},
		desc = "Completion / suggestion",
		dependencies = {
			"copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
		},
		opts = {
			suggestion = {
				keymap = {
					accept = "<C-l>",
					next = "<C-j>",
				},
			},
		},
	},
}
