--[[

# Vim Sleuth
Automatic indentation adjustment based on edited file layout
https://github.com/tpope/vim-sleuth
Alternative: https://github.com/Darazaki/indent-o-matic
(faster, because it only checks the first indentation)

# Conform
Autoformat
https://github.com/stevearc/conform.nvim

# Comment
Toggle comments
https://github.com/numToStr/Comment.nvim

--]]

return {
    { -- Indentation size detection
        'tpope/vim-sleuth',
        lazy = true,
        event = 'VeryLazy',
    },

    { -- Formatting
        'stevearc/conform.nvim',
        lazy = true,
        event = 'VeryLazy',
        keys = {
            {
                '<leader>f',
                function()
                    require('conform').format { async = true, lsp_fallback = true }
                end,
                desc = '[F]ormat buffer',
                mode = '',
            },
        },
        opts = {
            notify_on_error = true,
            -- format_on_save = function(bufnr)
            --     local disable_filetypes = { c = true, cpp = true }
            --     return {
            --         timeout_ms = 500,
            --         lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
            --     }
            -- end,
            formatters_by_ft = {
                bash = { 'shfmt' },
                c = { 'clang-format' },
                cpp = { 'clang-format' },
                json = { 'jq' },
                go = { 'gofmt', 'goimports' },
                lua = { 'stylua' },
                nix = { 'alejandra' },
                python = { 'black' }, -- Python formatter with global config in ~/pyproject.toml
                rust = { 'rustfmt' },
                sh = { 'shfmt' },
                ['_'] = { 'indent' },
            },
        },
    },

    { -- Comment toggling
        'numToStr/Comment.nvim',
        lazy = true,
        event = 'VeryLazy',
    },
}
