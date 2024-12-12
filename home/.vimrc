" __     ___
" \ \   / (_)_ __ ___
"  \ \ / /| | '_ ` _ \
"   \ V / | | | | | | |
"    \_/  |_|_| |_| |_|
"

" Vundle {{{

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
if exists("*vundle#begin")
    call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'L9'
    Plugin 'FuzzyFinder'
    Plugin 'tpope/vim-fugitive'
    Plugin 'Lokaltog/vim-easymotion'
    call vundle#end()
endif

" }}}
" Appearance {{{

" select colorscheme
colorscheme slate

" enable syntax highlighting
syntax on

" disable background color
highlight Normal ctermbg=NONE

" highlight visual selection
highlight Visual ctermbg=238 ctermfg=NONE

" highlight hovering brackets
highlight MatchParen ctermbg=25

" highlight folds
highlight Folded ctermbg=NONE cterm=bold

" }}}
" Options {{{

" enable filetype detection
filetype plugin indent on

" be iMproved, required
set nocompatible

" show line numbers
set number

" relative line numbers
set relativenumber

" allow buffer switching, e.g. with :bn, without saving
set hidden

" highlight line of cursor
set cursorline

" enable git signs near line numbers
set signcolumn=no

" show a buffer headline when there are at least two tabs opened
set showtabline=1

" don’t update screen during macro and script execution
set nolazyredraw

" mapped sequence wait time
set timeoutlen=1000

" decrease update time
set updatetime=250

" minimal number of screen lines to keep above and below the cursor
set scrolloff=8

" minimal number of screen columns either side of cursor if wrap is `false`
set sidescrolloff=8

" disable mouse mode (except scrolling)
set mouse=

" required to be 8 spaces
set tabstop=8

" number of spaces that a <Tab> counts for while performing editing operations
set softtabstop=2

" number of spaces to use for each step of (auto)indent
set shiftwidth=2

" use the appropriate number of spaces to insert a <Tab>
set expandtab

" enable automatic indentation
set autoindent

" keep indentation when pressing '#'
set indentkeys-=0#

" wrapped lines will continue visually indented
set nobreakindent

" line wrapping
set nowrap

" case-insensitive searching
set ignorecase

" case-sensitive searching if one or more capital letters are used in the search term
set smartcase

" set highlight all search results
set hlsearch

" open vertical split windows on the right
set splitright

" open horizontal split windows on the left
set splitbelow

" enables horizontal split lines by disabling status lines for each buffer (must run after plugins)
set laststatus=3

" enable automatic folding
set foldmethod=marker

" disable backups
set noswapfile
set nobackup
set nowritebackup

" disable netrw banner
let g:netrw_banner=0

" }}}
" Keymaps {{{

" disable command history
nnoremap q: <nop>

" open netrw
nnoremap <space>e :Ex<cr>

" }}}
" Autocommands {{{

" Automatically place the cursor on the file in netrw
autocmd FileType netrw call s:netrw_start_on_file()

function! s:netrw_start_on_file()
  " Skip the first two entries "../" and "./"
  if getline(1) =~# '^../$' && getline(2) =~# '^./$'
    exe "normal! 2j"
  endif
endfunction

" }}}
