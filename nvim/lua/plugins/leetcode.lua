local utils = require("utils")
local colors = require("minimal_fedu")

return {
	"kawre/leetcode.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	lazy = utils.CONST.leet_arg ~= vim.fn.argv(0, -1),
	config = function()
		print("LC")
		require("leetcode").setup({
			arg = utils.CONST.leet_arg,
			lang = "typescript",
			hooks = {
				["question_enter"] = {
					function()
						vim.api.nvim_set_hl(0, "leetcode_dyn_p", {
							foreground = colors.palette.grey[5],
						})

						vim.api.nvim_set_hl(0, "leetcode_alt", {
							foreground = colors.palette.grey[5],
						})

						vim.api.nvim_set_keymap("n", "<leader>ns", "<cmd>:Leet submit<cr>", {})
						vim.api.nvim_set_keymap("n", "<leader>nr", "<cmd>:Leet run<cr>", {})
						vim.api.nvim_set_keymap("n", "<leader>nc", "<cmd>:Leet console<cr>", {})
					end,
				},
			},
		})
	end,
}
