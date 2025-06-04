return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"antoinemadec/FixCursorHold.nvim",
		"marilari88/neotest-vitest",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-vitest"),
			},
			status = {
				signs = false,
				virtual_text = true,
			},
			icons = {
				final_child_prefix = "└",
				expanded = "┐",
			},
		})
	end,
	keys = {
		{
			"<leader>tr",
			function()
				require("neotest").run.run()
			end,
			desc = "Run nearest test",
		},
		{
			"<leader>tR",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Run File (Neotest)",
		},
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Toggle Summary (Neotest)",
		},
	},
}
