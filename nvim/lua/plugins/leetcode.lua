local utils = require("utils")

return {
	"kawre/leetcode.nvim",
	lazy = utils.CONST.leet_arg ~= vim.fn.argv(0, -1),
	---@module 'leetcode'
	---@type lc.LeetCode
	opts = {
		arg = utils.CONST.leet_arg,
		lang = "typescript",
	},
}
