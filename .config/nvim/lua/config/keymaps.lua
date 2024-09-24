-- Mappings to be disabled
-- { mode, key }
local mapping_disable = {
    { 'x', 'Q' },
}

-- Layout names
local layouts = {
    'Normal',
    'Colemak',
}

-- Mappings for each layout
-- { mode, keys, action, description }
-- Upper row:   /, w, e, b, g, /, n, u, /, /
-- Home row:    a, r, i, v, d, o, h, j, k, l
-- Lower row:   y, p, x, v, /, /, q, ., /, /
local mapping = {
    -- Movement keys
    {
        { 'n', 'x', 'o', 'v' },
        { 'h', 'n' },
        'h',
        'Left',
    },
    {
        { 'n', 'x', 'o', 'v' },
        { 'j', 'e' },
        'j',
        'Down',
    },
    {
        { 'n', 'x', 'o', 'v' },
        { 'k', 'i' },
        'k',
        'Up',
    },
    {
        { 'n', 'x', 'o', 'v' },
        { 'l', 'o' },
        'l',
        'Right',
    },
    {
        { 'n', 'x', 'o', 'v' },
        { 'e', 'f' },
        'e',
        'Next end of word',
    },
    {
        { 'n', 'x', 'o', 'v' },
        { 'E', 'F' },
        'E',
        'Next end of WORD',
    },
    {
        { 'n', 'x', 'o', 'v' },
        { 'b', 'p' },
        'b',
        'Last word',
    },
    {
        { 'n', 'x', 'o', 'v' },
        { 'B', 'P' },
        'B',
        'Last WORD ',
    },
    {
        'n',
        'n',
        'l',
        'Search forward',
    },
    {
        'n',
        'N',
        'L',
        'Search backward',
    },

    -- Edit keys
    {
        { 'n', 'x', 'o', 'v' },
        { 'i', 's' },
        'i',
        'Insert before cursor',
    },
    {
        { 'n', 'x', 'o', 'v' },
        { 'I', 'S' },
        'I',
        'Insert at line start',
    },
    {
        'n',
        { 'o', 'h' },
        'o',
        'Insert line below',
    },
    {
        'n',
        { 'O', 'H' },
        'O',
        'Insert line above',
    },
    {
        { 'n', 'x', 'o', 'v' },
        { 's', 'z' },
        's',
        'cut and insert',
    },
    {
        { 'n', 'x', 'o', 'v' },
        { 'S', 'Z' },
        'S',
        'cut line and insert',
    },
    {
        { 'n', 'x', 'o', 'v' },
        { 'x', 'c' },
        'x',
        'cut',
    },
    {
        { 'n', 'x', 'o', 'v' },
        { 'X', 'C' },
        'X',
        'cut',
    },
    {
        { 'n', 'x', 'v' },
        { 'p', 'x' },
        'p',
        'Paste after cursor',
    },
    {
        { 'n', 'x', 'v' },
        { 'P', 'X' },
        'P',
        'Paste before cursor',
    },
    {
        'x',
        { '<leader>p', '<leader>x' },
        '"_dP',
        'Paste and keep register',
    },
    {
        'v',
        { 'J', 'E' },
        ":m '>+1<CR>gv=gv",
        'Shift selection done',
    },
    {
        'v',
        { 'K', 'I' },
        ":m '<-2<CR>gv=gv",
        'Shift selection up',
    },

    {
        'n',
        { 'n', 'l' },
        'nzzzv',
        'Search next occurence',
    },
    {
        'n',
        { 'N', 'L' },
        'Nzzzv',
        'Search previous occurence',
    },
    {
        'n',
        { '<C-h>', '<C-n>' },
        '<C-w><C-h>',
        'Move focus to the left window',
    },
    {
        'n',
        { '<C-l>', '<C-o>' },
        '<C-w><C-l>',
        'Move focus to the right window',
    },
    {
        'n',
        { '<C-j>', '<C-e>' },
        '<C-w><C-j>',
        'Move focus to the lower window',
    },
    {
        'n',
        { '<C-k>', '<C-i>' },
        '<C-w><C-k>',
        'Move focus to the upper window',
    },
    {
        'n',
        { '<leader>o', '<leader>h' },
        'o<Esc>k',
        'Create line below',
    },
    {
        'n',
        { '<leader>O', '<leader>H' },
        'O<Esc>j',
        'Create line above',
    },
    {
        'n',
        { '<leader>e', '<leader>e' },
        vim.cmd.Ex,
        'Goto explorer',
    },
    {
        'n',
        { 'J', 'J' },
        'mzJ`z',
        'Join lines',
    },
    {
        'n',
        { '<leader>~', '<leader>~' },
        '~h',
        'Static toggle case',
    },
    {
        'n',
        { '<C-d>', '<C-d>' },
        '<C-d>zz',
        'Scroll down',
    },
    {
        'n',
        { '<C-u>', '<C-u>' },
        '<C-u>zz',
        'Scroll up',
    },
    {
        'v',
        { '<Tab>', '<Tab>' },
        '>gv',
        'Indent selection',
    },
    {
        'v',
        { '<S-Tab>', '<S-Tab>' },
        '<gv',
        'Dedent selection',
    },

    -- Others
    {
        'n',
        { 'q', 'm' },
        'q',
        'Toggle macro',
    },
}

-- Some default keymaps to remember in normal mode
--- C-^         open last file
--- [number] >> indent this lines and the following lines
--- [number] << dedent this lines and the following lines

-- Some default keymaps to remember in visual mode
--- [number] >  indent selection by number of tabs
--- [number] <  dedent selection by number of tabs

------------------------------
-- Keymap options
------------------------------

-- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' }) -- TODO: CONFLICT
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
-- : This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<nop>')
-- vim.keymap.set('n', '<right>', '<nop>')
-- vim.keymap.set('n', '<up>', '<nop>')
-- vim.keymap.set('n', '<down>', '<nop>')
--
-- vim.keymap.set('i', '<left>', '<nop>')
-- vim.keymap.set('i', '<right>', '<nop>')
-- vim.keymap.set('i', '<up>', '<nop>')
-- vim.keymap.set('i', '<down>', '<nop>')

-- see https://stackoverflow.com/a/16136133/6064933
-- keymap.set("n", "<space>o", "printf('m`%so<ESC>``', v:count1)", {
--   expr = true,
--   desc = "insert line below",
-- })
--
-- keymap.set("n", "<space>O", "printf('m`%sO<ESC>``', v:count1)", {
--   expr = true,
--   desc = "insert line above",
-- })

-- -- Disable Q in visual mode
-- vim.keymap.set('x', 'Q', '<nop>')
--
-- -- Enter file explorer using <Space>+"e"
-- vim.keymap.set('n', '<leader>e', vim.cmd.Ex, { desc = 'Goto [E]xplorer' })
-- -- Prevent cursor from moving when deleting trailing "\n"
-- vim.keymap.set('n', 'J', 'mzJ`z')
-- -- Use <Space>+"~" for case toggle without moving
-- vim.keymap.set('n', '<leader>~', '~h')
-- -- Keep cursor centered when half page jumping
-- vim.keymap.set('n', '<C-d>', '<C-d>zz')
-- vim.keymap.set('n', '<C-u>', '<C-u>zz')
-- -- Tab indentation in visual mode
-- vim.keymap.set('v', '<Tab>', '>gv', { desc = 'Indent selection' })
-- vim.keymap.set('v', '<S-Tab>', '<gv', { desc = 'Dedent selection' })
--
-- -- TODO: COLEMAK
--
-- -- Move selected content with "J" and "K"
-- vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
-- vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
-- -- Replace all occurencies of the current word using <Space>+"s"
-- vim.keymap.set('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>')
-- -- Keep clipboard when pasting only with <Space>+"p" in visual mode
-- vim.keymap.set('x', '<leader>p', '"_dP')
-- -- Keep cursor centered when cycling through options
-- vim.keymap.set('n', 'n', 'nzzzv')
-- vim.keymap.set('n', 'N', 'Nzzzv')
-- -- Keybinds to make split navigation easier.
-- --  See `:help wincmd` for a list of all window commands
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- -- New line similar to "o" and "O" but without moving cursor
-- vim.keymap.set('n', '<leader>o', 'o<Esc>k')
-- vim.keymap.set('n', '<leader>O', 'O<Esc>j')
-- -- Quick fix navigation
-- vim.keymap.set('n', '<C-k', '<cmd>cnext<CR>zz')
-- vim.keymap.set('n', '<C-j', '<cmd>cprev<CR>zz')
-- vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
-- vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

local colemak = {
    -- Movement keys
    { { 'n', 'x', 'o', 'v' }, 'h', 'n' }, -- Map left to n
    { { 'n', 'x', 'o', 'v' }, 'j', 'e' }, -- Map down to e
    { { 'n', 'x', 'o', 'v' }, 'k', 'i' }, -- Map up to i
    { { 'n', 'x', 'o', 'v' }, 'l', 'o' }, -- Map right to o

    { { 'n', 'x', 'o', 'v' }, 'e', 'f' }, -- Map end of word to f
    { { 'n', 'x', 'o', 'v' }, 'E', 'F' }, -- Map end of WORD (punctuation) to F
    { { 'n', 'x', 'o', 'v' }, 'b', 'p' }, -- Map previous word to p
    { { 'n', 'x', 'o', 'v' }, 'B', 'P' }, -- Map previous WORD (punctuation) to P

    { 'n', 'n', 'l' }, -- Map find next to l
    { 'n', 'N', 'L' }, -- Map find previous to L

    -- Edit keys
    { { 'n', 'x', 'o', 'v' }, 'i', 's' }, -- Map insert to s
    { { 'n', 'x', 'o', 'v' }, 'I', 'S' }, -- Map beginning insert to S
    { 'n', 'o', 'h' }, -- Map new line below to h
    { 'n', 'O', 'H' }, -- Map new line above to H

    { { 'n', 'x', 'o', 'v' }, 's', 'z' }, -- Map cut and insert to z
    { { 'n', 'x', 'o', 'v' }, 'S', 'Z' }, -- Map cut line and insert to Z
    { { 'n', 'x', 'o', 'v' }, 'x', 'c' }, -- Map cut to c
    { { 'n', 'x', 'o', 'v' }, 'X', 'C' }, -- Map cut to C

    { 'n', 'p', 'x' }, -- Map paste to x
    { 'n', 'P', 'X' }, -- Map unchanged paste to X

    { 'v', 'J', 'E', 'move_down' }, -- Map move selection down to E
    { 'v', 'K', 'I', 'move_up' }, -- Map move selection up to I

    -- Others
    { 'n', 'q', 'm' }, -- Map macro to m
}

local function apply_colemak()
    -- Iterate through the remap table using ipairs
    for _, mapping in ipairs(remap) do
        local mode = mapping[1]
        local old = mapping[2]

        -- Unmap the old key
        vim.keymap.set(mode, old, '<nop>', { noremap = true, silent = true, desc = 'Unset' })
    end

    -- Iterate through the remap table using ipairs
    for _, mapping in ipairs(remap) do
        local mode = mapping[1]
        local old = mapping[2]
        local new = mapping[3]
        local custom = mapping[4] or false

        if custom then
            old = custom_map[custom]
        end

        -- Remap the new key; not recursively (noremap)
        vim.print(vim.keymap.set(mode, new, old, { noremap = true, silent = true }))
    end
end

-- Create a command called SetLayout with completable arguments
vim.api.nvim_create_user_command(
    'SetLayout', -- Command name
    function(opts) -- Function to execute
        local layout = opts.args -- Get the argument
        print('Layout set to: ' .. layout) -- Print the selected layout
        apply_colemak()
    end,
    {
        nargs = 1, -- Expect one argument
        complete = function(_)
            return { 'Colemak', 'Qwerty' } -- Return the choices
        end, -- Use the completion function
    }
)
