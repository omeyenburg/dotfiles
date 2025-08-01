----- General -----
-- If some icons are displayed incorrectly, you need to install a nerd font
-- e.g.: https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode
-- Apply the nerd font in your terminal settings.
-- In some terminals (e.g. iTerm2) you can set a different font for non-ascii characters.

-- Disable providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0

-- Check for vscode
if vim.env.VSCODE then
    vim.g.vscode = true
end

vim.opt.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim
vim.opt.mouse = '' -- Disable mouse mode (except scrolling)
vim.opt.timeoutlen = 1000 -- Mapped sequence wait time
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.cursorline = true -- Highlight line of cursor
vim.opt.inccommand = 'split' -- Live view of all substitutions
vim.opt.lazyredraw = false -- Don’t update screen during macro and script execution
vim.opt.list = true -- Highlight trailing whitespace and similar
vim.opt.listchars = 'tab:> ,trail:~,extends:»,precedes:«' -- Set the highlight symbols
vim.opt.scrolloff = 8 -- Minimal number of screen lines to keep above and below the cursor
vim.opt.showmode = false -- Disable printing mode which is already visible in status line
vim.opt.showtabline = 1 -- Show a buffer headline when there are at least two tabs opened
vim.opt.sidescrolloff = 8 -- Minimal number of screen columns either side of cursor if wrap is `false`
vim.opt.signcolumn = 'yes' -- Enable git signs near line numbers
vim.opt.termguicolors = true -- Make sure terminal colors are enabled
vim.opt.updatetime = 250 -- Decrease update time

----- Indentation Options -----
local tab_size = 4
vim.opt.tabstop = 8 -- Number of spaces that a <Tab> in the file counts for. Setting 'tabstop' to any other value than 8 can make your file appear wrong in many places.
vim.opt.softtabstop = tab_size -- Number of spaces that a <Tab> counts for while performing editing operations
vim.opt.shiftwidth = tab_size -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true -- Use the appropriate number of spaces to insert a <Tab>

vim.opt.wrap = false -- Line wrapping
vim.opt.breakindent = false -- Wrapped lines will continue visually indented
vim.opt.smartindent = true -- Adjust indentation based on control flow statements

-- FIX: Stop vim from messing up indentation on comments
vim.opt.cindent = true
vim.opt.cinkeys:remove '0#'

----- Search Options -----
vim.opt.ignorecase = true -- Case-insensitive searching
vim.opt.smartcase = true -- Case-sensitive searching if one or more capital letters are used in the search term
vim.opt.hlsearch = true -- Set highlight all search results

----- Split Options -----
vim.opt.splitright = true -- open vertical split windows on the right
vim.opt.splitbelow = true -- open horizontal split windows on the left

vim.api.nvim_command 'highlight WinSeparator guifg=#A9B2D5' -- Set color of split lines
vim.opt.laststatus = 3 -- Enables horizontal split lines by disabling status lines for each buffer (must run after plugins)

----- Undo Options -----
-- Save undo history
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true

-- Disable backups
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

----- Folding Options -----
-- Enable folding
-- vim.opt.foldmethod = 'marker'

-- Remove Folded section highlighting
vim.api.nvim_set_hl(0, 'Folded', { fg = 'NONE', bg = 'NONE', bold = true })

-- Remove FoldColumn highlighting
vim.api.nvim_set_hl(0, 'FoldColumn', { fg = 'NONE', bg = 'NONE', bold = true })

-- Remove fill chars on right side
vim.o.fillchars = 'fold: '

function _G.custom_fold_text()
    local line_count = vim.v.foldend - vim.v.foldstart + 1
    local first_line = vim.fn.getline(vim.v.foldstart)

    -- Remove leading '#', '-' and '/' characters and spaces
    first_line = first_line:gsub('^%s*"*#*-*/*%s*', '')

    -- Remove trailing '{' and spaces
    first_line = first_line:gsub('%s*{*%s*$', '')

    -- Truncate first line if it's too long
    if #first_line > 50 then
        first_line = first_line:sub(1, 50) .. '...'
    end

    -- Pad line count to align vertically (assuming max 4 digits)
    local padded_line_count = string.format('%4d', line_count)

    return string.format('> %s lines: %s', padded_line_count, first_line)
end

-- Set the custom fold text
vim.opt.foldtext = 'v:lua.custom_fold_text()'

----- Netrw Options -----
-- i    -> Cycle list style
-- s    -> Cycle sorting
-- a    -> Cycle between: all files, visible files, hidden files
-- I    -> Toggle header
-- C-^  -> Enter last buffer (alternate file)
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

----- Custom Commands -----
-- Alias for wq
vim.api.nvim_create_user_command('Wq', ':wq', {})
vim.api.nvim_create_user_command('WQ', ':wq', {})
vim.api.nvim_create_user_command('W', ':w', {})
