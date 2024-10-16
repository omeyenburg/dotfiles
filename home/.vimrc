" Vundle {{{
set nocompatible             " be iMproved, required
filetype off                 " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'L9'
Plugin 'FuzzyFinder'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-easymotion'
call vundle#end()            " required
filetype plugin indent on    " required

" }}}
" Options {{{

" set colorscheme
colorscheme test

" enable syntax highlighting
syntax on

" enable automatic folding
set foldmethod=marker

" disable mouse mode (except scrolling)
set mouse=

" mapped sequence wait time
set timeoutlen=1000

" show line numbers
set number

" relative line numbers
set relativenumber

" disable printing mode which is already visible in status line
set noshowmode

" highlight line of cursor
set cursorline

" enable git signs near line numbers
set signcolumn=no

" show a buffer headline when there are at least two tabs opened
set showtabline=1

" make sure terminal colors are enabled
set termguicolors=true

" don’t update screen during macro and script execution
set nolazyredraw

" decrease update time
set updatetime=250

" minimal number of screen lines to keep above and below the cursor
set scrolloff=8

" minimal number of screen columns either side of cursor if wrap is `false`
set sidescrolloff=8

" required to be 8 spaces
set tabstop=8

" number of spaces that a <Tab> counts for while performing editing operations
set softtabstop=4

" number of spaces to use for each step of (auto)indent
set shiftwidth=4

" use the appropriate number of spaces to insert a <Tab>
set expandtab

" line wrapping
set nowrap

" wrapped lines will continue visually indented
set nobreakindent

" adjust indentation based on control flow statements
set smartindent

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

" disable backups
set noswapfile
set nobackup
set nowritebackup

" }}}
" Keymaps {{{

" Disable command history
nnoremap q: <nop>
nnoremap <space>e :Ex<cr>

" }}}
