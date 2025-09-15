vim.pack.add({ "https://github.com/echasnovski/mini.surround" }, { confirm = false })

return {
  "mini.surround",
  lazy = false,
  after = function()
    require("mini.surround").setup()
  end,
}
