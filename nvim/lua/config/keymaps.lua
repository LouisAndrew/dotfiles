vim.keymap.set("i", "jj", "<Esc>")

local function snacks_picker_project_opts()
  local exclude = vim.g.snacks_picker_exclude
  return type(exclude) == "table" and { exclude = exclude } or {}
end

vim.keymap.set("n", "<c-o>", function()
  Snacks.picker.files(snacks_picker_project_opts())
end, { desc = "Open file picker" })

vim.keymap.set("n", "<c-f>", function()
  Snacks.picker.grep(snacks_picker_project_opts())
end, { desc = "Open grep" })

for _, lhs in ipairs({ "<leader>bb", "<leader>bd", "<leader>bo", "<leader>bi", "<leader>bD" }) do
  pcall(vim.keymap.del, "n", lhs)
end

vim.keymap.set("n", "<C-w>Q", "<cmd>wqa<cr>", { desc = "Close all windows and quit" })
vim.keymap.set("n", "<C-b>b", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<C-b>d", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })
vim.keymap.set("n", "<C-b>o", function()
  Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })
vim.keymap.set("n", "<C-b>i", function()
  Snacks.bufdelete.invisible()
end, { desc = "Delete Invisible Buffers" })
vim.keymap.set("n", "<C-b>D", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

vim.keymap.set("n", "<C-T>h", "<cmd>tabnext<cr>", { desc = "Next tab" })
vim.keymap.set("n", "<C-T>l", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
vim.keymap.set("n", "<C-T>q", "<cmd>tabclose<cr>", { desc = "Close tab" })

-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
-- moving between splits
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
-- swapping buffers between windows
vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
