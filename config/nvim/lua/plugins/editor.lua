--[[

# Undotree
https://github.com/mbbill/undotree

# Persistence
Automatically saves sessions
https://github.com/folke/persistence.nvim

# Better Messages
Shows messages in a separate window
https://github.com/ariel-frischer/bmessages.nvim

# Trouble
View diagnosics and quickfixes
https://github.com/folke/trouble.nvim

# Mini
Collection of various small independent plugins/modules
https://github.com/echasnovski/mini.nvim

--]]

return {
    { -- Undotree
        'mbbill/undotree',
        lazy = true,
        cmd = 'UndotreeToggle',
        keys = {
            { '<leader>u', '<cmd>UndotreeToggle<cr>', desc = 'Toggle Undo Tree', mode = 'n' },
        },
    },

    { -- Keep cursor position
        'folke/persistence.nvim',
        lazy = true,
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {},
    },

    { -- Messages window
        'ariel-frischer/bmessages.nvim',
        lazy = true,
        cmd = 'Bmessages',
        keys = {
            { '<leader>m', '<cmd>Bmessages<cr>', mode = 'n', desc = 'Toggle Messages' },
        },
        opts = {
            keep_focus = true, -- Don't focus the bmessages window after opening.
            buffer_name = 'bmessages_buffer',
        },
    },

    { -- Diagnostics
        'folke/trouble.nvim',
        lazy = true,
        opts = {},
        cmd = 'Trouble',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        keys = {
            {
                '<leader>xx',
                '<cmd>Trouble diagnostics toggle<cr>',
                desc = 'Diagnostics (Trouble)',
            },
            {
                '<leader>xx',
                '<cmd>trouble diagnostics toggle filter.buf=0<cr>',
                desc = 'buffer diagnostics (trouble)',
            },
            {
                '<leader>cs',
                '<cmd>trouble symbols toggle focus=false<cr>',
                desc = 'symbols (trouble)',
            },
            {
                '<leader>cl',
                '<cmd>trouble lsp toggle focus=false win.position=right<cr>',
                desc = 'lsp definitions / references / ... (trouble)',
            },
            {
                '<leader>xl',
                '<cmd>trouble loclist toggle<cr>',
                desc = 'location list (trouble)',
            },
            {
                '<leader>xq',
                '<cmd>trouble qflist toggle<cr>',
                desc = 'quickfix list (trouble)',
            },
        },
    },

    {
        'echasnovski/mini.nvim',
        lazy = true,
        event = 'VeryLazy',
        config = function()
            -- Better Around/Inside textobjects
            --  - va)  - [V]isually select [A]round [)]paren
            --  - yinq - [Y]ank [I]nside [N]ext [']quote
            --  - ci'  - [C]hange [I]nside [']quote
            require('mini.ai').setup { n_lines = 500 }

            -- Add/delete/replace surroundings (brackets, quotes, etc.)
            -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
            -- - sd'   - [S]urround [D]elete [']quotes
            -- - sr)'  - [S]urround [R]eplace [)] [']
            require('mini.surround').setup()
        end,
    },
}
