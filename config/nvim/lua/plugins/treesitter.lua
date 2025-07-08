--[[

# Treesitter
Highlight, edit, and navigate code
https://github.com/nvim-treesitter/nvim-treesitter

# Treesiter Context
Shows the context of the currently visible buffer contents
https://github.com/nvim-treesitter/nvim-treesitter-context

--]]

return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        branch = 'main',
        build = ':TSUpdate',
        opts = {
            ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc', 'rust', 'python' },
            ignore_install = { 'latex', 'asm' },
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
            require('nvim-treesitter').setup(opts)

            -- Enable folding
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.wo.foldmethod = 'expr'
            vim.wo.foldlevel = 100

            vim.keymap.set("n", "z0", ":set foldlevel=100<cr>")
            vim.keymap.set("n", "z1", ":set foldlevel=0<cr>")
            vim.keymap.set("n", "z2", ":set foldlevel=1<cr>")
            vim.keymap.set("n", "z3", ":set foldlevel=2<cr>")
            vim.keymap.set("n", "z4", ":set foldlevel=3<cr>")
            vim.keymap.set("n", "z5", ":set foldlevel=4<cr>")
            vim.keymap.set("n", "z6", ":set foldlevel=5<cr>")
            vim.keymap.set("n", "z7", ":set foldlevel=6<cr>")
            vim.keymap.set("n", "z8", ":set foldlevel=7<cr>")
            vim.keymap.set("n", "z9", ":set foldlevel=8<cr>")

            -- Enable highlighting
            vim.api.nvim_create_autocmd('BufReadPost', {
                callback = function()
                    local buf = vim.api.nvim_get_current_buf()
                    local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
                    if lang and not vim.treesitter.highlighter.active[buf] then
                        vim.treesitter.start(buf, lang)
                    end
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
        end,
    },

    {
        'nvim-treesitter/nvim-treesitter-context',
        lazy = false,
        opts = {
            enable = true,
            separator = nil,
            line_numbers = true,
            mode = 'cursor',
            max_lines = 1,
            min_window_height = 40,
            multiline_threshold = 1,
        },
        config = function(_, opts)
            require('treesitter-context').setup(opts)

            vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { link = 'Visual' })
            vim.api.nvim_set_hl(0, 'TreesitterContextLineNumberBottom', { link = 'Normal' })
        end,
    },
}
