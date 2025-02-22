--[[

# VimTex
Latex compilation & live preview
https://github.com/lervag/vimtex

# Crates.nvim
Rust crate management
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
