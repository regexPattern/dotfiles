vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" }, { confirm = false })

vim.api.nvim_create_autocmd("PackChanged", {
  command = [[TSUpdate]],
})

return {
  "nvim-treesitter",
  lazy = false,
  after = function()
    require("nvim-treesitter.configs").setup({
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
