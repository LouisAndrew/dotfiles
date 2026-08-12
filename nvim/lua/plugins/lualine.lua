local icons = require("utils.icons")
local colors = require("utils.palette")

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    return {
      options = {
        section_separators = "",
        component_separators = "",
        theme = {
          normal = {
            c = { bg = colors.bg, fg = colors.subtle },
            x = { bg = colors.bg },
          },
          inactive = { c = { bg = colors.bg }, x = { bg = colors.bg } },
        },
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            function()
              local root = vim.fn.getcwd()
              return string.gsub(root, "^.*/(.*)$", "%1")
            end,
            padding = { left = 1 },
            color = {
              fg = colors.fg_hi,
            },
          },
          {
            "branch",
            icon = "",
            padding = { right = 0, left = 0 },
          },
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = {
              error = icons.Error,
              warn = icons.Warn,
              info = icons.Info,
              hint = icons.Hint,
            },
            padding = { left = 1, right = 1 },
          },
          {
            function()
              ---@diagnostic disable-next-line: undefined-field
              local mode = require("noice").api.status.mode.get()
              if mode:find("^recording") then
                return mode
              end

              return ""
            end,
            ---@diagnostic disable-next-line: undefined-field
            cond = require("noice").api.status.mode.has,
            color = { fg = colors.muted },
          },
        },
        lualine_x = {
          {
            "buffers",
            filetype_names = {
              TelescopePrompt = "",
            },
            buffers_color = {
              active = {
                fg = colors.fg,
              },
              inactive = {
                fg = colors.subtle,
              },
            },

            symbols = {
              modified = " " .. icons.Modified,
              alternate_file = "",
              directory = "",
            },
          },
        },
        lualine_y = {},
        lualine_z = {},
      },
    }
  end,
}
