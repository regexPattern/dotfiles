vim.g.mapleader = " "

vim.cmd([[filetype plugin indent on]])
if vim.fn.exists("syntax_on") ~= 1 then
  vim.cmd([[syntax enable]])
end

-- stylua: ignore start

-- General
vim.o.mouse       = "a"
vim.o.mousescroll = "ver:5,hor:5"
vim.o.undofile    = true

-- UI
vim.o.breakindent    = true
vim.o.breakindentopt = "list:-1"
vim.o.colorcolumn    = "+1"
vim.o.linebreak      = true
vim.o.pumborder      = "none"
vim.o.pumheight      = 10
vim.o.pummaxwidth    = 100
vim.o.splitbelow     = true
vim.o.splitkeep      = "screen"
vim.o.splitright     = true
vim.o.winborder      = "single"
vim.o.wrap           = false

-- Editing
vim.o.autoindent    = true
vim.o.expandtab     = true
vim.o.formatoptions = "rqnl1j"
vim.o.ignorecase    = true
vim.o.incsearch     = true
vim.o.infercase     = true
vim.o.scrolloff     = 5
vim.o.shiftwidth    = 4
vim.o.smartcase     = true
vim.o.smartindent   = true
vim.o.spelloptions  = "camel"
vim.o.tabstop       = 4
vim.o.virtualedit   = "block"

vim.o.iskeyword     = "@,48-57,_,192-255,-"
vim.o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

-- Completion
vim.o.complete    = ".,w,b,kspell"
vim.o.completeopt = "menuone,noselect,fuzzy,nosort"

-- stylua: ignore end

-- Diagnostics
Config.later(function()
  vim.diagnostic.config({
    virtual_lines = false,
    virtual_text = { current_line = true },
    severity_sort = true,
  })
end)

-- Colorscheme
Config.now(function()
  vim.cmd([[
    colo default
    hi Normal guibg=NONE
    hi NormalNC guibg=NONE
    hi NormalFloat guibg=NONE
  ]])
end)
