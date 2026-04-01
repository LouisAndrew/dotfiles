vim.o.termguicolors = true
vim.g.colors_name = "mfgh"

package.loaded["lush_theme.mfgh"] = nil
require("lush")(require("lush_theme.mfgh"))
