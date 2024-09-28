--[[

# Better Messages
Shows messages in a separate window
- :Bmessages
- Close using: C-w o 

https://github.com/ariel-frischer/bmessages.nvim

--]]

return {
    {
        'ariel-frischer/bmessages.nvim',
        lazy = true,
        cmd = 'Bmessages',
        keys = {
            { '<leader>m', '<cmd>Bmessages<cr>', mode = 'n' },
        },
        opts = {
            keep_focus = true, -- Don't focus the bmessages window after opening.
            buffer_name = 'bmessages_buffer',
        },
    },
}
