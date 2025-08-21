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
                -- awk-language-server
                -- https://github.com/Beaglefoot/awk-language-server
                awk_ls = {},

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

                -- cmake-language-server
                -- https://github.com/regen100/cmake-language-server
                cmake = {},

                -- clang-tools for C/C++/Objective-C/Objective-C++
                -- https://clangd.llvm.org/config
                clangd = {
                    cmd = {
                        'clangd',
                        '--clang-tidy',
                        '--completion-style=detailed',
                        '--header-insertion=iwyu',
                        '--all-scopes-completion',
                    },
                },

                -- glsl-analyzer
                -- https://github.com/nolanderc/glsl_analyzer?tab=readme-ov-file#neovim
                glslls = {},

                -- lua-language-server
                -- https://luals.github.io/wiki/configuration/#neovim
                lua_ls = {
                    root_dir = function(fname)
                        local nvim_config_realpath = vim.fn.resolve(vim.fn.stdpath 'config')

                        if fname:find(nvim_config_realpath, 1, true) == 1 then
                            return nvim_config_realpath
                        end
                        return require('lspconfig.util').root_pattern('.luarc.json', '.luarc.jsonc', '.git')(fname)
                    end,
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

                -- typescript-language-server
                ts_ls = {},

                -- rust-analyzer
                -- https://rust-analyzer.github.io/book/configuration.html
                rust_analyzer = {
                    cargo = {
                        -- features = [],
                    },
                    procMacro = { enable = true },
                    cachePriming = { enable = false },
                    check = {
                        command = 'clippy',
                        extraArgs = { '--no-deps' },
                    },
                    checkOnSave = true,
                    completion = { fullFunctionSignatures = { enable = true } },
                    diagnostics = {
                        disabled = { 'unlinked-file' },
                        experimental = { enable = true },
                        styleLints = { enable = true },
                    },
                    highlightInactiveCode = true,
                    semanticHighlighting = {
                        punctuation = {
                            enable = true,
                            separate = { macro = { bang = true } },
                            specialization = { enable = true },
                        },
                        operator = { specialization = { enable = true } },
                    },
                    inlayHints = {
                        enable = true,
                        maxLength = 50,
                        chainingHints = { enable = true },
                        closureCaptureHints = { enable = true },
                        bindingModeHints = { enable = true },
                        closureReturnTypeHints = { enable = 'always' },
                        discriminantHints = { enable = 'always' },
                        expressionAdjustmentHints = { enable = 'always' },
                        genericParameterHints = { lifetime = { enable = true }, type = { enable = true } },
                        implicitDrops = { enable = true },
                        lifetimeElisionHints = { enable = 'always', useParameterNames = true },
                        rangeExclusiveHints = { enable = true },
                        reborrowHints = { enable = 'always' },
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

                    map('K', function()
                        vim.lsp.buf.hover { border = 'rounded' }
                    end, 'Hover Documentation')

                    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
                    map('gt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')
                    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
                    map('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

                    -- Fuzzy find all the symbols in your current document.
                    map('<leader>ld', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

                    -- Fuzzy find all the symbols in your current workspace.
                    map('<leader>lw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

                    -- Execute a code action, usually your cursor needs to be on top of an error
                    -- or a suggestion from your LSP for this to activate.
                    map('<leader>la', vim.lsp.buf.code_action, 'Code [A]ction')

                    map('<leader>lr', vim.lsp.buf.rename, 'Lsp [R]ename')

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
                if lspconfig[server] then
                    local cmd = lspconfig[server].document_config.default_config.cmd

                    if vim.fn.executable(cmd[1]) == 1 then
                        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
                        lspconfig[server].setup(config)
                    end
                end
            end

            vim.lsp.set_log_level 'debug'

            -- Enable inlay hints, virtual text, etc.
            vim.lsp.inlay_hint.enable(true)
            vim.diagnostic.config {
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = true,
                severity_sort = true,
            }
        end,
    },
}
