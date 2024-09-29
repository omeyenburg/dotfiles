--[[

# Treesitter
Highlight, edit, and navigate code

https://github.com/nvim-treesitter/nvim-treesitter


# Treesiter Context
Shows the context of the currently visible buffer contents

https://github.com/nvim-treesitter/nvim-treesitter-context

--]]

return {
    { -- Syntax parser
        'nvim-treesitter/nvim-treesitter',
        lazy = true,
        event = { 'BufReadPost', 'BufNewFile' },
        build = ':TSUpdate',
        opts = {
            ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc', 'rust', 'python' },
            auto_install = true,
            highlight = {
                enable = true,
                -- If you are experiencing weird indenting issues, add the language to
                -- the list of additional_vim_regex_highlighting and disabled languages for indent.
                additional_vim_regex_highlighting = { 'ruby' },
            },
            indent = { enable = true, disable = { 'ruby' } },
        },
        config = function(_, opts)
            require('nvim-treesitter.install').prefer_git = true
            require('nvim-treesitter.configs').setup(opts)
        end,
    },

    { -- Current context
        'nvim-treesitter/nvim-treesitter-context',
        lazy = true,
        event = { 'BufReadPost', 'BufNewFile' },
    },
}
