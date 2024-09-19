-- Enable the following language servers
-- Add any additional override configuration in the following tables. Available keys are:
--  - cmd (table): Override the default command used to start the server
--  - filetypes (table): Override the default list of associated filetypes for the server
--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--  - settings (table): Override the default settings passed when initializing the server.
return {
    bashls = {}, -- Bash LSP
    clangd = {}, -- C, C++, C#, Objective-C LSP
    cmake = {}, -- CMake LSP
    gradle_ls = {}, -- Gradle LSP
    html = {}, -- HTML LSP
    rust_analyzer = { -- Rust LSP
        on_attach = function(client, bufnr)
            require('completion').on_attach(client)
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end,
        settings = {
            ['rust-analyzer'] = {
                imports = {
                    granularity = {
                        group = 'module',
                    },
                    prefix = 'self',
                },
                cargo = {
                    buildScripts = {
                        enable = true,
                    },
                },
                procMacro = {
                    enable = true,
                },
            },
        },
    },
    lua_ls = { -- Lua LSP
        settings = {
            Lua = { -- https://github.com/LuaLS/vscode-lua/blob/master/setting/schema.json
                completion = {
                    callSnippet = 'Replace',
                },
                diagnostics = {
                    globals = { 'vim' },
                },
            },
        },
    },
    jedi_language_server = {}, -- Python LSP; Quick autocompletion, including from other modules and files
    -- pyright = {}, -- Extremely slow, but just works and large user base
    -- pylyzer = {}, -- Extremely fast, but small docs and no completion with imports
    -- basedpyright = {}, -- According to docs, node is not used; cannot get it to run
}
