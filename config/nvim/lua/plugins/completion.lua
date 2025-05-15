--[[

# Autopairs
Add closing brackets and quotes & open bracket after function completion
https://github.com/windwp/nvim-autopairs

# Blink Completion
Autocompletion and function signatures
https://github.com/saghen/blink.cmp

]]

return {
    { -- Auto brackets and quotes
        'windwp/nvim-autopairs',
        lazy = true,
        event = 'InsertEnter',
        opts = {},
    },

    {
        'saghen/blink.cmp',
        lazy = true,
        event = 'VeryLazy',
        version = '*',
        dependencies = {
            -- Provides snippets for the snippet source
            'rafamadriz/friendly-snippets',
        },
        opts = {
            -- 'default' for mappings similar to built-in completion
            -- Available commands:
            --   show, hide, cancel, accept, select_and_accept, select_prev, select_next, show_documentation, hide_documentation,
            --   scroll_documentation_up, scroll_documentation_down, snippet_forward, snippet_backward, fallback
            -- 'default' keymap
            --   ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            --   ['<C-e>'] = { 'hide' },
            --   ['<C-y>'] = { 'select_and_accept' },
            --
            --   ['<C-p>'] = { 'select_prev', 'fallback' },
            --   ['<C-n>'] = { 'select_next', 'fallback' },
            --
            --   ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            --   ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
            --
            --   ['<Tab>'] = { 'snippet_forward', 'fallback' },
            --   ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
            keymap = { preset = 'default' },

            completion = {
                menu = {
                    auto_show = true,
                    border = 'rounded',
                },
                accept = {
                    -- Experimental auto-brackets support
                    -- Seems to only create brackets after completing functions
                    auto_brackets = {
                        enabled = true,
                    },
                },
                keyword = {
                    -- 'prefix' will fuzzy match on the text before the cursor
                    -- 'full' will fuzzy match on the text before *and* after the cursor
                    range = 'prefix',
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                    window = {
                        border = 'rounded',
                    },
                },
                -- Displays a preview of the selected item on the current line
                ghost_text = {
                    enabled = false,
                },
            },

            -- Experimental signature help support
            signature = {
                enabled = true,
                window = {
                    border = 'rounded',
                },
            },

            -- Snippets
            snippets = {
                expand = function(snippet)
                    local col = vim.api.nvim_win_get_cursor(0)[2]
                    local line = vim.api.nvim_get_current_line()

                    if line:sub(col + 1, col + 1) ~= '(' then
                        vim.snippet.expand(snippet)
                        return
                    end

                    vim.snippet.expand(string.gsub(snippet, '%(.*', '') .. '$0')
                end,
            },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                providers = { snippets = { min_keyword_length = 4 } },
                -- optionally disable cmdline completions
                -- cmdline = {},
            },

            appearance = {
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- will be removed in a future release
                use_nvim_cmp_as_default = true,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono',
            },
        },
        config = function(_, opts)
            require('blink.cmp').setup(opts)

            -- Change border color from NormalFloat to FloatBorder
            vim.api.nvim_set_hl(0, 'BlinkCmpDocBorder', { link = 'FloatBorder' })
            vim.api.nvim_set_hl(0, 'BlinkCmpMenuBorder', { link = 'FloatBorder' })
            vim.api.nvim_set_hl(0, 'BlinkCmpSignatureHelpBorder', { link = 'FloatBorder' })

            -- Exit snippet when changing mode
            vim.api.nvim_create_autocmd('ModeChanged', {
                pattern = '*',
                callback = function()
                    vim.snippet.stop()
                end,
            })
        end,
    },
}
