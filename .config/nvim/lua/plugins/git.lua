--[[

# Gitsigns
Adds git related signs to the line numbers, as well as utilities for managing changes
Can't be lazy loaded
See `:help gitsigns`

https://github.com/lewis6991/gitsigns.nvim

]]

return {
    {
        'lewis6991/gitsigns.nvim',
        lazy = true,
        event = 'BufReadPost',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    },
}
