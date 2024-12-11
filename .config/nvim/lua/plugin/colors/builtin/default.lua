vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
  pattern = "*",
  callback = function()
    vim.cmd([[hi Normal guibg=NONE]])
    vim.cmd([[hi NormalFloat guibg=NONE]])

    vim.cmd([[hi QuickFixLine gui=underline]])

    vim.cmd([[hi DiagnosticUnderlineError gui=undercurl]])
    vim.cmd([[hi DiagnosticUnderlineHint gui=undercurl]])
    vim.cmd([[hi DiagnosticUnderlineInfo gui=undercurl]])
    vim.cmd([[hi DiagnosticUnderlineWarn gui=undercurl]])

    -- if vim.o.background == "dark" then
    --   vim.cmd([[hi NotificationInfo guifg=#1E2025 guibg=NvimLightGrey2]])
    --   vim.cmd([[hi NotificationWarning guifg=#1E2025 guibg=NvimLightYellow]])
    --   vim.cmd([[hi NotificationError guifg=1E2025 guibg=NvimDarkRed]])
    -- end

    vim.cmd([[hi CodeCompanionChatHeader gui=reverse]])

    -- https://github.com/nvim-neo-tree/neo-tree.nvim/blob/0774fa2085c62a147fcc7b56f0ac37053cc80217/lua/neo-tree/ui/highlights.lua#L270
    vim.cmd([[hi NeoTreeGitAdded guifg=#5FAF5F]])
    vim.cmd([[hi NeoTreeGitDeleted guifg=#FF5900]])
    vim.cmd([[hi NeoTreeGitModified guifg=#D7AF5F]])
    vim.cmd([[hi NeoTreeGitConflict guifg=#FF8700 gui=bold]])
    vim.cmd([[hi link NeoTreeGitIgnored NeoTreeDotfile]])
    vim.cmd([[hi link NeoTreeGitRenamed NeoTreeGitModified]])
    vim.cmd([[hi link NeoTreeGitStaged NeoTreeGitAdded]])
    vim.cmd([[hi link NeoTreeGitUnstaged NeoTreeGitConflict]])
    vim.cmd([[hi NeoTreeGitUntracked guifg=#FF8700]])

    vim.cmd([[hi GitSignsAdd guibg=#5FAF5F]])
    vim.cmd([[hi GitSignsDelete guibg=#FF5900]])
  end,
})

return {
  name = "default",
  setup = function()
    vim.cmd([[colorscheme default]])
  end,
}
