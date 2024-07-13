--[[

# Undotree
- <leader>u  -> Toggle tree
- C-[hjkl]   -> Navigate between windows

https://github.com/mbbill/undotree

--]]

return {
    {
        'mbbill/undotree',
        lazy = true,
        cmd = 'UndotreeToggle',
        keys = {
            { '<leader>u', '<cmd>UndotreeToggle<CR>', desc = 'Undo tree', mode = 'n' },
        },
    },
}
