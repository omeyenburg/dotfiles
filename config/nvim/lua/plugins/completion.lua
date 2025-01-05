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
        -- build = "cargo build --release",
        -- version = not vim.g.lazyvim_blink_main and "*",
        -- build = vim.g.lazyvim_blink_main and "cargo build --release",
        dependencies = {
            -- optional: provides snippets for the snippet source
            'rafamadriz/friendly-snippets',
            { -- Snippet Engine & its associated nvim-cmp source
                'L3MON4D3/LuaSnip',
                version = 'v2.*',
                build = 'make install_jsregexp',
            },
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

            -- fuzzy = { prebuilt_binaries = { force_version ="*"}, },
            completion = {
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
                documentation = { auto_show = true, auto_show_delay_ms = 500 },
                -- Displays a preview of the selected item on the current line
                ghost_text = {
                    enabled = false,
                },
            },

            -- Experimental signature help support
            signature = {
                enabled = true,
            },

            -- Snippets
            snippets = {
                expand = function(snippet)
                    require('luasnip').lsp_expand(snippet)
                end,
                active = function(filter)
                    if filter and filter.direction then
                        return require('luasnip').jumpable(filter.direction)
                    end
                    return require('luasnip').in_snippet()
                end,
                jump = function(direction)
                    require('luasnip').jump(direction)
                end,
            },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'luasnip', 'buffer' },
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
        -- allows extending the providers array elsewhere in your config
        -- without having to redefine it
        opts_extend = { 'sources.default' },
        config = function(_, opts)
            require("blink.cmp").setup(opts)
            require("config.luasnip")
        end
    },
}
