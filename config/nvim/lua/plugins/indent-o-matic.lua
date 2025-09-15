vim.pack.add({ "https://github.com/Darazaki/indent-o-matic" }, { confirm = false })

return {
  "indent-o-matic",
  after = function()
    require("indent-o-matic").setup({})
  end,
}
