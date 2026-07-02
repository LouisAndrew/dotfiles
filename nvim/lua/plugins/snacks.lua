return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    opts.scroll = { enabled = false }
    opts.indent = { enabled = false }

    opts.picker = opts.picker or {}
    opts.picker.win = opts.picker.win or {}
    opts.picker.win.input = opts.picker.win.input or {}
    opts.picker.win.list = opts.picker.win.list or {}
    opts.picker.win.input.keys = opts.picker.win.input.keys or {}
    opts.picker.win.list.keys = opts.picker.win.list.keys or {}

    opts.picker.win.input.keys["<C-d>"] = { "preview_scroll_down", mode = { "i", "n" } }
    opts.picker.win.input.keys["<C-u>"] = { "preview_scroll_up", mode = { "i", "n" } }
    opts.picker.win.input.keys["<C-l>"] = { "edit_vsplit", mode = { "i", "n" } }
    opts.picker.win.list.keys["<C-d>"] = "preview_scroll_down"
    opts.picker.win.list.keys["<C-u>"] = "preview_scroll_up"
    opts.picker.win.list.keys["<C-l>"] = "edit_vsplit"
  end,
}
