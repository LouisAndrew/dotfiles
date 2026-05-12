return {
	{
		"rktjmp/lush.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("mfgh")
		end,
	},
	{
		"kvrohit/rasmus.nvim",
		priority = 1000,
	},
}

-- in case you need a "higher contrast" uncomment below
-- return {
-- 	{ "datsfilipe/vesper.nvim", priority = 1000, lazy = false },
-- }
