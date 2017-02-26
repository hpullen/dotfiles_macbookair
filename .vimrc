" General settings
syntax enable
set nocompatible
set relativenumber
set mouse=nicr
set autoindent
set smartindent
set undofile
set backspace=indent,eol,start
set cursorline
set encoding=utf-8
set scrolloff=3
set wildmenu
set lazyredraw
set ttyfast
set showmatch
set colorcolumn=87
set visualbell
set t_Co=256
inoremap jk <ESC>
nnoremap ; :

" Modify search options
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set hlsearch
nnoremap <silent> <leader><space> :noh<cr>
vnoremap // y/\V<C-R>"<CR>  " Search for visually selected text

" Tab settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Disable autocommenting on new lines
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Strip all trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Scrolling
"noremap <ScrollWheelUp> <C-Y>
"nnoremap <ScrollWheelDown <C-E>

" Create equals signs before/after line of text
nnoremap <silent> <leader>1 yypVr=
nnoremap <silent> <leader>2 yykpVr=
nnoremap <silent> <leader>3 yypVr=kyykpVr=

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

" Folding
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=syntax
nnoremap <space> za

" Add restore_view plugin
set runtimepath^=~/.vim/bundle/restore_view.vim

" Colourscheme
set background=dark
colorscheme solarized

" Plugins
" Vim-plug
call plug#begin()
" NerdCommenter autocommenting
Plug 'scrooloose/nerdcommenter'
" NerdTree file explorer
Plug 'scrooloose/nerdtree'
" Surroundings/parentheses changer e.g. cd(' changes () to ''
Plug 'tpope/vim-surround'
" Airline
Plug 'vim-airline/vim-airline'
" Airline themes
Plug 'vim-airline/vim-airline-themes'
" Syntastic
Plug 'vim-syntastic/syntastic'
" Fugitive
Plug 'tpope/vim-fugitive'
" YCM generator
Plug 'rdnetto/YCM-Generator', {'branch': 'stable'}
call plug#end()

" Vundle (needed for YouCompleteMe)
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" YouCompleteMe autocompleter
Plugin 'Valloric/YouCompleteMe'
call vundle#end()
filetype plugin indent on

" Airline settings
set laststatus=2
let g:airline_powerline_fonts=1
let g:airline_theme = 'solarized'
let g:airline#extensions#tabline#enabled=1

" YouCompleteMe settings
"let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/.ycm_extra_conf.py"
let g:ycm_extra_conf = 0


" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_check_header = 1
let g:syntastic_c_include_dirs = ['../../include','../include','../inc']
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_loc_list_height=5
nnoremap <silent> <leader>r :SyntasticReset<CR>

