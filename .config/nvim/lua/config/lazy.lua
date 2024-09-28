-- Install `lazy.nvim` plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim' -- Resolves to ~/.local/share/nvim/lazy/lazy.nvim
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end

if vim.loader then
    vim.loader.enable()
end

---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local opts = {
    defaults = { lazy = true },
    performance = {
        cache = { enabled = true },
        rtp = {
            disabled_plugins = {
                'gzip',
                'rplugin',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
            },
        },
    },
    change_detection = { -- Detect changes made to plugin files
        enabled = true,
        notify = false,
    },
}

require('lazy').setup("plugins", opts)
