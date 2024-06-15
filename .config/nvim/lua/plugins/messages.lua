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

local function cmd_string(cmd_arg)
    return [[<cmd>]] .. cmd_arg .. [[<cr>]]
end

local function str_to_tbl(v)
    if type(v) == 'string' then
        v = { v }
    end
    return v
end

local function lazy_map(lhs, rhs, modes)
    if type(rhs) == 'string' then
        rhs = cmd_string(rhs)
    end
    modes = str_to_tbl(modes) or { 'n' }
    return {
        lhs,
        rhs,
        mode = modes,
    }
end

return {
    {
        'ariel-frischer/bmessages.nvim',
        lazy = true,
        cmd = 'Bmessages',
        keys = {
            lazy_map('<leader>bm', 'Bmessages'),
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
