-- https://github.com/brenoprata10/nvim-highlight-colors
vim.api.nvim_create_autocmd("BufReadPre", {
  group = vim.api.nvim_create_augroup("nvim-highlight-colors.setup", {}),
  once = true,
  callback = function()
    require("nvim-highlight-colors").setup({
      enable_named_colors = false,
      exclude_buftypes = { "nofile" },
    })
  end,
})
