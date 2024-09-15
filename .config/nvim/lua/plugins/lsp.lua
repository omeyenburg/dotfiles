--[[

# Mason
Install language servers
- :Mason

https://github.com/williamboman/mason.nvim
https://github.com/williamboman/mason-lspconfig.nvim


# Nvim Lspconfig
LSP Configuration &

https://github.com/neovim/nvim-lspconfig

]]

return {
    {
        'williamboman/mason.nvim',
        lazy = true,
        priority = 1000,
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

    {
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
            { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',

            -- Useful status updates for LSP.
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim', opts = {} },
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

            -- Enable the following language servers
            -- Add any additional override configuration in the following tables. Available keys are:
            --  - cmd (table): Override the default command used to start the server
            --  - filetypes (table): Override the default list of associated filetypes for the server
            --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
            --  - settings (table): Override the default settings passed when initializing the server.
            local ensure_installed = {
                stylua = {}, -- Lua formatter
                black = {}, -- Python formatter
                ['clang-format'] = {}, -- C, C++, C#, Objective-C formatter
                ['google-java-format'] = {}, -- Java formatter
                prettier = {}, -- General formatter
                rustfmt = {}, -- Rust formatter
                shfmt = {}, -- Shell script formatter
                eslint = {}, -- JavaScript, TypeScript linter
                flake8 = {}, -- Python linter
                codelldb = {}, -- C, C++, Rust Debugger
                cpptools = {}, -- Debugger and code browser for C, C++
                bashls = {}, -- Bash LSP
                clangd = {}, -- C, C++, C#, Objective-C LSP
                cmake = {}, -- CMake LSP
                gradle_ls = {}, -- Gradle LSP
                html = {}, -- HTML LSP
                rust_analyzer = {}, -- Rust LSP
                lua_ls = { -- Lua LSP
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
                jedi_language_server = {}, -- Python LSP; Quick autocompletion, including from other modules and files
                -- pyright = {}, -- Extremely slow, but just works and large user base
                -- pylyzer = {}, -- Extremely fast, but small docs and no completion with imports
                -- basedpyright = {}, -- According to docs, node is not used; cannot get it to run
            }

            require('mason').setup()
            require('mason-tool-installer').setup { ensure_installed = vim.tbl_keys(ensure_installed) }
            require('mason-lspconfig').setup {
                handlers = {
                    function(server_name)
                        local server = ensure_installed[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                        require('lspconfig')[server_name].setup(server)
                    end,
                },
            }
        end,
    },
}
