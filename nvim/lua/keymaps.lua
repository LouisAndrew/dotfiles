local function build_keymaps(keymaps, opts)
	for mode, t in pairs(keymaps) do
		for _, remap in pairs(t) do
			vim.keymap.set(mode, remap[1], remap[2], vim.tbl_extend("force", opts or {}, remap.opts or {}))
		end
	end
end

local function create_spec()
	local ft_specfile = {
		["typescript"] = ".spec.ts",
		["javascript"] = ".spec.js",
		["typescriptreact"] = ".spec.tsx",
		["javascriptreact"] = ".spec.jsx",
		["go"] = "_test.go",
		["vue"] = ".spec.ts",
	}

	local ft = vim.bo.filetype
	local specfile = ft_specfile[ft]
	if specfile then
		vim.cmd("e %:r" .. specfile)
	end
end

local M = {
	i = {
		-- go to  beginning and end
		{ "<C-b>", "<ESC>^i", "beginning of line" },
		{ "<C-e>", "<End>", "end of line" },
		-- navigate within insert mode
		{ "<C-h>", "<Left>", "move left" },
		{ "<C-l>", "<Right>", "move right" },
		{ "<C-j>", "<Down>", "move down" },
		{ "<C-k>", "<Up>", "move up" },
		{ "<C-4>", "<End>" },
		{ "<C-6>", "<cmd>:norm ^<CR>" },
		{ "<S-Tab>", "<cmd>:norm <<^<CR>" },
		{ "jj", "<esc>" },
	},

	n = {
		{ "j", "gj" },
		{ "zo", "za" },
		{
			"<leader>pd",
			function()
				local bufinfos = vim.fn.getbufinfo({ buflisted = 1 })
				vim.tbl_map(function(bufinfo)
					if bufinfo.changed == 0 and (not bufinfo.windows or #bufinfo.windows == 0) then
						vim.cmd("bd " .. tostring(bufinfo.bufnr))
					end
				end, bufinfos)
			end,
			opts = { silent = true, desc = "Wipeout all buffers not shown in a window" },
		},

		{ "<ESC>", "<cmd> noh <CR>", "no highlight" },
		{ "k", "gk" },
		{ "<leader>tn", ":e %:h" }, -- adjacent
		{ "<leader>tt", create_spec },
		{
			"<S-u>",
			function()
				vim.opt.statuscolumn = require("opts").statuscolumn
				vim.cmd("UfoDisable")
				vim.cmd("UfoEnable")
			end,
		},

		{ "<leader>tw", "<cmd>:tabclose<cr>" },
		{ "<leader>q", "<cmd>:wqa<cr>" },
		{ "<C-p>", "<cmd>:bprev<cr>" },
		{ "<C-n>", "<cmd>:bnext<cr>" },
		{ "<leader>bw", "<cmd>:%bd|e#|bd#<cr>" },
		-- Customs
		{ "<S-h>", "^", "start of line" },
		{ "<S-l>", "$", "end of line" },
		{ "'", "*", "next occurence" },
		{ ";", "#", "last occurence" },
		{ "<C-u>", "<C-u>zz", "scroll page down" },
		{ "<C-d>", "<C-d>zz", "scroll page up" },

		{ "<leader>mk", "<cmd> :m-2 <CR>", "line up" },
		{ "<leader>mj", "<cmd> :m+ <CR>", "line down" },
		-- { "gh", "<Plug>VSCodeCommentaryLine"  },

		-- Copy all
		{ "<C-c>", "<cmd> %y+ <CR>", "copy whole file" },
		{ "<C-w>P", "<cmd>vertical resize 40<CR>" },
		{ "<C-w>O", "<cmd>vertical resize 160<CR>" },
		{ "<C-w>I", "<cmd>vertical resize 80<CR>" },
		{ "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
		{ "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },

		-- ALT+H
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

		{ "å", "zh" },
		{ "∂", "zl" },
		{ "ß", "zh" },
		{ "ƒ", "zl" },
		{ "∫", "50zh" },
		{ "∑", "50zl" },
		{ "]z", "zj" },
		{ "[z", "zk" },

		{ "<leader>'", "gt" },
		{ "<leader>;", "gT" },

		-- Window management
		{ "<leader>w", "<cmd>:bd<cr>" },
		{ "<leader>W", "<cmd>:q<cr>" },
		{ "<leader>tj", "<cmd>:sp<cr>" },
		{ "<leader>tl", "<cmd>:vsp<cr>" },

		{ "Q", "@qj", "Fast macro, always save on Q" },

		{ "<leader>t[", "<cmd>:tabprev<cr>" }, -- adjacent
		{ "<leader>t]", "<cmd>:tabnext<cr>" }, -- spec file
		{ "<c-h>", require("smart-splits").move_cursor_left },
		{ "<c-j>", require("smart-splits").move_cursor_down },
		{ "<c-k>", require("smart-splits").move_cursor_up },
		{ "<c-l>", require("smart-splits").move_cursor_right },

		{
			"S",
			"<cmd>:w<cr>",
			desc = "Save file",
		},

		{ "W", "<cmd>:bd<cr>", desc = "Exit buffer" },
	},

	v = {
		{ "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
		{ "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
		{ "<S-h>", "^", "start of line" },
		{ "<S-l>", "$", "end of line" },
		{ "n", "*", "next occurence" },
		{ "N", "#", "last occurence" },
		{ "s", "<Plug>(nvim-surround-visual)" },
	},

	x = {
		{ "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
		{ "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
		-- Don't copy the replaced text after pasting in visual mode
		-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
		{ "p", 'p:let @+=@0<CR>:let @"=@0<CR>', opts = { silent = true } },
		{ "Q", ":norm @q<CR>", "Fast macro, always save on Q" },
	},
}

build_keymaps(M)

return {
	M = M,
	build_keymaps = build_keymaps,
}
