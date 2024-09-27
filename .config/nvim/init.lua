if vim.env.VSCODE then
    vim.g.vscode = true
end

local config_path = debug.getinfo(1, 'S').source:sub(2):match '(.*/)'
vim.opt.runtimepath:prepend(config_path)

require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require 'config.lazy'

-- Must run after plugins
vim.api.nvim_command 'highlight WinSeparator guifg=#A9B2D5' -- Set color of split lines
vim.opt.laststatus = 3 -- Enables horizontal split lines by disabling status lines for each buffer (must run after plugins)
