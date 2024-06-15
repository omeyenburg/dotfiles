--[[

Possible structures:
https://github.com/zhimsel/dotfiles/tree/main/.config/nvim/lua/zhimsel/plugins
https://github.com/MuhametSmaili/nvim/blob/main/lua/smaili/core/options.lua
https://github.com/linux-cultist/dots/blob/main/.config/nvim/lua/plugins/init.lua
https://github.com/catgoose/nvim/blob/main/lua/plugins/cmp.lua

# Which-Key
Shows pending keybinds in a window at the bottom

https://github.com/folke/which-key.nvim

]]

return {
    {
        'folke/which-key.nvim',
        lazy = true,
        event = 'VeryLazy',
        config = function()
            require('which-key').setup()

            -- Document existing key chains
            require('which-key').register {
                ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
                ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
                ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
                ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
                ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
                ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
                ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
            }
            -- Visual mode
            require('which-key').register({
                ['<leader>h'] = { 'Git [H]unk' },
            }, { mode = 'v' })
        end,
    },
}
