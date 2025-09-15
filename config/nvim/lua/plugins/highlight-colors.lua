vim.pack.add({ "https://github.com/brenoprata10/nvim-highlight-colors" }, { confirm = false })

return {
  "nvim-highlight-colors",
  event = { "BufReadPre" },
  after = function()
    require("nvim-highlight-colors").setup({
      enable_named_colors = false,
      exclude_buftypes = { "nofile" },
    })
  end,
}
