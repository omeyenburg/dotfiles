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

local function script_path()
    local str = debug.getinfo(2, 'S').source:sub(2)
    return str:match '(.*/)'
end

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
                bash = { 'shfmt' }, -- Bash formatter
                c = { 'clang-format' }, -- C formatter
                cpp = { 'clang-format' }, -- C++ formatter
                css = { 'prettier' }, -- CSS formatter
                go = { 'goimports', 'gofmt' }, -- Go formatters
                html = { 'prettier' }, -- HTML formatter
                java = { 'google_java_format' }, -- Java formatter
                javascript = { 'prettier' }, -- JavaScript formatter
                json = { 'jq' }, -- JSON formatter
                lua = { 'stylua' }, -- Lua formatter
                markdown = { 'prettier' }, -- Markdown formatter
                python = { 'black' }, -- Python formatter with global config in ~/pyproject.toml
                rust = { 'rustfmt' }, -- Rust formatter
                typescript = { 'prettier' }, -- TypeScript formatter
                yaml = { 'prettier' }, -- YAML formatter
                dosini = { 'config_format' },
            },
            formatters = {
                config_format = {
                    command = 'python3',
                    args = { script_path() .. '/../formatter/config_format.py', '$FILENAME' },
                    stdin = false,
                },
            },
        },
    },

    { -- Comment toggling
        'numToStr/Comment.nvim',
        lazy = true,
        event = 'VeryLazy',
    },
}
