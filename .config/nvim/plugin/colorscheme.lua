vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    vim.print(vim.o.background)
    vim.cmd([[colo default-override]])
  end,
})
