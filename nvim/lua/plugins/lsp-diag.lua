return {
	{
		"folke/trouble.nvim",
		lazy = true,
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Toggle trouble tab" },
		},
		---@module 'trouble'
		---@type trouble.Config
		opts = {
			auto_preview = false,
		},
	},
}
