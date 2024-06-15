--[[

# Conform
Autoformat

https://github.com/stevearc/conform.nvim


# Vim Sleuth
Automatic indentation adjustment based on edited file layout

https://github.com/tpope/vim-sleuth


# Indent Blankline
Vertical indentation lines

https://github.com/lukas-reineke/indent-blankline.nvim

--]]

return {
    {
        'stevearc/conform.nvim',
        lazy = true,
        event = { 'BufReadPost', 'BufNewFile' },
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
            format_on_save = function(bufnr)
                local disable_filetypes = { c = true, cpp = true }
                return {
                    timeout_ms = 500,
                    lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
                }
            end,
            formatters_by_ft = {
                lua = { 'stylua' },
                python = { 'black' },
                java = { 'google_java_format' },
            },
        },
    },

    {
        'tpope/vim-sleuth',
        lazy = true,
        event = 'InsertEnter',
    },

    {
        'lukas-reineke/indent-blankline.nvim',
        lazy = true,
        event = { 'BufReadPost', 'BufNewFile' },
        main = 'ibl',
        opts = {
            whitespace = { highlight = nil, remove_blankline_trail = false },
            scope = { enabled = false },
        },
    },
}
