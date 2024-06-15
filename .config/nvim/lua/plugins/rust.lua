--[[

# Rust Tools

https://github.com/simrat39/rust-tools.nvim


# Rust Analyzer

https://github.com/rust-lang/rust-analyzer


# Crate

https://github.com/Saecki/crates.nvim

--]]

return { -- Rust
    {
        'simrat39/rust-tools.nvim',
        lazy = true,
        ft = { 'rust' },
        config = function()
            vim.notify 'Loaded rust-tools'
        end,
    },

    {
        'rust-lang/rust-analyzer',
        lazy = true,
        ft = { 'rust' },
        config = function()
            vim.notify 'Loaded rust-analyzer'
        end,
    },

    {
        'Saecki/crates.nvim',
        lazy = true,
        ft = { 'rust' },
    },
}
