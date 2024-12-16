--[[

# Nvim Web DevIcons
Integrates support of nerd fonts
https://github.com/nvim-tree/nvim-web-devicons

# Gitsigns
Adds git related signs to the line numbers, as well as utilities for managing changes
https://github.com/lewis6991/gitsigns.nvim

# Nvim Colorizer
Draws the colors hex color strings in their matching color.
Abonded version: https://github.com/norcalli/nvim-colorizer.lua
https://github.com/NvChad/nvim-colorizer.lua

# Twilight
Dims inactive parts of the code. - :Twilight -> Toggle twilight mode
https://github.com/folke/twilight.nvim

# Tokyonight
Pretty colorscheme - Variants: tokyonight-night, tokyonight-day, tokyonight-moon, tokyonight-storm
https://github.com/folke/tokyonight.nvim

# Lualine
Adds a statusline with automatic adjusting style, matching the colorscheme
https://github.com/nvim-lualine/lualine.nvim

# Alpha
Greeting interface
https://github.com/goolord/alpha-nvim

# Which-Key
Shows pending keybinds in a window at the bottom
https://github.com/folke/which-key.nvim

# Todo Comments
Highlight todo, notes, etc in comments
https://github.com/folke/todo-comments.nvim

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

    { -- Draw the hex strings in their matching color.
        'NvChad/nvim-colorizer.lua',
        lazy = true,
        event = 'VeryLazy',
        priority = 800, -- load after airline theme, before TreeSitter/LSP
        opts = {
            filetypes = {
                '*',
                '!c',
                '!cpp',
                html = { RGB = true },
                css = { RGB = true, names = true },
            },
            user_default_options = {
                RGB = false,
                names = false,
            },
        },
    },

    { -- Dim inactive code parts
        'folke/twilight.nvim',
        lazy = true,
        cmd = 'Twilight',
    },

    { -- Tokyonight colorscheme
        'folke/tokyonight.nvim',
        lazy = true,
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
        priority = 900,
        event = 'VimEnter',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup {
                options = {
                    icons_enabled = true, -- Requires a nerd font

                    -- Theme
                    -- https://github.com/nvim-luaVline/lualine.nvim/blob/master/THEMES.md
                    theme = 'auto',

                    --component_separators = { left = '', right = '' },
                    --section_separators = { left = '', right = '' },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = true,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    },
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = {
                        {
                            'filename',
                            path = 1,
                        },
                    },
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {},
            }
        end,
    },

    { -- Startup screen
        'goolord/alpha-nvim',
        lazy = true,
        enabled = false,
        event = 'VimEnter',
        opts = function()
            local dashboard = require 'alpha.themes.dashboard'

            dashboard.section.header.val = {
                '                                                    ',
                ' ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
                ' ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
                ' ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
                ' ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
                ' ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
                ' ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
                '                                                    ',
            }

            dashboard.section.buttons.val = {
                -- https://www.nerdfonts.com/cheat-sheet
                dashboard.button('n', '󰷈  New file', '<cmd>ene<CR>'),
                dashboard.button('e', '  File Explorer', '<cmd>Ex<CR>'),
                dashboard.button('l', '  Restore last session', [[<cmd>lua require("persistence").load({ last = true })<CR>]]),
                dashboard.button('r', '  Recent files', '<cmd>Telescope oldfiles<CR>'),
                dashboard.button('f', '  Find file', '<cmd>Telescope find_files<CR>'),
                dashboard.button('p', '󰒲  Plugins', '<cmd>Lazy<CR>'),
                dashboard.button('m', '󱌣  Mason', '<cmd>Mason<CR>'),
                dashboard.button('s', '  Settings', '<cmd>cd ~/.config/nvim<CR><cmd>Ex<CR>'),
                dashboard.button('q', '  Quit', '<cmd>qa<CR>'),
            }

            return dashboard
        end,
        config = function(_, dashboard)
            local alpha = require 'alpha'

            vim.api.nvim_create_autocmd('User', {
                callback = function()
                    local stats = require('lazy').stats()
                    local ms = math.floor(stats.startuptime * 100) / 100
                    dashboard.section.footer.val = '󱐌 Lazy-loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms'
                    pcall(vim.cmd.AlphaRedraw)
                end,
            })

            alpha.setup(dashboard.opts)
        end,
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
        opts = { signs = true },
    },
}
