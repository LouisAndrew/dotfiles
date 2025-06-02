vim.api.nvim_create_user_command("PickFiles", function()
  Snacks.picker.files({
    hidden = true,
  })
end, {})

vim.api.nvim_create_user_command("Grep", function()
  Snacks.picker.grep()
end, {})
