--[[

# Mason
Install language servers
- :Mason

https://github.com/williamboman/mason.nvim


# Nvim Lspconfig
LSP Configuration &

https://github.com/neovim/nvim-lspconfig


# Cmp
Autocompletion

https://github.com/hrsh7th/nvim-cmp


# Autopairs
Adds a bracket after completing functions or methods

https://github.com/windwp/nvim-autopairs


--]]

return {
    {
        'williamboman/mason.nvim',
        lazy = true,
        cmd = 'Mason',
        event = 'BufReadPre',
        opts = {
            ui = {
                icons = {
                    package_installed = '✓',
                    package_pending = '➜',
                    package_uninstalled = '✗',
                },
            },
        },
    },

    {
        'williamboman/mason-lspconfig.nvim',
        lazy = true,
        event = 'BufReadPre',
    },

    {
        'neovim/nvim-lspconfig',
        commit = 'cee94b2',
        lazy = true,
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            -- Automatically install LSPs and related tools to stdpath for Neovim
            { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',

            -- Shows LSP loading status in the bottom right-hand corner
            -- { 'j-hui/fidget.nvim', enabled = false, opts = {} },

            -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
            -- used for completion, annotations and signatures of Neovim apis
            { 'folke/neodev.nvim', opts = {} },
        },
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc)
                        vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                    end

                    -- Jump to the definition of the word under your cursor.
                    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

                    -- Find references for the word under your cursor.
                    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

                    -- Jump to the implementation of the word under your cursor.
                    map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

                    -- Jump to the type of the word under your cursor.
                    map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

                    -- Fuzzy find all the symbols in your current document.
                    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

                    -- Fuzzy find all the symbols in your current workspace.
                    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

                    -- Rename the variable under your cursor.
                    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

                    -- Execute a code action, usually your cursor needs to be on top of an error
                    -- or a suggestion from your LSP for this to activate.
                    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

                    -- Opens a popup that displays documentation about the word under your cursor
                    map('K', vim.lsp.buf.hover, 'Hover Documentation')

                    -- WARN: This is not Goto Definition, this is Goto Declaration.
                    --  For example, in C this would take you to the header.
                    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                    -- The following two autocommands are used to highlight references of the
                    -- word under your cursor when your cursor rests there for a little while.
                    -- When you move your cursor, the highlights will be cleared (the second autocommand).
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client.server_capabilities.documentHighlightProvider then
                        local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
                        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.clear_references,
                        })

                        vim.api.nvim_create_autocmd('LspDetach', {
                            group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
                            end,
                        })
                    end

                    -- The following autocommand is used to enable inlay hints in your
                    -- code, if the language server you are using supports them
                    -- This may be unwanted, since they displace some of your code
                    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                        map('<leader>th', function()
                            vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
                        end, '[T]oggle Inlay [H]ints')
                    end

                    -- Autocompletion selection highlights
                    --- gray
                    vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg = 'NONE', strikethrough = true, fg = '#808080' })
                    --- blue
                    vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = 'NONE', fg = '#569CD6' })
                    vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link = 'CmpItemAbbrMatch' })
                    --- light blue
                    vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg = 'NONE', fg = '#9CDCFE' })
                    vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link = 'CmpItemKindVariable' })
                    vim.api.nvim_set_hl(0, 'CmpItemKindText', { link = 'CmpItemKindVariable' })
                    --- pink
                    vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg = 'NONE', fg = '#C586C0' })
                    vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link = 'CmpItemKindFunction' })
                    --- front
                    vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg = 'NONE', fg = '#D4D4D4' })
                    vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link = 'CmpItemKindKeyword' })
                    vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link = 'CmpItemKindKeyword' })
                end,
            })

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

            local servers = {
                clangd = {},
                pyright = {},
                rust_analyzer = {
                    on_attach = function(_, bufnr)
                        vim.lsp.inlay_hint.enable(bufnr)
                    end,
                },
                tsserver = {},
                lua_ls = {
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = 'Replace',
                            },
                            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                            -- diagnostics = { disable = { 'missing-fields' } },
                        },
                    },
                },
            }

            -- Ensure the servers and tools above are installed
            require('mason').setup()

            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                'stylua', -- Used to format Lua code
                --'jdtls@1.25.0',
            })
            require('mason-tool-installer').setup { ensure_installed = ensure_installed }

            require('mason-lspconfig').setup {
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                        require('lspconfig')[server_name].setup(server)
                    end,
                },
            }
        end,
    },

    {
        'hrsh7th/nvim-cmp',
        lazy = true,
        event = { 'InsertEnter', 'CmdlineEnter' },
        dependencies = {
            { -- Snippet Engine & its associated nvim-cmp source
                'L3MON4D3/LuaSnip',
                build = 'make install_jsregexp',
            },
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-calc',
            --'onsails/lspkind.nvim',
        },
        config = function()
            local cmp = require 'cmp'
            --local lspkind = require 'lspkind'
            local luasnip = require 'luasnip'
            luasnip.config.setup {}

            --[[
            local cursor_on_space = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col == 0 or vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' ~= nil
            end
            ]]

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = {
                    keyword_pattern = [[\k\+]],
                    completeopt = 'menu,menuone,noinsert,noselect',
                    keyword_length = 1,
                },
                mapping = cmp.mapping.preset.insert {
                    -- NOTE: LSP-Zero implementation:
                    -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/lua/lsp-zero/cmp-mapping.lua
                    -- ['<Tab>'] = cmp_action.tab_complete(),
                    -- ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),

                    -- Select next and complete
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        --[[
                        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
                        local on_space = col == 0 or vim.api.nvim_buf_get_lines(0, row - 1, row, true)[1]:sub(col, col):match '%s' ~= nil
                        if on_space then
                            vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { string.rep(' ', 4 - col % 4) })
                            vim.api.nvim_win_set_cursor(0, { row, col + 4 - col % 4 })
                        elseif cmp.visible() then
                            cmp.select_next_item()
                        else
                            cmp.complete_common_string()
                        end
                        --]]
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

                    -- Select the [n]ext item
                    --['<C-n>'] = cmp.mapping.select_next_item(),
                    -- Select the [p]revious item
                    --['<C-p>'] = cmp.mapping.select_prev_item(),

                    -- Scroll the documentation window [u]p / [d]own
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),

                    -- Toggle documentation window [g]
                    ['<C-g>'] = function()
                        if cmp.visible_docs() then
                            vim.cmd.notify 'Closed docs'
                            cmp.close_docs()
                        else
                            vim.cmd.notify 'Opened docs'
                            cmp.open_docs()
                        end
                    end,

                    -- Accept ([y]es) the completion.
                    --  This will auto-import if your LSP supports it.
                    --  This will expand snippets if the LSP sent a snippet.
                    ['<C-y>'] = cmp.mapping.confirm { select = true },

                    -- Abort completion
                    ['<C-e>'] = cmp.mapping.abort(),

                    -- LuaSnip completions: https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
                    -- <c-l> will move you to the right of each of the expansion locations
                    -- <c-h> is similar, except moving you backwards
                    ['<C-l>'] = cmp.mapping(function()
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        end
                    end, { 'i', 's' }),
                    ['<C-h>'] = cmp.mapping(function()
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { 'i', 's' }),
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                enabled = function()
                    -- if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then -- Disable in prompt
                    --     return false
                    -- end

                    local context = require 'cmp.config.context'
                    if context.in_treesitter_capture 'comment' or context.in_syntax_group 'Comment' then -- Disable in comment
                        return false
                    end

                    --[[
                    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
                    if col == 0 or vim.api.nvim_buf_get_lines(0, row - 1, row, true)[1]:sub(col, col):match '%s' ~= nil then -- Disable outside word
                        return false
                    end
                    ]]

                    -- return vim.api.nvim_get_mode().mode == 'c'
                    return true
                end,
                sorting = {
                    priority_weight = 1.0,
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        cmp.config.compare.recently_used,
                        function(entry1, entry2)
                            local _, entry1_under = entry1.completion_item.label:find '^_+'
                            local _, entry2_under = entry2.completion_item.label:find '^_+'
                            entry1_under = entry1_under or 0
                            entry2_under = entry2_under or 0
                            if entry1_under > entry2_under then
                                return false
                            elseif entry1_under < entry2_under then
                                return true
                            end
                        end,
                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
                sources = cmp.config.sources { -- See :h cmp-config.sources
                    {
                        name = 'path',
                        priority = 9,
                        group_index = 1,
                        keyword_length = 4,
                    },
                    {
                        name = 'luasnip',
                        priority = 8,
                        group_index = 2,
                        option = { use_show_condition = true },
                        entry_filter = function()
                            local context = require 'cmp.config.context'
                            return not context.in_treesitter_capture 'string' and not context.in_syntax_group 'String'
                        end,
                    },
                    {
                        name = 'nvim_lsp',
                        priority = 7,
                        group_index = 2,
                        entry_filter = function(entry, _)
                            return cmp.lsp.CompletionItemKind.Snippet ~= entry:get_kind()
                        end,
                    },
                    -- { name = 'nvim_lsp_signature_help', },
                    {
                        name = 'nvim_lua',
                        priority = 6,
                        group_index = 3,
                    },
                    {
                        name = 'crates',
                        priority = 5,
                        group_index = 3,
                    },
                    {
                        name = 'treesitter',
                        priority = 4,
                        group_index = 4,
                        keyword_length = 4,
                    },
                    {
                        name = 'buffer',
                        priority = 3,
                        group_index = 5,
                        keyword_length = 3,
                        max_indexed_line_length = 1024 * 4,
                        option = {
                            keyword_pattern = [[\k\+]], -- Completion support for special characters: ä, ö, ü
                        },
                    },
                    {
                        name = 'calc',
                        priority = 2,
                        group_index = 6,
                    },
                    {
                        name = 'emoji',
                        priority = 1,
                        keyword_length = 2,
                        group_index = 6,
                    },
                    {
                        name = 'nerdfont',
                        priority = 1,
                        keyword_length = 2,
                        group_index = 6,
                    },
                },
                --[[formatting = {
                     expandable_indicator = true
                    format = lspkind.cmp_format {
                        with_text = true,
                        menu = {
                            buffer = '[buf]',
                            nvim_lsp = '[LSP]',
                            nvim_lua = '[api]',
                            path = '[path]',
                            luasnip = '[snip]',
                            --gh_issues = '[issues]',
                            --tn = '[TabNine]',
                            --eruby = '[erb]',
                        },
                    },
                },]]
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

            --[[cmp.event:on('menu_opened', function()
                local row, col = unpack(vim.api.nvim_win_get_cursor(0))
                if col == 0 or vim.api.nvim_buf_get_lines(0, row - 1, row, true)[1]:sub(col, col):match '%s' ~= nil then
                    vim.notify 'close'
                    cmp.mapping.close()
                end
            end)]]

            --@diagnostic disable-next-line: undefined-field
            cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())
        end,
    },

    {
        'windwp/nvim-autopairs',
        lazy = true,
        event = 'InsertEnter',
        dependencies = { 'hrsh7th/nvim-cmp' },
        opts = {
            disable_filetype = { 'TelescopePrompt' },
        },
    },
}
