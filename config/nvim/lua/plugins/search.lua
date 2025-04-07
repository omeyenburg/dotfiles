--[[

# Harpoon
Quickly mark files and switch between marked files
https://github.com/theprimeagen/harpoon

# Telescope
Fuzzy Finder for files and more
https://github.com/nvim-telescope/telescope.nvim

--]]

return {
    {
        'theprimeagen/harpoon',
        lazy = true,
        event = 'VeryLazy',
        keys = {
            {
                '<leader>a',
                function()
                    require('harpoon.mark').add_file()
                end,
                desc = '[A]dd file to harpoon',
                mode = 'n',
            },
            {
                '<C-e>',
                function()
                    require('harpoon.ui').toggle_quick_menu()
                end,
                desc = 'Toggle harpoon menu',
                mode = 'n',
            },
            {
                '<C-n>',
                function()
                    require('harpoon.ui').nav_next()
                end,
                desc = 'Open next file',
                mode = 'n',
            },
            {
                '<C-p>',
                function()
                    require('harpoon.ui').nav_prev()
                end,
                desc = 'Open previous file',
                mode = 'n',
            },
            {
                '<leader>1',
                function()
                    require('harpoon.ui').nav_file(1)
                end,
                desc = 'Select first file of harpoon',
                mode = 'n',
            },
            {
                '<leader>2',
                function()
                    require('harpoon.ui').nav_file(2)
                end,
                desc = 'Select second file of harpoon',
                mode = 'n',
            },
            {
                '<leader>3',
                function()
                    require('harpoon.ui').nav_file(3)
                end,
                desc = 'Select third file of harpoon',
                mode = 'n',
            },
            {
                '<leader>4',
                function()
                    require('harpoon.ui').nav_file(4)
                end,
                desc = 'Select fourth file of harpoon',
                mode = 'n',
            },
            {
                '<leader>5',
                function()
                    require('harpoon.ui').nav_file(5)
                end,
                desc = 'Select fifth file of harpoon',
                mode = 'n',
            },
        },
    },

    {
        'nvim-telescope/telescope.nvim',
        lazy = true,
        event = 'VeryLazy',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
            { 'nvim-telescope/telescope-ui-select.nvim' },
        },
        config = function()
            require('telescope').setup {
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown(),
                    },
                },
            }

            -- Enable Telescope extensions if they are installed
            pcall(require('telescope').load_extension, 'fzf')
            pcall(require('telescope').load_extension, 'ui-select')
            pcall(require('telescope').load_extension, 'harpoon')

            -- See `:help telescope.builtin`
            local builtin = require 'telescope.builtin'
            vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
            vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
            vim.keymap.set('n', '<leader>sw', function()
                builtin.grep_string { search = vim.fn.input 'Grep > ' }
            end, { desc = '[S]earch current [W]ord' })
            vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
            vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
            vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
            vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

            -- Search in current buffer
            vim.keymap.set('n', '<leader>/', function()
                builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, { desc = '[/] Fuzzily search in current buffer' })

            -- Search in opened files
            vim.keymap.set('n', '<leader>s/', function()
                builtin.live_grep {
                    grep_open_files = true,
                    prompt_title = 'Live Grep in Open Files',
                }
            end, { desc = '[S]earch [/] in Open Files' })

            -- Search in Neovim configuration files
            vim.keymap.set('n', '<leader>sn', function()
                builtin.find_files { cwd = vim.fn.stdpath 'config' }
            end, { desc = '[S]earch [N]eovim files' })
        end,
    },
}
