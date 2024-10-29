-- General {{{ ---------------------------------------------

-- Disable providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0

-- Check for vscode
if vim.env.VSCODE then
    vim.g.vscode = true
end

-- Sync clipboard between OS and Neovim
vim.opt.clipboard = 'unnamedplus'

-- Disable mouse mode (except scrolling)
vim.opt.mouse = ''

-- Mapped sequence wait time
vim.opt.timeoutlen = 1000

-- Enable folding
vim.opt.foldmethod = 'marker'

-- }}}
-- Appearance Options {{{ ----------------------------------

-- If some icons are displayed incorrectly, you need to install a nerd font
-- e.g.: https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode
-- Apply the nerd font in your terminal settings.
-- In some terminals (e.g. iTerm2) you can set a different font for non-ascii characters.

vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.showmode = false -- Disable printing mode which is already visible in status line
vim.opt.cursorline = true -- Highlight line of cursor
vim.opt.inccommand = 'split' -- Live view of all substitutions
vim.opt.signcolumn = 'yes' -- Enable git signs near line numbers
vim.opt.showtabline = 1 -- Show a buffer headline when there are at least two tabs opened
vim.opt.termguicolors = true -- Make sure terminal colors are enabled
vim.opt.lazyredraw = false -- Don’t update screen during macro and script execution
vim.opt.updatetime = 250 -- Decrease update time
vim.opt.scrolloff = 8 -- Minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 8 -- Minimal number of screen columns either side of cursor if wrap is `false`
vim.opt.list = true -- Highlight trailing whitespace and similar

-- Example listchars: set listchars=eol:~,tab:>.,trail:~,extends:>,precedes:<,space:_
vim.opt.listchars = "tab:> ,trail:~,extends:>,precedes:<" -- Set the highlight symbols

-- }}}
-- Indentation Options {{{ ---------------------------------

local tab_size = 4
vim.opt.tabstop = 8 -- Number of spaces that a <Tab> in the file counts for. Setting 'tabstop' to any other value than 8 can make your file appear wrong in many places.
vim.opt.softtabstop = tab_size -- Number of spaces that a <Tab> counts for while performing editing operations
vim.opt.shiftwidth = tab_size -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true -- Use the appropriate number of spaces to insert a <Tab>

vim.opt.wrap = false -- Line wrapping
vim.opt.breakindent = false -- Wrapped lines will continue visually indented
vim.opt.smartindent = true -- Adjust indentation based on control flow statements

-- }}}
-- Search Options {{{ --------------------------------------

vim.opt.ignorecase = true -- Case-insensitive searching
vim.opt.smartcase = true -- Case-sensitive searching if one or more capital letters are used in the search term
vim.opt.hlsearch = true -- Set highlight all search results

-- }}}
-- Split Options {{{ ---------------------------------------

-- C-w + v  -> Vertical split
-- C-w + s  -> Vertical split
-- C-w + w  -> Switch window
-- C-w + x  -> Swap windows
-- C-w + q  -> Quit window
-- C-w + o  -> Quit all other windows

vim.opt.splitright = true -- open vertical split windows on the right
vim.opt.splitbelow = true -- open horizontal split windows on the left

vim.api.nvim_command 'highlight WinSeparator guifg=#A9B2D5' -- Set color of split lines
vim.opt.laststatus = 3 -- Enables horizontal split lines by disabling status lines for each buffer (must run after plugins)

-- }}}
-- Undo Options {{{ ----------------------------------------

-- Save undo history
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true

-- Disable backups
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- }}}
-- File Explorer Options (Netrw) {{{ -----------------------

-- i    -> Cycle list style
-- s    -> Cycle sorting
-- a    -> Cycle between: all files, visible files, hidden files
-- I    -> Toggle header
-- C-^  -> Enter last buffer
-- qf   -> Get information about file or directory
-- x    -> Open file using default application
-- X    -> Execute file

-- Hide files using regex
local hide_files = { '../', './', '.git', '__pycache__', '.pytest_cache', '.DS_Store' }
vim.g.netrw_list_hide = string.gsub(table.concat(hide_files, ','), '[.]', '\\.')
vim.g.netrw_hide = 1

-- Customize style
vim.g.netrw_liststyle = 4 -- default: 0; file tree: 3
vim.g.netrw_banner = 0 -- Disable banner
vim.g.netrw_winsize = 25 -- Sets explorer width/height when using :Vex or :Hex

-- }}}
