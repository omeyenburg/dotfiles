--[[

# Rust Tools

https://github.com/simrat39/rust-tools.nvim


# Rust Analyzer

https://github.com/rust-lang/rust-analyzer


# Create

https://github.com/Saecki/crates.nvim

--]]

return { -- Rust
    {
        'simrat39/rust-tools.nvim',
        lazy = true,
        ft = { 'rust' },
    },

    {
        'rust-lang/rust-analyzer',
        lazy = true,
        ft = { 'rust' },
    },

    {
        'Saecki/crates.nvim',
        lazy = true,
        ft = { 'rust' },
    },
}
