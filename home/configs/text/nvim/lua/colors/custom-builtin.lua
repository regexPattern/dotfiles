vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    vim.cmd([[colo default]])

    vim.cmd([[hi Normal guibg=NONE]])
    vim.cmd([[hi NormalFloat guibg=NONE]])

    vim.cmd([[hi QuickFixLine gui=underline]])

    vim.cmd([[hi DiagnosticUnderlineError gui=undercurl]])
    vim.cmd([[hi DiagnosticUnderlineHint gui=undercurl]])
    vim.cmd([[hi DiagnosticUnderlineInfo gui=undercurl]])
    vim.cmd([[hi DiagnosticUnderlineWarn gui=undercurl]])

    vim.cmd([[hi RenderMarkdownH1Bg gui=reverse]])
    vim.cmd([[hi RenderMarkdownH2Bg gui=reverse]])
    vim.cmd([[hi RenderMarkdownH3Bg gui=reverse]])
    vim.cmd([[hi RenderMarkdownH4Bg gui=reverse]])
    vim.cmd([[hi RenderMarkdownH5Bg gui=reverse]])
    vim.cmd([[hi RenderMarkdownH6Bg gui=reverse]])

    vim.cmd([[hi LineNr guifg=NvimDarkCyan]])
  end,
})
