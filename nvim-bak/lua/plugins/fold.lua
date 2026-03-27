local utils = require("utils")

local ft_fold_provider = {
	tsplayground = { "indent" },
	vue = { "treesitter", "indent" },
}

return {
	"kevinhwang91/nvim-ufo",
	event = "BufEnter",
	dependencies = {
		"kevinhwang91/promise-async",
	},
	config = function()
		local ufo = require("ufo")
		ufo.setup({
			open_fold_hl_timeout = 150,
			close_fold_kinds_for_ft = {
				default = { "imports", "comment" },
				json = { "array" },
				vue = { "import_statement" },
				go = { "import_declaration" },
				typescript = { "imports", "comment" },
				tsplayground = {},
			},
			preview = {
				win_config = {
					border = utils.CONST.border,
					winblend = utils.CONST.winblend,
				},
				mappings = {
					scrollU = "<C-u>",
					scrollD = "<C-d>",
					jumpTop = "[",
					jumpBot = "]",
				},
			},
			provider_selector = function(_, ft)
				return ft_fold_provider[ft] or { "lsp", "indent" }
			end,
		})

		require("keymaps").build_keymaps({
			n = {
				{ "zR", ufo.openAllFolds },
				{ "zM", ufo.closeFoldsWith },
				{
					"z2",
					function()
						ufo.closeFoldsWith(1)
					end,
				},
				{
					"z3",
					function()
						ufo.closeFoldsWith(2)
					end,
				},
				{
					"zn",
					function()
						ufo.closeFoldsWith(1)
					end,
				},
			},
		})
	end,
	desc = "Folds",
}
