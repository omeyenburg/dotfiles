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
                '<leader>xX',
                '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
                desc = 'Buffer diagnostics (Trouble)',
            },
            {
                '<leader>xs',
                '<cmd>Trouble symbols toggle focus=false<cr>',
                desc = 'Symbols (Trouble)',
            },
            {
                '<leader>xl',
                '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
                desc = 'Lsp definitions/References (Trouble)',
            },
            {
                '<leader>xL',
                '<cmd>Trouble loclist toggle<cr>',
                desc = 'Location list (Trouble)',
            },
            {
                '<leader>xq',
                '<cmd>Trouble qflist toggle<cr>',
                desc = 'Quickfix list (Trouble)',
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
            require('mini.ai').setup { n_lines = 100 }

            -- Add/delete/replace surroundings (brackets, quotes, etc.)
            -- saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
            -- sd'   - [S]urround [D]elete [']quotes
            -- sr)'  - [S]urround [R]eplace [)] [']
            require('mini.surround').setup {
                mappings = {
                    add = '<leader>sa', -- Add surrounding in Normal and Visual modes
                    delete = '<leader>sd', -- Delete surrounding
                    find = '<leader>sf', -- Find surrounding (to the right)
                    find_left = '<leader>sF', -- Find surrounding (to the left)
                    highlight = '<leader>sh', -- Highlight surrounding
                    replace = '<leader>sr', -- Replace surrounding
                    update_n_lines = '<leader>sn', -- Update `n_lines`

                    suffix_last = 'l', -- Suffix to search with "prev" method
                    suffix_next = 'n', -- Suffix to search with "next" method
                },
            }
        end,
    },
}
