--[[

# Nvim Web DevIcons
Integrates support of nerd fonts
https://github.com/nvim-tree/nvim-web-devicons

# Gitsigns
Adds git related signs to the line numbers, as well as utilities for managing changes
https://github.com/lewis6991/gitsigns.nvim

# Tokyonight
Pretty colorscheme - Variants: tokyonight-night, tokyonight-day, tokyonight-moon, tokyonight-storm
https://github.com/folke/tokyonight.nvim

# Lualine
Adds a statusline with automatic adjusting style, matching the colorscheme
https://github.com/nvim-lualine/lualine.nvim

# Which-Key
Shows pending keybinds in a window at the bottom
https://github.com/folke/which-key.nvim

# Todo Comments
Highlight todo, notes, etc in comments
https://github.com/folke/todo-comments.nvim

# Snacks
Greeting interface, intent line, etc.
https://github.com/folke/snacks.nvim

]]

return {
    { -- Use dev icons font
        'nvim-tree/nvim-web-devicons',
        lazy = true,
        event = 'VeryLazy',
    },

    { -- Git change symbols
        'lewis6991/gitsigns.nvim',
        lazy = true,
        event = 'VeryLazy',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    },

    { -- Tokyonight colorscheme
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        event = 'VimEnter',
        init = function()
            vim.cmd.colorscheme 'tokyonight-night'
            vim.cmd.hi 'Comment gui=none guifg=#8C7DA6'
        end,
    },

    { -- Statusbar
        'nvim-lualine/lualine.nvim',
        lazy = true,
        event = 'VeryLazy',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                icons_enabled = true, -- Requires a nerd font
                theme = 'tokyonight', -- https://github.com/nvim-luaVline/lualine.nvim/blob/master/THEMES.md
                globalstatus = true,
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { { 'filename', path = 1 } },
                lualine_x = { 'windows' },
                lualine_y = { 'encoding', 'fileformat', 'filetype' },
                lualine_z = { 'location' },
            },
        },
    },

    { -- Shortcut helper
        'folke/which-key.nvim',
        lazy = true,
        event = 'VeryLazy',
        keys = {
            {
                '<leader>?',
                function()
                    require('which-key').show { global = false }
                end,
                desc = 'Buffer Local Keymaps (which-key)',
            },
        },
        opts = {
            present = 'modern',
        },
    },

    { -- Highlight todo, note, bug, fix etc. labels
        'folke/todo-comments.nvim',
        lazy = true,
        event = 'VeryLazy',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            signs = false,
        },
    },

    { -- Collection of QoL plugins
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = { enabled = true }, -- Disable lsp etc. in large files
            dashboard = {
                enabled = true,
                preset = {
                    keys = {
                        { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
                        { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
                        { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
                        { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
                        { icon = ' ', key = 'e', desc = 'File Explorer', action = ':Ex' },
                        { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
                        { icon = '󰒲 ', key = 'p', desc = 'Plugins', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
                        { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                        { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
                    },
                },
            },
            indent = { -- Draws indent lines
                enabled = true,
                scope = { enabled = false }, -- highlights current scope
            },
            quickfile = { enabled = true }, -- Quicky load files
        },
    },
}
