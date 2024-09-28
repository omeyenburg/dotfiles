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
    {
        'numToStr/Comment.nvim',
        enabled = true,
        lazy = true,
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            require('Comment').setup {
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
            }
        end,
    },

    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        lazy = true,
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {
            enable_autocmd = false,
        },
    },

    {
        'folke/todo-comments.nvim',
        lazy = true,
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = true },
    },
}
