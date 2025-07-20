vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
  },
  "https://github.com/Darazaki/indent-o-matic",
})

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function()
    require("nvim-treesitter.install").update({ with_sync = true })()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    if pcall(vim.treesitter.start) then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
