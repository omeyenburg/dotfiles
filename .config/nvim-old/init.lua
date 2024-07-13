if vim.env.VSCODE then
    vim.g.vscode = true
end

require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require 'config.lazy'
--require('config.health').check()
