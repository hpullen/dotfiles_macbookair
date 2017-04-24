" General settings
syntax enable
set nocompatible
set relativenumber
set number  " Use both to get hybrid line number mode
set mouse=nicr
set autoindent
set smartindent
set undofile
set backspace=indent,eol,start
set cursorline
set encoding=utf-8
set scrolloff=8
set wildmenu
"set lazyredraw
set ttyfast
set showmatch
set textwidth=84
set colorcolumn=85
set ruler
set visualbell
set t_Co=256
inoremap jk <ESC>
"nnoremap ; :

" Make Y behave like C and D
nnoremap Y y$

" Split line with K
nnoremap K i<CR><ESC>
nnoremap <leader>k i"<CR>"<ESC>
nnoremap <leader>j i'<CR>'<ESC>

" Modify search options
set ignorecase
set smartcase
set gdefault
set incsearch
set hlsearch
nnoremap <silent> <leader><space> :noh<cr>
vnoremap // y/\V<C-R>"<CR>  " Search for visually selected text

" Tab settings
filetype off
filetype plugin indent on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Disable autocommenting on new lines
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
au FileType c,cpp setlocal comments-=:// comments+=f://

" Strip all trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Scrolling
"noremap <ScrollWheelUp> <C-Y>
"nnoremap <ScrollWheelDown <C-E>

" Create equals signs after line of text
nnoremap <silent> <leader>1 yypVr=
" Python comments
nnoremap <silent> <leader>2 I#<space><esc>yyPVr=0r#lr<space>jyypVr=0r#lr<space>
" C comments
noremap <silent> <leader>3 I//<space><esc>yyPVr=0r/lr/lr<space>jyypVr=0r/lr/lr<space>
" Regenerate C comments
noremap <silent> <leader>4 kddjddk^3xI//<space><esc>yyPVr=0r/lr/lr<space>jyypVr=0r/lr/lr<space>
" std::cout
noremap <silent> <leader>5 Istd::cout<space><<<space>"<esc>A"<space><<<space>std::endl;<esc>

" Copy to system clipboard in visual mode
vnoremap <silent> <leader>y "+y
vnoremap <silent> <leader>p "+p

" Toggle paste mode on and off
set pastetoggle=<F3>

" Remap left and right to browse buffers in normal mode
nnoremap <silent> <Left> :bprevious<CR>
nnoremap <silent> <Right> :bnext<CR>

" Move vertically by visual line
nnoremap j gj
nnoremap k gk

"" Folding
"set foldenable
"set foldlevelstart=10
"set foldnestmax=10
"set foldmethod=syntax
"nnoremap <space> za

" Add restore_view plugin
set runtimepath^=~/.vim/bundle/restore_view.vim

" Colourscheme
set background=dark
colorscheme solarized

" Selectively turn off plugins
" set runtimepath-=~/.vim/bundle/YouCompleteMe
"set runtimepath-=~/.vim/bundle/color_coded

" Plugins
" Vim-plug
call plug#begin()
" NerdCommenter autocommenting
Plug 'scrooloose/nerdcommenter'
"" NerdTree file explorer
Plug 'scrooloose/nerdtree'
"" Airline
Plug 'vim-airline/vim-airline'
" Airline themes
Plug 'vim-airline/vim-airline-themes'
" Syntastic
Plug 'vim-syntastic/syntastic'
"" Fugitive
"Plug 'tpope/vim-fugitive'
" YCM generator
Plug 'rdnetto/YCM-Generator', {'branch': 'stable'}
"" Solarized for color_coded
Plug 'NigoroJr/color_coded-colorschemes'
" Tabularize
Plug 'godlygeek/tabular'
call plug#end()

" Vundle (needed for YouCompleteMe)
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" YouCompleteMe autocompleter
Plugin 'Valloric/YouCompleteMe'
" Colour coding for C family
Plugin 'jeaye/color_coded'
call vundle#end()
filetype plugin indent on

" Airline settings
set laststatus=2
let g:airline_powerline_fonts=1
let g:airline_theme = 'solarized'
let g:airline#extensions#tabline#enabled=1

" YouCompleteMe settings
let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/.ycm_extra_conf.py"
let g:ycm_confirm_extra_conf = 0
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0

" Syntastic settings
let g:syntastic_mode_map = { 'passive_filetypes': ['c', 'cpp'] }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_disabled_filetypes=['c','cpp']
let g:syntastic_loc_list_height=5
nnoremap <leader>r :SyntasticReset<CR>
nnoremap <leader>s :SyntasticToggleMode<CR>

" Color_coded solarized colorscheme
colorscheme solarizeded

" Timeout
set timeoutlen=200
set ttimeoutlen=200

" Common spelling mistakes autocorrect
iab stdLLcout std::cout
iab stdLLendl; std::endl;

" Easy insert bash shebang
iab shebang #!/usr/bin/env bash

" Syntax highlighting for parameter files
highlight ParamValue ctermfg=cyan guifg=#00ffff
highlight ParamKey ctermfg=magenta  guifg=#00ffff
