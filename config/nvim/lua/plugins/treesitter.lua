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
        lazy = false,
        branch = 'main',
        -- event = { 'BufReadPost', 'BufNewFile' },
        build = ':TSUpdate',
        opts = {
            ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc', 'rust', 'python' },
            ignore_install = { 'latex', 'asm' }, -- Disable latex, because it requires nodejs
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { 'ruby' },
            },
            indent = {
                enable = true,
            },
            ts_context_commentstring = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
            },
        },
        config = function(_, opts)
            require('nvim-treesitter.install').prefer_git = true

            vim.api.nvim_create_autocmd('FileType', {
                pattern = { '<filetype>' },
                callback = function()
                    vim.treesitter.start()
                end,
            })

            -- local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
            -- parser_config.mips = {
            --     install_info = {
            --         url = 'https://github.com/omeyenburg/tree-sitter-mips', -- You can use a local path for url if you prefer
            --         -- url = vim.fn.expand '$HOME/git/tree-sitter-mips',
            --         branch = 'main',
            --         files = { 'src/parser.c' },
            --         generate_requires_npm = false,
            --         requires_generate_from_grammar = false,
            --     },
            --     filetype = 'asm',
            -- }

            -- Fix treesitter not attaching, when opening files via Snacks
            -- vim.api.nvim_create_autocmd('BufWinEnter', {
            --     callback = function()
            --         vim.cmd 'TSBufEnable highlight'
            --     end,
            -- })
        end,
    },

    {
        'nvim-treesitter/nvim-treesitter-context',
        lazy = false,
        opts = {
            enable = true,
            separator = nil,
            line_numbers = true,
            mode = "cursor",
            max_lines = 1,
            min_window_height = 40,
            multiline_threshold = 1,
        },
        config = function(_, opts)
            require("treesitter-context").setup(opts)

            vim.api.nvim_set_hl(0, "TreesitterContextBottom", { link = "Visual" })
            vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", { link = "Normal" })
        end
    },
}
