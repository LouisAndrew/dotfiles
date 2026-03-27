return {
	"codethread/qmk.nvim",
	keys = {
		{ "<leader>22", ":QMKFormat" },
	},
	config = function()
		local conf = {
			name = "LAYOUT",
			layout = {
				"x x x x x x _ _ _ x x x x x x",
				"x x x x x x _ _ _ x x x x x x",
				"x x x x x x _ _ _ x x x x x x",
				"x x x x x x x _ x x x x x x x",
				"_ _ _ _ x x x _ x x x _ _ _ _",
			},
		}
		require("qmk").setup(conf)
	end,
}
