local map = vim.keymap

local function build_keymaps(keymaps, opts)
  for mode, t in pairs(keymaps) do
    for _, remap in pairs(t) do
      map.set(mode, remap[1], remap[2], vim.tbl_extend("force", opts or {}, remap.opts or {}))
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
    { "<M-h>", splits.resize_left },
    { "<M-j>", splits.resize_down },
    { "<M-k>", splits.resize_up },
    { "<M-l>", splits.resize_right },
    { "<C-h>", splits.move_cursor_left },
    { "<C-j>", splits.move_cursor_down },
    { "<C-k>", splits.move_cursor_up },
    { "<C-l>", splits.move_cursor_right },
    { "<leader>tj", "<cmd>:sp<cr>", desc = "Split current buffer" },
    { "<leader>tl", "<cmd>:vsp<cr>", desc = "VSplit current buffer" },
    { "W", "<cmd>:bd<cr>", desc = "Exit buffer" },
    { "<leader>Q", "<cmd>:wqa<cr>", desc = "Exit nvim" },
    { "zo", "za", desc = "Toggle fold under cursor" },
    {
      "<leader>pd",
      function()
        local bufinfos = vim.fn.getbufinfo({ buflisted = 1 })
        vim.tbl_map(function(bufinfo)
          local count = 0
          if bufinfo.changed == 0 and (not bufinfo.windows or #bufinfo.windows == 0) then
            vim.cmd("bd " .. tostring(bufinfo.bufnr))
            count = count + 1
          end

          print(count .. " buffers deleted")
        end, bufinfos)
      end,
      opts = { silent = true, desc = "Wipeout all buffers not shown in a window" },
    },
    { "<C-c>", "<cmd> %y+ <CR>", "copy whole file" },
  },
  v = {
    { "<S-h>", "^", "start of line" },
    { "<S-l>", "$", "end of line" },
  },
}

build_keymaps(M)
