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
    { -- Comment toggling
        'numToStr/Comment.nvim',
        lazy = true,
        event = 'VeryLazy',
    },

    { -- Highlight todo, note, bug, fix etc. labels
        'folke/todo-comments.nvim',
        lazy = true,
        event = 'VeryLazy',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = true },
    },
}
