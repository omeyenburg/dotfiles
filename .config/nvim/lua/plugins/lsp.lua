--[[

# Mason
Package manager for neovim utilities

https://github.com/williamboman/mason.nvim


# Mason-LSPConfig
closes some gaps that exist between mason.nvim and lspconfig

https://github.com/williamboman/mason-lspconfig.nvim


# Nvim Lspconfig
LSP Configuration &

https://github.com/neovim/nvim-lspconfig

]]

return {
    { -- Package manager
        'williamboman/mason.nvim',
        lazy = true,
        priority = 1000, -- Must run before nvim-lspconfig
        cmd = 'Mason',
        event = { 'BufReadPost', 'BufNewFile' },
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

    { -- Setup Mason for lspconfig
        'williamboman/mason-lspconfig.nvim',
        lazy = true,
        priority = 900,
        event = { 'BufReadPost', 'BufNewFile' },
    },

    { -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        lazy = true,
        priority = 800,
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',

            -- Useful status updates for LSP
            -- { 'j-hui/fidget.nvim', opts = {} },
        },
        opts = {
            inlay_hints = { enabled = true },
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

                    -- NOTE: The following two autocommands are used to highlight references of the
                    -- word under your cursor when your cursor rests there for a little while.
                    -- When you move your cursor, the highlights will be cleared (the second autocommand).
                    local client = vim.lsp.get_client_by_id(event.data.client_id)

                    -- if client and client.server_capabilities.documentHighlightProvider then
                    --     local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
                    --     vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                    --         buffer = event.buf,
                    --         group = highlight_augroup,
                    --         callback = vim.lsp.buf.document_highlight,
                    --     })
                    --
                    --     vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                    --         buffer = event.buf,
                    --         group = highlight_augroup,
                    --         callback = vim.lsp.buf.clear_references,
                    --     })
                    --
                    --     vim.api.nvim_create_autocmd('LspDetach', {
                    --         group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
                    --         callback = function(event2)
                    --             vim.lsp.buf.clear_references()
                    --             vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
                    --         end,
                    --     })
                    -- end

                    -- Toggle inlay hints
                    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                        map('<leader>th', function()
                            vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
                        end, '[T]oggle Inlay [H]ints')
                    end

                    -- Autocompletion selection highlights
                    vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg = 'NONE', strikethrough = true, fg = '#808080' })
                    vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = 'NONE', fg = '#569CD6' })
                    vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link = 'CmpItemAbbrMatch' })
                    vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg = 'NONE', fg = '#9CDCFE' })
                    vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link = 'CmpItemKindVariable' })
                    vim.api.nvim_set_hl(0, 'CmpItemKindText', { link = 'CmpItemKindVariable' })
                    vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg = 'NONE', fg = '#C586C0' })
                    vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link = 'CmpItemKindFunction' })
                    vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg = 'NONE', fg = '#D4D4D4' })
                    vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link = 'CmpItemKindKeyword' })
                    vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link = 'CmpItemKindKeyword' })
                end,
            })

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
            capabilities.textDocument.signatureHelp = nil

            local mason_tools = require 'config.mason_tools'
            local mason_servers = require 'config.mason_servers'

            require('mason').setup()

            require('mason-tool-installer').setup {
                ensure_installed = mason_tools,
                auto_update = true, -- Automatically update on startup
                run_on_start = true, -- Run update on Neovim startup
            }

            require('mason-lspconfig').setup {
                ensure_installed = vim.tbl_keys(mason_servers),
                automatic_installation = true,
                handlers = {
                    function(server_name)
                        local server = mason_servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                        require('lspconfig')[server_name].setup(server)
                    end,
                },
            }
        end,
    },
}
