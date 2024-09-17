--[[

# Mini
Collection of various small independent plugins/modules

https://github.com/echasnovski/mini.nvim


 NOTE: Alternative kylechui/nvim-surround

]]

return {
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

            require('mini.pairs').setup()
        end,
    },
}
