--[[

# Comment
Toggle comments
- gcc -> to toggle line comment
- gc  -> to toggle comment of visual regions/lines

https://github.com/numToStr/Comment.nvim


# Treesitter context comments
Automatically adjust comment type in different languages in one file
Example: JavaScript in HTML

https://github.com/JoosepAlviste/nvim-ts-context-commentstring


# Todo Comments
Highlight todo, notes, etc in comments

https://github.com/folke/todo-comments.nvim

--]]

return {
    { -- Comment toggling
        'numToStr/Comment.nvim',
        lazy = true,
        event = 'VeryLazy',
        config = function()
            require('Comment').setup {
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
            }
        end,
    },

    { -- Context dependent comment types
        'JoosepAlviste/nvim-ts-context-commentstring',
        lazy = true,
        event = 'VeryLazy',
        opts = {
            enable_autocmd = false,
        },
    },

    { -- Highlight todo, note, bug, fix etc. labels
        'folke/todo-comments.nvim',
        lazy = true,
        event = 'VeryLazy',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = true },
    },
}
