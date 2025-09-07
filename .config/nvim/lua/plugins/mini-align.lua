vim.pack.add({ "https://github.com/echasnovski/mini.align" }, { confirm = false })

return {
  "mini.align",
  lazy = false,
  after = function()
    require("mini.align").setup()
  end,
}
