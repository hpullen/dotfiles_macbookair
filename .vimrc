" General settings
" Syntax highlighting
syntax enable
" No need to be compatible with vi
set nocompatible
" Hybrid line number mode
set relativenumber
set number  
" Allow mouse usage
set mouse=nicr
" Auto/smart indentation
set autoindent
set smartindent
" Save .un file with undo history
set undofile
" Backspace can erase multiple characters
set backspace=indent,eol,start
" Highlight current line
set cursorline
" UTF8 encoding
set encoding=utf-8
" Show at least 10 lines between cursor and end of screen
set scrolloff=10
" Tab completion in execute mode
set wildmenu
" Only redraw when needed
set lazyredraw
" Indicate fast terminal
set ttyfast
" Highlight matching bracket
set showmatch
" Wrap text at 84 characters
set textwidth=84
" Highlight column 85
set colorcolumn=85
" Show line/column number
set ruler
" Flash for bell
set visualbell
" Allow bright colours
set t_Co=256

" More natural split settings
set splitright
set splitbelow

" Add restore_view plugin
set runtimepath^=~/.vim/bundle/restore_view.vim

" Map alt + hjkl to split movements
nnoremap ∆ <C-w>j
nnoremap ˚ <C-w>k
nnoremap ˙ <C-w>h
nnoremap ¬ <C-w>l

" Make Y behave like C and D (yank to end of line)
nnoremap Y y$

" Split line with K
nnoremap K i<CR><ESC>
" Split line and add quotes with \k and \j
nnoremap <leader>k i"<CR>"<ESC>
nnoremap <leader>j i'<CR>'<ESC>

" Modify search options
" Smart case sensitivity
set ignorecase
set smartcase
" Global search and replace by default
set gdefault
" Show matches for pattern while typing
set incsearch
" Highlight matches
set hlsearch
" Turn off highlight with \<space>
nnoremap <silent> <leader><space> :noh<cr>
" Search for visually selected text with //
vnoremap // y/\V<C-R>"<CR>  

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

" Strip all trailing whitespace with \W
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Create equals signs after line of text
nnoremap <silent> <leader>1 yypVr=
" Surround line with Python comments 
nnoremap <silent> <leader>2 I#<space><esc>yyPVr=0r#lr<space>jyypVr=0r#lr<space>
" Surround line with C comments
noremap <silent> <leader>3 I//<space><esc>yyPVr=0r/lr/lr<space>jyypVr=0r/lr/lr<space>
" Regenerate C comments around line
noremap <silent> <leader>4 kddjddk^3xI//<space><esc>yyPVr=0r/lr/lr<space>jyypVr=0r/lr/lr<space>
" Put quotes and std::cout around line
noremap <silent> <leader>5 Istd::cout<space><<<space>"<esc>A"<space><<<space>std::endl;<esc>

" Copy to system clipboard in visual mode with \y
vnoremap <silent> <leader>y "+y
" Paste from system clipboard with \p
nnoremap <silent> <leader>p "+p

" Toggle paste mode on and off with F3
set pastetoggle=<F3>

" Remap left and right to browse buffers in normal mode
nnoremap <silent> <Left> :bprevious<CR>
nnoremap <silent> <Right> :bnext<CR>

" Move vertically by visual line
nnoremap j gj
nnoremap k gk

" Folding
set foldenable
set foldnestmax=5
set foldlevelstart=5
set foldmethod=syntax
" Open/close folds with space
nnoremap <space> za

" Save and reload view on closing/opening a buffer
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview 

" Colourscheme
set background=dark
colorscheme solarized

" Timeout
set timeoutlen=200
set ttimeoutlen=200

" Easy insert bash shebang
iab shebang #!/usr/bin/env bash

" Files to ignore in vim wild search
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pdf,*.root,*.o,*.un~

" Plugins
" Vim-plug
call plug#begin()
" NerdCommenter autocommenting
Plug 'scrooloose/nerdcommenter'
" NerdTree file explorer
Plug 'scrooloose/nerdtree'
" Airline
Plug 'vim-airline/vim-airline'
" Airline themes
Plug 'vim-airline/vim-airline-themes'
" Syntastic
Plug 'vim-syntastic/syntastic'
" YCM generator
Plug 'rdnetto/YCM-Generator', {'branch': 'stable'}
" Solarized for color_coded
Plug 'NigoroJr/color_coded-colorschemes'
" Tabularize
Plug 'godlygeek/tabular'
" Fugitive
Plug 'tpope/vim-fugitive'
" Gitgutter
Plug 'airblade/vim-gitgutter'
" Surround
Plug 'tpope/vim-surround'
" Abolish
Plug 'tpope/vim-abolish'
" Repeat for surround and abolish
Plug 'tpope/vim-repeat'
" Automatic bracket closing
Plug 'raimondi/delimitmate'
" CtrlP
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

" Vundle (needed for YouCompleteMe)
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" YouCompleteMe autocompleter
Plugin 'Valloric/YouCompleteMe'
" Colour coding for C family languages
Plugin 'jeaye/color_coded'
call vundle#end()
filetype plugin indent on

" Airline settings
set laststatus=2
" Use powerline fonts
let g:airline_powerline_fonts=1
" Solarized colorscheme for airline
let g:airline_theme = 'solarized'
" Show buffers/tabs at top
let g:airline#extensions#tabline#enabled=1
" Show filename only in buffer/tab display
let g:airline#extensions#tabline#fnamemod = ':t'

" YouCompleteMe settings
" Default extra conf location
let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/.ycm_extra_conf.py"
" Don't ask whether to use extra conf
let g:ycm_confirm_extra_conf = 0
" Turn off annoying extra window
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0

" Syntastic settings
" Turn off by default for c/cpp (using ycm) and python (annoying for davinci/ganga)
let g:syntastic_mode_map = { 'passive_filetypes': ['c', 'cpp', 'python'] }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" Use flake8 (pep8 style check + syntax check)
let g:syntastic_python_checkers = ['flake8']
" Don't let error list get too big
let g:syntastic_loc_list_height=4
" Toggle active/passive mode with \s
nnoremap <leader>s :SyntasticToggleMode<CR>

" CtrlP settings
" Mappings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" Set working directory to nearest ancestor containing .git
let g:ctrlp_working_path_mode = 'ra'
" If file already open, open again in new pane
let g:ctrlp_switch_buffer = 'et'
" Files to ignore
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(o|root|pdf|exe|so|dll)$',
  \ }
" Ignore files in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" Color_coded solarized colorscheme
colorscheme solarizeded

" Syntax highlighting for parameter files
highlight ParamValue ctermfg=cyan guifg=#00ffff
highlight ParamKey ctermfg=magenta  guifg=#00ffff
