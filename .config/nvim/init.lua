vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.linebreak = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.undofile = true
vim.opt.swapfile = false

vim.opt.termguicolors = true
vim.opt.scrolloff = 5

vim.opt.tabstop = 4
vim.opt.shiftwidth = vim.o.tabstop

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.completeopt = "menuone,noselect,fuzzy,nosort"
vim.opt.winborder = "single"

vim.g.mapleader = " "

vim.keymap.set("n", "-", ":Explore<CR>", { silent = true })
vim.keymap.set("n", "<C-Right>", ":vert res +5<CR>", { silent = true })
vim.keymap.set("n", "<C-Left>", ":vert res -5<CR>", { silent = true })
vim.keymap.set("n", "<C-Up>", ":res +2<CR>", { silent = true })
vim.keymap.set("n", "<C-Down>", ":res -2<CR>", { silent = true })

vim.pack.add({
  "https://github.com/Darazaki/indent-o-matic",
  "https://github.com/b0o/SchemaStore.nvim",
  "https://github.com/brenoprata10/nvim-highlight-colors",
  "https://github.com/echasnovski/mini.align",
  "https://github.com/echasnovski/mini.icons",
  "https://github.com/echasnovski/mini.surround",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/j-hui/fidget.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/stevearc/oil.nvim",
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
  },
})

vim.cmd([[hi Normal guibg=NONE]])

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
  end,
})
