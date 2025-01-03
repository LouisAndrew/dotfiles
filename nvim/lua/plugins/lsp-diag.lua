return {
	{
		"folke/trouble.nvim",
		lazy = true,
		keys = { { "<leader>id", "<cmd>:TroubleToggle<cr>" } },
		---@module 'trouble'
		---@type trouble.Config
		opts = {
			auto_preview = false,
		},
	},
}
