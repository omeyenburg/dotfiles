--[[
 NOTE: Colemak layout

Upper row:   /, w, e, b, g, /, p, u, y, /
Home row:    a, r, i, v, d, o, h, j, k, l
Lower row:   s, x, n, v, /, /, q, ., /, /
]]

-- Mappings to be disabled
-- { mode, key }
local disabled_mappings = {
    { 'x', 'Q' },
    { 'n', 'q:' }, -- Command history
}

-- Layout names
local layouts = {
    'Normal',
    'Colemak',
}

-- Simple mappings
-- { mode, key, action, description }
local simple_mappings = {
    {
        'n',
        '<Esc>',
        '<CMD>nohlsearch<CR>',
        'Clear search highlight',
    },
    {
        'n',
        '<leader>e',
        vim.cmd.Ex,
        'Goto explorer',
    },
    {
        'n',
        'J',
        'mzJ`z',
        'Join lines',
    },
    {
        'n',
        '<leader>~',
        '~h',
        'Static toggle case',
    },
    {
        'n',
        '<C-d>',
        '<C-d>zz',
        'Scroll down',
    },
    {
        'n',
        '<C-u>',
        '<C-u>zz',
        'Scroll up',
    },
    {
        'v',
        '<Tab>',
        '>gv',
        'Indent selection',
    },
    {
        'v',
        '<S-Tab>',
        '<gv',
        'Dedent selection',
    },
    {
        'n',
        '<Tab>',
        '>>',
        'Indent line',
    },
    {
        'n',
        '<S-Tab>',
        '<<',
        'Dedent line',
    },

    -- Escape symbols
    {
        'i',
        '\\tr',
        '⊤',
        'Symbol: true',
    },
    {
        'i',
        '\\fa',
        '⊥',
        'Symbol: false',
    },
    {
        'i',
        '\\no',
        '¬',
        'Symbol: not',
    },
    {
        'i',
        '\\an',
        '∧',
        'Symbol: and',
    },
    {
        'i',
        '\\or',
        '∨',
        'Symbol: or',
    },
    {
        'i',
        '\\fi',
        '⇒',
        'Symbol: forward implication',
    },
    {
        'i',
        '\\bi',
        '⇐',
        'Symbol: backward implication',
    },
    {
        'i',
        '\\eq',
        '⇔',
        'Symbol: equals',
    },
    {
        'i',
        '\\al',
        '∀',
        'Symbol: all',
    },
    {
        'i',
        '\\ex',
        '∃',
        'Symbol: exists',
    },
}

-- Mappings for each layout
-- { mode, keys, action, description }
local layout_mappings = {
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
        { 'n', 'c' },
        'nzzzv',
        'Search next occurence',
    },
    {
        'n',
        { 'N', 'C' },
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

    -- Mode switching keys
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

    -- Cutting keys
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

    -- Pasting keys
    {
        { 'n', 'x', 'v' },
        { 'p', 'l' },
        'p',
        'Paste after cursor',
    },
    {
        { 'n', 'x', 'v' },
        { 'P', 'L' },
        'P',
        'Paste before cursor',
    },
    {
        'x',
        { '<leader>p', '<leader>x' },
        '"_dP',
        'Paste and keep register',
    },

    -- Editing keys
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

    -- Others
    {
        'n',
        { 'q', 'm' },
        'q',
        'Toggle macro',
    },
}

-- Disable unwanted mappings
for _, mapping in pairs(disabled_mappings) do
    local modes = {}
    local lhs = mapping[2]

    if type(mapping[1]) == 'string' then
        modes = { mapping[1] }
    else
        modes = mapping[1]
    end

    for _, mode in pairs(modes) do
        local status, _ = pcall(vim.keymap.del, mode, lhs)

        if not status then
            vim.keymap.set(mode, lhs, '<nop>')
        end
    end
end

-- Apply simple mappings
for _, mapping in pairs(simple_mappings) do
    local modes = mapping[1]
    local key = mapping[2]
    local action = mapping[3]
    local desc = mapping[4]

    vim.keymap.set(modes, key, action, { noremap = true, silent = true, desc = desc })
end

-- Switch layout function; call with :Layout [layout]
local function switch_layout(layout)
    local index = nil
    for i, name in ipairs(layouts) do
        if name == layout then
            index = i
        else
            -- Disable mappings of other layout
            for _, mapping in pairs(layout_mappings) do
                local modes = {}
                local lhs = mapping[2][i]

                if type(mapping[1]) == 'string' then
                    modes = { mapping[1] }
                else
                    modes = mapping[1]
                end

                for _, mode in pairs(modes) do
                    pcall(vim.keymap.del, mode, lhs)
                    vim.keymap.set(mode, lhs, '<nop>', { noremap = true, silent = true, desc = '' })
                end
            end
        end
    end

    assert(index ~= nil, 'Invalid layout "' .. layout .. '"')
    vim.g.keyboard_layout = layout

    -- Apply new mappings
    for _, mapping in pairs(layout_mappings) do
        local modes = mapping[1]
        local key = mapping[2][index]
        local action = mapping[3]
        local desc = mapping[4]

        -- Remap the new key; not recursively (noremap)
        vim.keymap.set(modes, key, action, { noremap = true, silent = true, desc = desc })
    end
end

vim.api.nvim_create_user_command('Layout', function(opts)
    local layout = opts.args
    switch_layout(layout)
end, {
    nargs = 1,
    complete = function(_)
        return layouts
    end,
})

if vim.g.keyboard_layout == nil then
    vim.g.keyboard_layout = 'Normal'
end
switch_layout(vim.g.keyboard_layout)
