--[[

# Trouble
View diagnosics and quickfixes

https://github.com/folke/trouble.nvim

--]]

return {
    {
        'folke/trouble.nvim',
        lazy = true,
        cmd = { 'Trouble', 'TroubleToggle' },
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {},
        keys = {
            { '<leader>xx', '<cmd>TroubleToggle document_diagnostics<CR>', desc = 'Document diagnostics', mode = 'n' },
            { '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<CR>', desc = 'Workspace diagnostics', mode = 'n' },
            { '<leader>xl', '<cmd>TroubleToggle loclist<CR>', desc = 'Location list', mode = 'n' },
            { '<leader>xq', '<cmd>TroubleToggle quickfix<CR>', desc = 'Quickfix list', mode = 'n' },
            {
                '<leader>xn',
                function()
                    require('trouble').next { skip_groups = true, jump = true }
                end,
                desc = 'Next problem',
                mode = 'n',
            },
            {
                '<leader>xp',
                function()
                    require('trouble').previous { skip_groups = true, jump = true }
                end,
                desc = 'Previous problem',
                mode = 'n',
            },
        },
    },
}
