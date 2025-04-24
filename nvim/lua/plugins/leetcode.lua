local utils = require("utils")

return {
	"kawre/leetcode.nvim",
	dependencies = {
		{
			"epwalsh/pomo.nvim",
			version = "*", -- Recommended, use latest release instead of latest commit
			lazy = true,
			cmd = { "TimerStart", "TimerRepeat", "TimerSession" },
			opts = {
				notifiers = {},
			},
		},
	},
	lazy = utils.CONST.leet_arg ~= vim.fn.argv(0, -1),
	---@module 'leetcode'
	---@type lc.LeetCode
	opts = {
		arg = utils.CONST.leet_arg,
		lang = "typescript",
		hooks = {
			["question_enter"] = {
				function()
					vim.cmd(":TimerStart 20m")
				end,
			},
		},
	},
}
