-- TODO: !!!
-- No tab if completion window is open (bug fix)
-- No tab if completion window is not open, but non-whitespace char on left side of cursor (feature to be added)

--[[

# LSP Signature
Provides function signatures

https://github.com/ray-x/lsp_signature.nvim


# Autopairs
Add closing brackets and quotes & open bracket after function completion

https://github.com/windwp/nvim-autopairs


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

    { -- Auto brackets and quotes
        'windwp/nvim-autopairs',
        lazy = true,
        event = { 'BufReadPost', 'BufNewFile' },
        config = function()
            require('nvim-autopairs').setup { map_cr = true }
            local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
            local cmp = require 'cmp'
            cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end,
    },

    { -- Auto completion
        'hrsh7th/nvim-cmp',
        lazy = true,
        event = { 'BufReadPost', 'BufNewFile', 'CmdlineEnter' },
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

            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
            end

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
                    -- ['<Tab>'] = cmp.mapping(function(fallback)
                    --     if cmp.visible() then
                    --         cmp.select_next_item()
                    --     else
                    --         fallback()
                    --     end
                    -- end, { 'i', 's' }),
                    --
                    -- ['<S-Tab>'] = cmp.mapping(function(fallback)
                    --     if cmp.visible() then
                    --         cmp.select_prev_item()
                    --     else
                    --         fallback()
                    --     end
                    -- end, { 'i', 's' }),

                    -- Select next and complete
                    ['<Tab>'] = function(fallback)
                        if not cmp.select_next_item() then
                            if vim.bo.buftype ~= 'prompt' and has_words_before() then
                                cmp.complete()
                            else
                                fallback()
                            end
                        end
                    end,

                    -- Select previous and complete
                    ['<S-Tab>'] = function(fallback)
                        if not cmp.select_prev_item() then
                            if vim.bo.buftype ~= 'prompt' and has_words_before() then
                                cmp.complete()
                            else
                                fallback()
                            end
                        end
                    end,

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
                -- enabled = function()
                --     local context = require 'cmp.config.context'
                --     if context.in_treesitter_capture 'comment' or context.in_syntax_group 'Comment' then -- Disable completion in comment
                --         return false
                --     end
                --
                --     return true
                -- end,
                enabled = function()
                    -- disable completion in comments
                    local context = require 'cmp.config.context'
                    -- keep command mode completion enabled when cursor is in a comment
                    if vim.api.nvim_get_mode().mode == 'c' then
                        return true
                    else
                        return not context.in_treesitter_capture 'comment' and not context.in_syntax_group 'Comment'
                    end
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
                    {
                        name = 'luasnip',
                        priority = 8,
                        option = { use_show_condition = true },
                        entry_filter = function()
                            local context = require 'cmp.config.context'
                            return not context.in_treesitter_capture 'string' and not context.in_syntax_group 'String'
                        end,
                    },
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
