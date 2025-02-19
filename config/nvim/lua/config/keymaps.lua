-- Floating terminal
local state = {
    floating = {
        buf = -1,
        win = -1,
    },
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
        style = 'minimal', -- No borders or extra UI elements
        border = 'rounded',
    }

    -- Create the floating window
    local win = vim.api.nvim_open_win(buf, true, win_config)

    return { buf = buf, win = win }
end

local toggle_terminal = function()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
        state.floating = create_floating_window { buf = state.floating.buf }
        if vim.bo[state.floating.buf].buftype ~= 'terminal' then
            vim.cmd.terminal()
        end
        vim.api.nvim_buf_set_name(0, "[Terminal]")
    else
        vim.api.nvim_win_hide(state.floating.win)
    end
end

-- Toggle inspect tree
local toggle_inspect_tree = function()
    if vim.fn.bufexists("Syntax tree") ~= 0 then
        vim.api.nvim_buf_delete(vim.fn.bufnr("Syntax tree"), {})
    else
        local s, _ = pcall(function() vim.cmd 'InspectTree' end)
        if s then
            vim.api.nvim_buf_set_name(0, "Syntax tree")
            vim.wo.relativenumber=false
            vim.wo.number=false
        else
            print("File does not support syntax tree.")
        end
    end
end

-- Centered half page scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true, desc = 'Scroll down' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true, desc = 'Scroll up' })

-- Shortcuts for switching between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { noremap = true, silent = true, desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { noremap = true, silent = true, desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { noremap = true, silent = true, desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { noremap = true, silent = true, desc = 'Move focus to the right window' })

-- Remove search highlight with escape
vim.keymap.set('n', '<Esc>', '<CMD>nohlsearch<CR>', { noremap = true, silent = true, desc = 'Clear search highlight' })

-- Quick indentation
vim.keymap.set('n', '<S-Tab>', '<<', { noremap = true, silent = true, desc = 'Dedent line' })
vim.keymap.set('n', '<Tab>', '>>', { noremap = true, silent = true, desc = 'Indent line' })
vim.keymap.set('v', '<S-Tab>', '<gv', { noremap = true, silent = true, desc = 'Dedent selection' })
vim.keymap.set('v', '<Tab>', '>gv', { noremap = true, silent = true, desc = 'Indent selection' })

-- Open Netrw
vim.keymap.set('n', '<leader>e', vim.cmd.Ex, { noremap = true, silent = true, desc = 'Open explorer' })

-- Create lines but stay in normal mode
vim.keymap.set('n', '<leader>O', 'O<Esc>j', { noremap = true, silent = true, desc = 'Create line above' })
vim.keymap.set('n', '<leader>o', 'o<Esc>k', { noremap = true, silent = true, desc = 'Create line below' })

-- Join lines and keep cursor position
vim.keymap.set('n', 'J', 'mzJ`z', { noremap = true, silent = true, desc = 'Join lines' })

-- Centered searching
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true, silent = true, desc = 'Search previous occurence' })
vim.keymap.set('n', 'n', 'nzzzv', { noremap = true, silent = true, desc = 'Search next occurence' })

-- Escape in terminal
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true, desc = 'Terminal normal mode' })

-- Move selected lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = 'Shift selection down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = 'Shift selection up' })

-- Paste but keep register
vim.keymap.set('x', '<leader>p', '"_dP', { noremap = true, silent = true, desc = 'Paste and keep register' })

-- Cycle through buffers
-- Cycle through harpoon files with <C-n> / <C-p>
vim.keymap.set('n', '<C-S-n>', ':bnext<CR>', { noremap = true, silent = true, desc = 'Paste and keep register' })
vim.keymap.set('n', '<C-S-p>', ':bprev<CR>', { noremap = true, silent = true, desc = 'Paste and keep register' })

-- Toggle terminal
vim.keymap.set('n', '<leader>tt', toggle_terminal, { noremap = true, silent = true, desc = 'Toggle terminal' })

-- Toggle tree-sitter inspect tree
vim.keymap.set('n', '<leader>tr', toggle_inspect_tree, { noremap = true, silent = true, desc = 'Toggle inspect tree' })

-- Disable unused keymaps
vim.keymap.set('x', 'Q', '<nop>')
vim.keymap.set({ 'n', 'x' }, 'q:', '<nop>')
