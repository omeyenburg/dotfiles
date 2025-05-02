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
            servers = {
                -- haskell-language-server
                -- https://haskell-language-server.readthedocs.io/en/latest/configuration.html
                hls = {},

                -- nix-language-server
                -- https://github.com/nix-community/nixd/blob/main/nixd/docs/configuration.md
                nixd = {
                    settings = {
                        nixd = {},
                    },
                },

                -- clang-tools for C/C++/Objective-C/Objective-C++
                -- https://clangd.llvm.org/config
                clangd = {},

                -- glsl-analyzer
                -- https://github.com/nolanderc/glsl_analyzer?tab=readme-ov-file#neovim
                glslls = {},

                -- lua-language-server
                -- https://luals.github.io/wiki/configuration/#neovim
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

                -- bash-language-server
                -- https://github.com/bash-lsp/bash-language-server?tab=readme-ov-file
                bashls = {},

                -- jedi-language-server for Python
                -- https://github.com/pappasam/jedi-language-server?tab=readme-ov-file#configuration
                jedi_language_server = {
                    init_options = {},
                },

                -- latex-language-server
                -- https://github.com/latex-lsp/texlab/wiki/Configuration
                texlab = {},

                -- rust-analyzer
                -- https://rust-analyzer.github.io/book/configuration.html
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

            -- Configure language servers
            for server, config in pairs(opts.servers) do
                -- passing config.capabilities to blink.cmp merges with the capabilities in your
                -- `opts[server].capabilities, if you've defined it
                config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
                lspconfig[server].setup(config)
            end

            -- Add rounded borders to hover menu
            vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = 'rounded',
            })

            -- Enable inlay hints, e.g. implicit types
            vim.lsp.inlay_hint.enable(true)
        end,
    },
}
