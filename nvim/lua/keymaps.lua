-- n, v, i, t = mode names
local function termcodes(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

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
	},

	n = {
		{ "j", "gj" },
		{
			"<leader>pd",
			function()
				local bufinfos = vim.fn.getbufinfo({ buflisted = 1 })
				vim.tbl_map(function(bufinfo)
					if bufinfo.changed == 0 and (not bufinfo.windows or #bufinfo.windows == 0) then
						-- vim.api.nvim_buf_delete(bufinfo.bufnr, { force = false, unload = false })
						vim.cmd("bd " .. tostring(bufinfo.bufnr))
					end
				end, bufinfos)
			end,
			opts = { silent = true, desc = "Wipeout all buffers not shown in a window" },
		},
		{
			"<leader>rs",
			"<cmd>:LspStart<cr>",
			opts = {
				desc = "Start LSP server manually",
			},
		},
		{ "k", "gk" },
		{ "<ESC>", "<cmd> noh <CR>", "no highlight" },
		{ "<leader>pv", vim.cmd.Ex },
		{ "<leader>tn", ":e %:h" }, -- adjacent
		{ "<leader>tt", create_spec },
		{ "<C-s>", "<cmd>:w<cr>" },
		{
			"<S-u>",
			function()
				vim.opt.statuscolumn = require("config").statuscolumn
				-- Restart UFO
				vim.cmd("UfoDisable")
				vim.cmd("UfoEnable")
			end,
		},

		{ "<leader>tw", "<cmd>:tabclose<cr>" },
		{ "<leader>q", "<cmd>:wqa<cr>" },
		{ "<leader>]", "<cmd>:bnext<cr>" },
		{ "<leader>[", "<cmd>:bprev<cr>" },
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

		{ "<A-k>", "O", "move line up" },

		{ "<leader>mk", "<cmd> :m-2 <CR>", "line up" },
		{ "<leader>mj", "<cmd> :m+ <CR>", "line down" },
		-- { "gh", "<Plug>VSCodeCommentaryLine"  },

		-- Copy all
		{ "<C-c>", "<cmd> %y+ <CR>", "copy whole file" },
		{ "<C-w>P", "<cmd>vertical resize 40<CR>" },
		{ "<C-w>O", "<cmd>vertical resize 160<CR>" },
		{ "<C-w>I", "<cmd>vertical resize 100<CR>" },
		{ "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
		{ "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },

		-- ALT+H
		{ "˙", require("smart-splits").resize_left },
		-- ALT+J
		{ "¬", require("smart-splits").resize_down },
		-- ALT+K
		{ "˚", require("smart-splits").resize_up },
		-- ALT+L
		{ "∆", require("smart-splits").resize_right },

		{ "<C-h>", "<cmd>:SmartCursorMoveLeft<cr>" },
		{ "<C-j>", "<cmd>:SmartCursorMoveDown<cr>" },
		{ "<C-k>", "<cmd>:SmartCursorMoveUp<cr>" },
		{ "<C-l>", "<cmd>:SmartCursorMoveRight<cr>" },

		{ "å", "zh" },
		{ "∂", "zl" },
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
		{ "<C-h>", require("smart-splits").move_cursor_left },
		{ "<C-j>", require("smart-splits").move_cursor_down },
		{ "<C-k>", require("smart-splits").move_cursor_up },
		{ "<C-l>", require("smart-splits").move_cursor_right },
	},

	t = { { "<C-x>", termcodes("<C-\\><C-N>"), "escape terminal " } },

	v = {
		{ "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
		{ "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
		{ "<S-j>", "}", "skip bracket" },
		{ "<S-k>", "{", "skip bracket up" },
		{ "<S-h>", "^", "start of line" },
		{ "<S-l>", "$", "end of line" },
		{ "n", "*", "next occurence" },
		{ "N", "#", "last occurence" },
		{ "<C-l>", "%" },
		{ "<C-k>", ":call VSCodeNotify('editor.action.jumpToBracket') <CR>" },
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
