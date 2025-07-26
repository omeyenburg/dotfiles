--[[

# Vim Sleuth
Automatic indentation adjustment based on edited file layout
https://github.com/tpope/vim-sleuth
Alternative: https://github.com/Darazaki/indent-o-matic
(faster, because it only checks the first indentation)

# Conform
Autoformat
https://github.com/stevearc/conform.nvim

--]]

return {
    { -- Indentation size detection
        'tpope/vim-sleuth',
        lazy = true,
        event = { 'VeryLazy', 'BufRead' },
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
                    vim.cmd 'silent! Sleuth'
                end,
                desc = '[F]ormat buffer',
                mode = '',
            },
        },
        opts = {
            notify_on_error = true,
            formatters_by_ft = {
                bash = { 'shfmt' },
                c = { 'clang-format' },
                cpp = { 'clang-format' },
                go = { 'gofmt', 'goimports' },
                json = { 'jq' },
                jsonc = { 'jq' },
                lua = { 'stylua' },
                nix = { 'alejandra' },
                python = { 'black' },
                rust = { 'rustfmt' },
                sh = { 'shfmt' },
                toml = { 'taplo' },
                typescript = { 'prettier' },
            },
        },
    },
}
