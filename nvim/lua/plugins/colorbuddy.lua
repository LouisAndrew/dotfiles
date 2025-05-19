return {
	"tjdevries/colorbuddy.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("colorbuddy").setup()
		require("theme").setup()
	end,
}

-- in case you need a "higher contrast" uncomment below
-- return {
-- 	{ "datsfilipe/vesper.nvim", priority = 1000, lazy = false },
-- }
