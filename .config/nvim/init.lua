-- Must run at beginning
vim.opt.runtimepath:prepend(debug.getinfo(1, 'S').source:sub(2):match '(.*/)')
vim.g.mapleader = ' '

require 'config.lazy'
require 'config.options'
require 'config.keymaps'
require 'config.latex'
require 'config.autocmds'
