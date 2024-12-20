--[[

# VimTex
Latex compilation & live preview
https://github.com/lervag/vimtex

# Render Markdown
Render pretty markdown
https://github.com/MeanderingProgrammer/render-markdown.nvim

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
        init = function()
            vim.g.vimtex_view_method = 'zathura'
        end,
    },

    {
        'MeanderingProgrammer/render-markdown.nvim',
        lazy = true,
        ft = { 'markdown' },
        opts = {},
    },

    {
        'simrat39/rust-tools.nvim',
        lazy = true,
        ft = { 'rust' },
        opts = {
            tools = {
                autoSetHints = true,
                inlay_hints = {
                    show_parameter_hints = true,
                    parameter_hints_prefix = '<- ',
                    other_hints_prefix = '=> ',
                    max_len_align = false,
                    right_align = false,
                },
            },
            server = {
                on_attach = function(_, bufnr)
                    -- Mappings for LSP
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

                    -- Depricated
                    -- buf_set_keymap(bufnr, 'n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
                    -- buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
                    -- buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
                    -- buf_set_keymap(bufnr, 'n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
                    -- buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

                    local move_item = require('rust-tools').move_item.move_item
                    buf_set_keymap(bufnr, 'v', 'K', function()
                        move_item(true)
                    end, { noremap = true, silent = true })
                    buf_set_keymap(bufnr, 'v', 'J', function()
                        move_item(false)
                    end, { noremap = false, silent = true })
                end,
                settings = {
                    ['rust-analyzer'] = {
                        diagnostics = {
                            enable = true,
                            disabled = {},
                            enableExperimental = true,
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
        ft = { 'rust' },
    },
}
