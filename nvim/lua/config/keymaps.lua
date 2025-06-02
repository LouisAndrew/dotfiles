local function build_keymaps(keymaps, opts)
  for mode, t in pairs(keymaps) do
    for _, remap in pairs(t) do
      vim.keymap.set(mode, remap[1], remap[2], vim.tbl_extend("force", opts or {}, remap.opts or {}))
    end
  end
end

local splits = require("smart-splits")

local M = {
  i = {
    { "jj", "<esc>", "normal mode" },
  },
  n = {
    { "<S-h>", "^", "start of line" },
    { "<S-l>", "$", "end of line" },
    { "<S-s>", "<cmd>:w<cr>", "save file" },
    { "<C-p>", "<cmd>:bprev<cr>", "prev buffer" },
    { "<C-n>", "<cmd>:bnext<cr>", "next buffer" },
    { "'", "*", "next occurence" },
    { ";", "#", "last occurence" },
    { "<c-u>", "<c-u>zz", "scroll up" },
    { "<c-d>", "<c-d>zz", "scroll up" },
    { "<A-h>", splits.resize_left },
    { "¬", splits.resize_down },
    { "˚", splits.resize_up },
    { "∆", splits.resize_right },
    { "<c-h>", splits.move_cursor_left },
    { "<c-j>", splits.move_cursor_down },
    { "<c-k>", splits.move_cursor_up },
    { "<c-l>", splits.move_cursor_right },
    { "<leader>tj", "<cmd>:sp<cr>", desc = "Split current buffer" },
    { "<leader>tl", "<cmd>:vsp<cr>", desc = "VSplit current buffer" },
    { "W", "<cmd>:bd<cr>", desc = "Exit buffer" },
    { "<leader>Q", "<cmd>:wqa<cr>", desc = "Exit nvim" },
  },
  v = {
    { "<S-h>", "^", "start of line" },
    { "<S-l>", "$", "end of line" },
  },
}

build_keymaps(M)
