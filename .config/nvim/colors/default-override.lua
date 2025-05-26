vim.cmd([[ru! colors/default.lua]])

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.cmd([[hi Normal guibg=NONE]])
    vim.cmd([[hi NormalFloat guibg=NONE]])

    vim.cmd([[hi QuickFixLine gui=underline]])

    vim.cmd([[hi DiagnosticUnderlineError gui=undercurl]])
    vim.cmd([[hi DiagnosticUnderlineHint gui=undercurl]])
    vim.cmd([[hi DiagnosticUnderlineInfo gui=undercurl]])
    vim.cmd([[hi DiagnosticUnderlineWarn gui=undercurl]])
  end,
})
