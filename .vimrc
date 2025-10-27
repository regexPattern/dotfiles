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
set tabstop=4
set shiftwidth=0
set ignorecase
set smartcase
set completeopt=menuone,noselect

let mapleader = " "

nnoremap <silent> - :Explore<CR>
nnoremap <silent> <C-Right> :vert res +5<CR>
nnoremap <silent> <C-Left> :vert res -5<CR>
nnoremap <silent> <C-Up> :res +2<CR>
nnoremap <silent> <C-Down> :res -2<CR>

function! s:SetColorScheme() abort
  colo default
  hi Normal guibg=NONE
  hi NormalFloat guibg=NONE
  hi QuickFixLine gui=underline
  hi DiagnosticUnderlineError gui=undercurl
  hi DiagnosticUnderlineHint gui=undercurl
  hi DiagnosticUnderlineInfo gui=undercurl
  hi DiagnosticUnderlineWarn gui=undercurl
  hi RenderMarkdownH1Bg gui=reverse
  hi RenderMarkdownH2Bg gui=reverse
  hi RenderMarkdownH3Bg gui=reverse
  hi RenderMarkdownH4Bg gui=reverse
  hi RenderMarkdownH5Bg gui=reverse
  hi RenderMarkdownH6Bg gui=reverse
endfunction

augroup AfterBackgroundSet
  autocmd!
  autocmd OptionSet background call s:SetColorScheme()
augroup END
