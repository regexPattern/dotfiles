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

vim.keymap.set("n", "<C-Right>", ":vert res +5<CR>", { silent = true })
vim.keymap.set("n", "<C-Left>", ":vert res -5<CR>", { silent = true })
vim.keymap.set("n", "<C-Up>", ":res +2<CR>", { silent = true })
vim.keymap.set("n", "<C-Down>", ":res -2<CR>", { silent = true })

vim.pack.add({ "https://github.com/nvim-neorocks/lz.n" }, { confirm = false })
require("lz.n").load("plugins")
