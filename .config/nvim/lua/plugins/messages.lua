--[[

# BMessages
Shows messages in a separate window
- :Bmessages
- Close using: C-w o 

https://github.com/ariel-frischer/bmessages.nvim


# Notify
Shows notifications

https://github.com/rcarriga/nvim-notify

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

    {
        'rcarriga/nvim-notify',
        enabled = false,
        lazy = true,
        event = 'VeryLazy',
        config = function()
            vim.notify = function(message)
                require 'notify'(message, 'info', { render = 'minimal', timeout = 4000 })
            end
        end,
    },
}
