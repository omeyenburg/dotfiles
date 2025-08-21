-- Floating terminal
local state = {
    floating = {
        buf = -1,
        win = -1,
    },
    preview = {
        enabled = false,
        cursorline = false,
        number = false,
        relativenumber = false,
        visual_bg = "",
        cursor_bg = "",
    }
}

local function create_floating_window(opts)
    opts = opts or {}
    local width = opts.width or math.floor(vim.o.columns * 0.8)
    local height = opts.height or math.floor(vim.o.lines * 0.8)

    -- Calculate the position to center the window
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    -- Create a buffer
    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
    end

    -- Define window configuration
    local win_config = {
        relative = 'editor',
        width = width,
        height = height,
        col = col,
        row = row,
        style = 'minimal',
        border = 'rounded',
    }

    -- Create the floating window
    local win = vim.api.nvim_open_win(buf, true, win_config)

    return { buf = buf, win = win }
end

local function toggle_terminal()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
        state.floating = create_floating_window { buf = state.floating.buf }
        if vim.bo[state.floating.buf].buftype ~= 'terminal' then
            vim.cmd.terminal()
        end
        vim.api.nvim_buf_set_name(0, '[Terminal]')
    else
        vim.api.nvim_win_hide(state.floating.win)
    end
end

-- Preview mode
local ffi = require("ffi")

ffi.cdef([[
void ui_busy_start(void);
void ui_busy_stop(void);
]])

local function toggle_preview_mode()
    if not state.preview.enabled then
        ffi.C.ui_busy_start()

        state.preview.cursorline = vim.wo.cursorline
        state.preview.number = vim.wo.number
        state.preview.relativenumber = vim.wo.relativenumber
        vim.wo.cursorline = false
        vim.wo.number = false
        vim.wo.relativenumber = false

        state.preview.visual_bg = vim.api.nvim_get_hl(0, { name = "Visual" }).bg
        vim.api.nvim_set_hl(0, "Visual", { fg = "NONE" })

        Snacks.indent.disable()
    else
        ffi.C.ui_busy_stop()

        vim.wo.cursorline = state.preview.cursorline
        vim.wo.number = state.preview.number
        vim.wo.relativenumber = state.preview.relativenumber

        vim.api.nvim_set_hl(0, "Visual", { bg = state.preview.visual_bg })

        Snacks.indent.enable()
    end

    state.preview.enabled = not state.preview.enabled
end

-- Tree sitter syntax tree
local function toggle_inspect_tree()
    if vim.fn.bufexists 'Syntax tree' ~= 0 then
        vim.api.nvim_buf_delete(vim.fn.bufnr 'Syntax tree', {})
    else
        local s, _ = pcall(function()
            vim.cmd 'InspectTree'
        end)
        if s then
            vim.api.nvim_buf_set_name(0, 'Syntax tree')
            vim.wo.relativenumber = false
            vim.wo.number = false
        else
            print 'File does not support syntax tree.'
        end
    end
end

local function keymap(mode, lhs, rhs, desc, opts)
    if opts then
        opts['desc'] = desc
    else
        opts = { desc = desc }
    end

    opts['silent'] = opts['silent'] or true
    opts['noremap'] = opts['noremap'] or true

    vim.keymap.set(mode, lhs, rhs, opts)
end

-- Escape in terminal
keymap('t', '<Esc>', '<C-\\><C-n>', 'Terminal normal mode')

-- Remove search highlight with escape
keymap('n', '<Esc>', '<CMD>nohlsearch<CR>', 'Clear search highlight')

-- Toggles
keymap('n', '<leader>tt', toggle_terminal, 'Toggle terminal')
keymap('n', '<leader>tp', toggle_preview_mode, 'Toggle preview mode')
keymap('n', '<leader>tr', toggle_inspect_tree, 'Toggle inspect tree')
keymap('n', '<leader>e', vim.cmd.Ex, 'Open explorer')

-- Repeat last command
keymap('n', '+', ':@:<CR>', 'Repeat last command')

--- Navigation ---

-- Centered half page scrolling
keymap('n', '<C-d>', '<C-d>zz', 'Scroll down')
keymap('n', '<C-u>', '<C-u>zz', 'Scroll up')

-- Mappings to make life easier when wrap is set
-- keymap('n', 'j', 'gj', 'Down')
-- keymap('n', 'k', 'gk', 'Up')

-- Shortcuts for switching between windows
keymap('n', '<C-h>', '<C-w><C-h>', 'Move focus to the left window')
keymap('n', '<C-j>', '<C-w><C-j>', 'Move focus to the lower window')
keymap('n', '<C-k>', '<C-w><C-k>', 'Move focus to the upper window')
keymap('n', '<C-l>', '<C-w><C-l>', 'Move focus to the right window')

-- Centered searching
keymap('n', 'N', 'Nzzzv', 'Search previous occurence')
keymap('n', 'n', 'nzzzv', 'Search next occurence')

-- Cycle through buffers
keymap('n', '<C-S-n>', ':bn<CR>', 'Next buffer')
keymap('n', '<C-S-p>', ':bp<CR>', 'Previous buffer')

--- Editing ---

-- Tab indentation
keymap('n', '<S-Tab>', '<<', 'Dedent line')
keymap('n', '<Tab>', '>>', 'Indent line')
keymap('v', '<S-Tab>', '<gv', 'Dedent selection')
keymap('v', '<Tab>', '>gv', 'Indent selection')

-- Create lines in normal mode
keymap('n', '<leader>O', 'O<Esc>', 'Create line above')
keymap('n', '<leader>o', 'o<Esc>', 'Create line below')

-- Join lines and keep cursor position
keymap('n', 'J', 'mzJ`z', 'Join lines')

-- Move selected lines
keymap('v', 'J', ":m '>+1<CR>gv=gv", 'Shift selection down')
keymap('v', 'K', ":m '<-2<CR>gv=gv", 'Shift selection up')

-- Paste and keep register
keymap('x', '<leader>p', '"_dP', 'Paste and keep register')

-- Disable unused keymaps
vim.keymap.set('x', 'Q', '<nop>')
vim.keymap.set({ 'n', 'x' }, 'q:', '<nop>')
