--[[

# LSP Signature
Provides function signatures

https://github.com/ray-x/lsp_signature.nvim


# Cmp
Autocompletion

https://github.com/hrsh7th/nvim-cmp

]]

return {
    { -- Signature
        'ray-x/lsp_signature.nvim',
        lazy = true,
        event = { 'BufReadPost', 'BufNewFile' },
        opts = {
            bind = true,
            doc_lines = 0,
            hint_enable = false,
            hi_parameter = 'Search',
            extra_trigger_chars = { '(', ',', '=', ' ', ')' },
            floating_window = true,
            toggle_key = '<C-x>',
        },
        config = function(_, opts)
            require('lsp_signature').setup(opts)
        end,
    },

    { -- Autocompletion
        'hrsh7th/nvim-cmp',
        lazy = true,
        event = { 'BufReadPost', 'BufNewFile' },
        dependencies = {
            { -- Snippet Engine & its associated nvim-cmp source
                'L3MON4D3/LuaSnip',
                build = 'make install_jsregexp',
            },
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-calc',
        },
        config = function()
            local cmp = require 'cmp'
            local luasnip = require('luasnip').config.setup {}

            cmp.setup {
                preselect = cmp.PreselectMode.None, -- Forces rust-analyzer not to use preselection
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = {
                    keyword_pattern = [[\k\+]],
                    completeopt = 'menu,menuone,noinsert,noselect',
                    keyword_length = 0, -- Allow completions for lua tables, testing if this even works otherwise
                },
                mapping = {
                    -- Select next and complete
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),

                    -- Select previous and complete
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),

                    -- Abort completion
                    ['<C-e>'] = cmp.mapping.abort(),

                    -- Scroll the documentation window [u]p / [d]own
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),

                    -- Toggle documentation window [g]
                    ['<C-g>'] = function()
                        if cmp.visible_docs() then
                            vim.print 'Closed docs'
                            cmp.close_docs()
                        else
                            vim.print 'Opened docs'
                            cmp.open_docs()
                        end
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                enabled = function()
                    local context = require 'cmp.config.context'
                    if context.in_treesitter_capture 'comment' or context.in_syntax_group 'Comment' then -- Disable completion in comment
                        return false
                    end

                    return true
                end,
                sorting = {
                    priority_weight = 1.0,
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        cmp.config.compare.recently_used,
                        cmp.config.compare.kind,
                        -- function(entry1, entry2)
                        --     local _, entry1_under = entry1.completion_item.label:find '^_+'
                        --     local _, entry2_under = entry2.completion_item.label:find '^_+'
                        --     entry1_under = entry1_under or 0
                        --     entry2_under = entry2_under or 0
                        --     if entry1_under > entry2_under then
                        --         return false
                        --     elseif entry1_under < entry2_under then
                        --         return true
                        --     end
                        -- end,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
                sources = cmp.config.sources({
                    {
                        name = 'path',
                        priority = 9,
                        keyword_length = 4,
                    },
                    {
                        name = 'nvim_lsp',
                        priority = 8,
                        entry_filter = function(entry, _)
                            return cmp.lsp.CompletionItemKind.Snippet ~= entry:get_kind()
                        end,
                    },
                }, {
                    -- {
                    --     name = 'luasnip',
                    --     priority = 8,
                    --     option = { use_show_condition = true },
                    --     entry_filter = function()
                    --         local context = require 'cmp.config.context'
                    --         return not context.in_treesitter_capture 'string' and not context.in_syntax_group 'String'
                    --     end,
                    -- },
                    {
                        name = 'nvim_lua',
                        priority = 6,
                    },
                }, {
                    {
                        name = 'buffer',
                        priority = 3,
                        keyword_length = 2,
                        max_indexed_line_length = 1024 * 4,
                        option = {
                            keyword_pattern = [[\k\+]], -- Completion support for special characters: ä, ö, ü
                        },
                    },
                    {
                        name = 'calc',
                        priority = 2,
                    },
                }),
            }

            -- '/' & '?' cmdline setup.
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' },
                },
            })

            -- ':' cmdline setup.
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' },
                }, {
                    { name = 'cmdline' },
                }),
            })
        end,
    },
}
