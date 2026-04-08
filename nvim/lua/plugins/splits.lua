return {
	"mrjones2014/smart-splits.nvim",
	config = function()
		local keymaps = {
			n = {
				{ "<M-h>", require("smart-splits").resize_left },
				-- ALT+J
				{ "<M-j>", require("smart-splits").resize_down },
				-- ALT+K
				{ "<M-k>", require("smart-splits").resize_up },
				-- ALT+L
				{ "<M-l>", require("smart-splits").resize_right },

				{ "<C-h>", require("smart-splits").move_cursor_left },
				{ "<C-j>", require("smart-splits").move_cursor_down },
				{ "<C-k>", require("smart-splits").move_cursor_up },
				{ "<C-l>", require("smart-splits").move_cursor_right },
			},
		}

		require("keymaps").build_keymaps(keymaps)
	end,
}
