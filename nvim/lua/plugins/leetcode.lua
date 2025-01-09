local leet_arg = "lc"

return {
	"kawre/leetcode.nvim",
	lazy = leet_arg ~= vim.fn.argv(0, -1),
	opts = {
		arg = leet_arg,
		hooks = {
			["enter"] = {
				function()
					print("enter")
				end,
			},
			["question_enter"] = {
				function()
					print("")
				end,
			},
		},
	},
}
