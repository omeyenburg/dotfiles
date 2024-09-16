--[[

# Comment
Toggle comments
- gcc -> to toggle line comment
- gc  -> to toggle comment of visual regions/lines

https://github.com/numToStr/Comment.nvim


# Todo Comments
Highlight todo, notes, etc in comments

https://github.com/folke/todo-comments.nvim

--]]

return {
    {
        'numToStr/Comment.nvim',
        enabled = false,
        lazy = true,
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {
            mappings = {
                basic = true,
                extra = false, -- Disable extra features like commenting new lines
            },
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
