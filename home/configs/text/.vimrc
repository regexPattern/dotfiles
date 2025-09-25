set autoindent
set smartindent
set linebreak
set number
set relativenumber
set nowrap
set splitbelow
set splitright
set undofile
set noswapfile
set termguicolors
set scrolloff=5
set tabstop=2
set shiftwidth=2
set ignorecase
set smartcase

let g:mapleader = " "

nnoremap <C-Right> :vertical resize +5<CR>
nnoremap <C-Left> :vertical resize -5<CR>
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>

nnoremap - :Explore<CR>
