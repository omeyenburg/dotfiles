--[[

# VimTex
Latex compilation & live preview
https://github.com/lervag/vimtex

# Rust Tools
https://github.com/simrat39/rust-tools.nvim

# Crates
https://github.com/Saecki/crates.nvim

--]]

return {
    {
        'lervag/vimtex',
        lazy = true,
        ft = { 'tex' },
        event = 'VeryLazy',
        init = function()
            vim.g.vimtex_view_method = 'zathura'
        end,
    },

    {
        'simrat39/rust-tools.nvim',
        lazy = true,
        ft = { 'rust' },
        event = 'VeryLazy',
        opts = {
            server = {
                standalone = true,
                on_attach = function(_, bufnr)
                    local opts = { noremap = true, silent = true }
                    local buf_set_keymap = vim.api.nvim_buf_set_keymap
                    buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
                    buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
                    buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
                    buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
                    buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
                    buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
                    buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
                    buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
                    buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
                    buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
                    buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
                end,
                settings = {
                    ['rust-analyzer'] = {
                        diagnostics = {
                            enable = true,
                        },
                        cargo = {
                            allFeatures = true,
                        },
                        checkOnSave = {
                            command = 'clippy',
                        },
                        procMacro = {
                            enable = true,
                        },
                    },
                },
            },
        },
    },

    {
        'Saecki/crates.nvim',
        lazy = true,
        event = 'BufRead Cargo.toml',
        config = function()
            local crates = require 'crates'
            crates.setup()

            vim.keymap.set('n', 'K', function()
                crates.show_popup()
                crates.focus_popup(nil)
            end, { silent = true, buffer = 0, desc = 'Show crate popup' })
            vim.keymap.set('n', '<leader>cv', function()
                crates.show_versions_popup()
                crates.focus_popup(nil)
            end, { silent = true, buffer = 0, desc = 'Show crate versions' })
            vim.keymap.set('n', '<leader>cf', function()
                crates.show_features_popup()
                crates.focus_popup(nil)
            end, { silent = true, buffer = 0, desc = 'Show crate features' })
            vim.keymap.set('n', '<leader>cd', function()
                crates.show_dependencies_popup()
                crates.focus_popup(nil)
            end, { silent = true, buffer = 0, desc = 'Show crate dependencies' })
        end,
    },
}
