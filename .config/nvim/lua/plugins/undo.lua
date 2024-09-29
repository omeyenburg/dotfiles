--[[

# Undotree
- <leader>u  -> Toggle tree
- C-[hjkl]   -> Navigate between windows

https://github.com/mbbill/undotree


# Persistence
Automatically saves sessions

https://github.com/folke/persistence.nvim

--]]

return {
    { -- Undotree
        'mbbill/undotree',
        lazy = true,
        cmd = 'UndotreeToggle',
        keys = {
            { '<leader>u', '<cmd>UndotreeToggle<cr>', desc = 'Undo tree', mode = 'n' },
        },
    },

    { -- Keep cursor position
        'folke/persistence.nvim',
        lazy = true,
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {},
    },
}
