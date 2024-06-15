--[[

# Persistence
Automated session management

https://github.com/folke/persistence.nvim

--]]

return {
    'folke/persistence.nvim',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
}
