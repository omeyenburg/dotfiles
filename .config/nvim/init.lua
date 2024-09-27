if vim.env.VSCODE then
    vim.g.vscode = true
end

local config_path = debug.getinfo(1, 'S').source:sub(2):match '(.*/)'
vim.opt.runtimepath:prepend(config_path)

-- Must be set at beginning
vim.g.mapleader = ' '

require 'config.lazy'
require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
