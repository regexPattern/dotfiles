vim.diagnostic.config({ severity_sort = true })

vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end)

vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end)
