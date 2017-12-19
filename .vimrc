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

" Make Y behave like C and D (yank to end of line)
nnoremap Y y$

" Split line with K
nnoremap K i<CR><ESC>
" Split line and add quotes with \k and \j
nnoremap <leader>k i"<CR>"<ESC>
nnoremap <leader>j i'<CR>'<ESC>

" Tab navigation
nnoremap <silent> <C-[> :tabprev<CR>
nnoremap <silent> <C-]> :tabnext<CR>
nnoremap <C-n> :tabnew<CR>
unmap <esc>

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
augroup filetype_C
    autocmd!
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    autocmd FileType c,cpp setlocal comments-=:// comments+=f://
    autocmd FileType c,cpp noremap <buffer> <silent> <leader>3 I//<space><esc>yyPVr=0r/lr/lr<space>jyypVr=0r/lr/lr<space>
    autocmd FileType c,cpp noremap <buffer> <silent> <leader>4 kddjddk^3xI//<space><esc>yyPVr=0r/lr/lr<space>jyypVr=0r/lr/lr<space>
    autocmd FileType c,cpp noremap <buffer> <silent> <leader>5 Istd::cout<space><<<space>"<esc>A"<space><<<space>std::endl;<esc>
augroup END

" Strip all trailing whitespace with \W
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Copy to system clipboard in visual mode with \y
vnoremap <silent> <leader>y "+y
" Paste from system clipboard with \p
nnoremap <silent> <leader>p "+p
" Paste from pplx tmux clipboard file with \tp
nnoremap <silent> <leader>tp :r ~/pplx/.tmux.clipboard<CR>
" Paste from pplx vim clipboard with \vp
nnoremap <silent> <leader>vp :r ~/pplx/.vim.clipboard<CR>
" Select last pasted text with gp
nnoremap gp `[v`]

" Mappings for editing/sourcing vimrc
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>

" Type a pomodoro
iab pomo 

" Toggle paste mode on and off with F3
set pastetoggle=<F3>

" Remap left and right to browse buffers in normal mode
nnoremap <silent> <Left> :bprevious<CR>
nnoremap <silent> <Right> :bnext<CR>

" Move vertically by visual line
nnoremap j gj
nnoremap k gk

" Dictionary for completion
" set dictionary+=/usr/share/dict/words

" Folding
set foldenable
" Only allow one level of folding
set foldnestmax=1
" Start with all folds open
set foldlevelstart=1
set foldmethod=syntax

" Save and reload view on closing/opening a buffer
set viewoptions-=options
augroup saveView
    autocmd!
    autocmd BufWinLeave *.* mkview! 
    autocmd BufWinEnter *.* silent loadview
augroup END

" Turn off gitgutter on pplx files
" augroup pplxFiles
    " autocmd!
    " autocmd BufWinEnter */pplx/* GitGutterDisable
" augroup END

" Fix highlight colour in Sneak (need to call before colorscheme)
augroup fixSneakHighlight
    autocmd!
    autocmd ColorScheme * hi Sneak guifg=black guibg=red ctermfg=black ctermbg=red
    autocmd ColorScheme * hi SneakScope guifg=red guibg=yellow ctermfg=red ctermbg=yellow
    autocmd ColorScheme * hi SneakLabel guifg=white guibg=magenta ctermfg=white ctermbg=green
augroup END

" Use spellcheck in text files
augroup filetype_text
    autocmd!
    autocmd FileType text nnoremap <buffer> <silent> <leader>1 yypVr=
    autocmd FileType text setlocal spell
    autocmd FileType text setlocal textwidth=0
    autocmd FileType text noremap <buffer> <leader>8 ?^\p\s<CR>ygnjPv0r<space>^
    autocmd FileType text hi SpellBad ctermfg=red
    autocmd FileType text hi SpellCap ctermfg=yellow
    autocmd FileType text set colorcolumn=0
    " Don't spellcheck all caps words
    autocmd FileType text syn match myExCapitalWords +\<\w*[A-Z]\K*\>+ contains=@NoSpell
augroup END

" Latex autocommands
augroup filetype_tex
    autocmd!
    autocmd FileType tex,plaintex,latex setlocal textwidth=0
    autocmd FileType tex,plaintex,latex setlocal spell
    autocmd FileType tex,plaintex,latex setlocal dictionary+=~/.vim/dictionaries/dictionary
    autocmd FileType tex,plaintex,latex setlocal colorcolumn=0
    autocmd FileType tex,plaintex,latex inoremap <buffer> <c-d> <c-x><c-k>
    autocmd FileType tex,plaintex,latex nnoremap <buffer> <leader>ee me?\\begin{[^}]\+}<CR>ygn<ESC>'eo<ESC>pBlceend<ESC>==:nohlsearch<CR>
    autocmd FileType tex,plaintex,latex nnoremap <buffer> <leader>ed /\u\u\.<CR>f.i\@<ESC>
    autocmd FileType tex,plaintex,latex let b:ycm_largefile=1
    autocmd FileType tex,plaintex,latex hi clear texItalStyle
    autocmd FileType tex,plaintex,latex iab ± $\pm$
    autocmd BufWritePre tex,plaintex,latex hi clear texItalStyle
augroup END

" Vim file autocommands
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal shortmess+=c
    autocmd FileType vim setlocal textwidth=0
    autocmd FileType vim setlocal wrap
augroup END

" Python file autocommands
augroup filetype_python
    autocmd!
    autocmd Filetype python nnoremap <buffer><silent> <leader>2 I#<space><esc>yyPVr=0r#lr<space>jyypVr=0r#lr<space>
    autocmd Filetype python setlocal nosmartindent
augroup END

" Colourscheme
set background=dark
colorscheme solarized

" Timeout
set timeoutlen=200
set ttimeoutlen=200

" Files to ignore in vim wild search
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pdf,*.root,*.o,*.un~

" Use British english when spellchecking
set spelllang=en_gb

" Toggle text wrapping with ]t and [t
nnoremap [os :setlocal tw=80
nnoremap ]os :setlocal tw=0

" Use matchit
packadd! matchit

" Plugins
" Vim-plug
call plug#begin()
" Pencil colorscheme
Plug 'reedes/vim-colors-pencil'
" NerdCommenter autocommenting
Plug 'scrooloose/nerdcommenter'
" NerdTree file explorer
Plug 'scrooloose/nerdtree'
" " Airline
" Plug 'vim-airline/vim-airline'
" Airline themes
Plug 'vim-airline/vim-airline-themes'
" Syntastic
Plug 'vim-syntastic/syntastic'
" YCM generator
Plug 'rdnetto/YCM-Generator', {'branch': 'stable'}
" Solarized for color_coded
Plug 'NigoroJr/color_coded-colorschemes'
" Fugitive
" Plug 'tpope/vim-fugitive'
" Gitgutter
Plug 'airblade/vim-gitgutter'
" Surround
Plug 'tpope/vim-surround'
" Abolish
Plug 'tpope/vim-abolish'
" Repeat for tpope plugins
Plug 'tpope/vim-repeat'
" Automatic bracket closing
Plug 'raimondi/delimitmate'
" Fuzzy file search
Plug 'ctrlpvim/ctrlp.vim'
" Undo visualization
Plug 'mbbill/undotree'
" Buffer closing without closing window (use :Bd)
Plug 'moll/vim-bbye'
" Autocomplete words from other tmux panes with <C-X><C-U>
Plug 'wellle/tmux-complete.vim'
" Snippet engine
Plug 'SirVer/ultisnips'
" Better incremental searching
Plug 'haya14busa/incsearch.vim'
" Easy aligning
Plug 'junegunn/vim-easy-align'
" 2-character version of f and t
Plug 'justinmk/vim-sneak'
" Mappings
Plug 'tpope/vim-unimpaired'
" More word objects
Plug 'wellle/targets.vim'
" Vim latex
Plug 'lervag/vimtex'
" Bullet points
Plug 'dkarter/bullets.vim'
" Hardmode (no hjkl, arrows, pgup/down)
Plug 'wikitopian/hardmode'
" Easy vim-tmux navigation
Plug 'christoomey/vim-tmux-navigator'
" Distraction-free writing environment
Plug 'junegunn/goyo.vim'
" Vim devicons
Plug 'ryanoasis/vim-devicons'
" Visual split
Plug 'wellle/visual-split.vim'
" Easy window resizing
Plug 'simeji/winresizer'
" Lighter status bar
Plug 'itchyny/lightline.vim'
" NERDtree syntax highlighting
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
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

" NERDcommenter settings
" Add spaces after comment delimiter by default
let g:NERDSpaceDelims = 1
" Use compact syntax for multiline comments
let g:NERDCompactSexyComs = 1
" Trim trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Open NERDTree with ctrl-n
noremap <silent> <leader>n :NERDTreeToggle<CR>

" Open undotree with \u
nnoremap <silent> <leader>u :UndotreeToggle<CR>

" Airline settings
set laststatus=2
set noshowmode
let g:lightline = {'colorscheme': 'solarized'}

" Toggle status 
function! ToggleStatus()
    if &laststatus
        set laststatus=0
        set showtabline=0
    else 
        set laststatus=2
        set showtabline=1
    endif
endfunction
nnoremap <silent> <leader>tt :call ToggleStatus()<CR>

" " Use powerline fonts
" let g:airline_powerline_fonts=1
" " Solarized colorscheme for airline
" let g:airline_theme = 'solarized'
" " Show buffers/tabs at top
" let g:airline#extensions#tabline#enabled=1
" " Show filename only in buffer/tab display
" let g:airline#extensions#tabline#fnamemod = ':t'

" YouCompleteMe settings
" Default extra conf location
let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/.ycm_extra_conf.py"
" Don't ask whether to use extra conf
let g:ycm_confirm_extra_conf = 0
" Turn off annoying extra window
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0

" Use FixIt tool with \f
noremap <leader>f :YcmCompleter FixIt<CR>

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
" Toggle active/passive mode with \st
nnoremap <leader>st :SyntasticToggleMode<CR>

" CtrlP settings
" Mappings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
noremap <c-b> :CtrlPBuffer<CR>
" Increase number of results shown in search
let g:ctrlp_match_window = 'results:20'
" Open multiple files in same window
let g:ctrlp_open_multiple_files = '1vjr'
" Set working directory to nearest ancestor containing .git
let g:ctrlp_working_path_mode = 'ra'
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

" Still autoindent with delimitmate
let delimitMate_expand_cr = 1
let delimirMate_expand_space = 1

" Sneak remappings
map + <Plug>Sneak_s
map - <Plug>Sneak_S
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" easy-align mappings
xmap ga <plug>(easyalign)
nmap ga <plug>(easyalign)
vmap <Enter> <Plug>(EasyAlign)

" Incsearch mappings
" Use incsearch instead of standard
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
" Turn off highlighting when cursor moves
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" Toggle rainbow parentheses (in style of Unimpaired)
map cop :RainbowParentheses!!<CR>

" Ultisnips settings
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsSnippetsDir="~/.vim/myUltiSnips"
let g:UltiSnipsSnippetDirectories = ['myUltiSnips']

" Filetypes to use Bullets.vim
let g:bullets_enabled_file_types = [
    \ 'markdown',
    \ 'text',
    \ 'gitcommit',
    \ 'scratch',
    \ 'tex'
     \]

" Devicons settings
" Pattern matches
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['\.sh\.e\d\+'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['\.sh\.o\d\+'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['\.tar\.gz'] = ''
" Exact filename matches
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['makefile'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.gitignore'] = ''
" Custom extensions
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['cut'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['param'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['o'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['log'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['root'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['pdf'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['tex'] = ''

" Open Goyo
nnoremap <silent> <leader>g :Goyo<CR>

" Colour modifications
function! s:highlight()
    hi VertSplit ctermfg=0 ctermbg=0
    hi EndOfBuffer cterm=bold ctermfg=0
    hi SignColumn ctermbg=8
    hi GitGutterAdd ctermbg=8 ctermfg=2
    hi GitGutterChange ctermbg=8 ctermfg=3
    hi GitGutterDelete ctermbg=8 ctermfg=1
    hi GitGutterChangeDelete ctermbg=8 ctermfg=1
    hi LineNr ctermbg=8 ctermfg=10 
endfunction
augroup my_highlights
    autocmd!
    autocmd ColorScheme * call s:highlight()
augroup end
call s:highlight()


