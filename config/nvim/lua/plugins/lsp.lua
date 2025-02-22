--[[

# Nvim Lspconfig
LSP Configuration &
https://github.com/neovim/nvim-lspconfig

]]

return {
    { -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        lazy = true,
        priority = 800,
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'j-hui/fidget.nvim',
            'saghen/blink.cmp',
        },
        opts = {
            inlay_hints = { enabled = true },
            servers = {
                -- haskell-language-server
                hls = {},

                -- nixd (for Nix files)
                nixd = {},

                -- clang-tools (Clangd for C/C++/Objective-C/Objective-C++)
                clangd = {},

                -- glsl_analyzer (GLSL)
                glslls = {},

                -- lua-language-server (Lua)
                lua_ls = {
                    settings = {
                        Lua = {
                            workspace = {
                                library = vim.api.nvim_get_runtime_file('', true), -- Make LSP aware of Neovim runtime files
                                checkThirdParty = false,
                            },
                            telemetry = {
                                enable = false,
                            },
                        },
                    },
                },

                -- bash-language-server (Bash)
                bashls = {},

                -- jedi-language-server (Python)
                jedi_language_server = {},

                -- latex-language-server
                texlab = {},

                -- rust-analyzer
                rust_analyzer = {
                    cachePriming = {
                        enable = false,
                    },
                    check = {
                        command = 'clippy',
                    },
                    checkOnSave = true,
                    completion = {
                        fullFunctionSignatures = {
                            enable = true,
                        },
                    },
                    diagnostics = {
                        disabled = { 'unlinked-file' },
                    },
                    inlayHints = {
                        closureCaptureHints = {
                            enable = true,
                        },
                        closureReturnTypeHints = {
                            enable = 'always',
                        },
                        implicitDrops = {
                            enable = true,
                        },
                        genericParameterHints = {
                            lifetime = {
                                enable = true,
                            },
                            type = {
                                enable = true,
                            },
                        },
                    },
                },

                -- mips-language-server
                mips_ls = {
                    settings = {
                        Mips = {
                            arch = 'mips32',
                            disable_pseudo_instructions = false,
                            linting = {
                                enable = true,
                                missing_label = true,
                                unknown_instruction = true,
                                unknown_directive = true,
                            },
                        },
                    },
                },
            },
        },
        config = function(_, opts)
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc)
                        vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                    end

                    map('K', vim.lsp.buf.hover, 'Hover Documentation')
                    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
                    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
                    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
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

                    -- Should prevent rust-analyzer from crashing with code -32802
                    for _, method in ipairs { 'textDocument/diagnostic', 'workspace/diagnostic' } do
                        local default_diagnostic_handler = vim.lsp.handlers[method]
                        vim.lsp.handlers[method] = function(err, result, context, config)
                            if err and err.code == -32802 then
                                -- Check if the result contains a progress value
                                local progress = result and result.params and result.params.value

                                -- If the progress kind is "end", then let it pass through
                                if progress and progress.kind == 'end' then
                                    return default_diagnostic_handler(err, result, context, config)
                                end

                                -- Otherwise, ignore the error
                                return
                            end
                            return default_diagnostic_handler(err, result, context, config)
                        end
                    end
                end,
            })

            local lspconfig = require 'lspconfig'

            local configs = require 'lspconfig.configs'
            if not configs.mips_ls then
                configs.mips_ls = {
                    default_config = {
                        cmd = { vim.fn.expand '~' .. '/git/mips-language-server/target/debug/mips-language-server' },
                        root_dir = lspconfig.util.root_pattern '.git',
                        filetypes = { 'asm' },
                    },
                }
            end

            for server, config in pairs(opts.servers) do
                -- passing config.capabilities to blink.cmp merges with the capabilities in your
                -- `opts[server].capabilities, if you've defined it
                config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
                lspconfig[server].setup(config)
            end
        end,
    },
}
