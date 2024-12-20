--  _   _       _
-- | \ | |_   _(_)_ __ ___
-- |  \| \ \ / / | '_ ` _ \
-- | |\  |\ V /| | | | | | |
-- |_| \_| \_/ |_|_| |_| |_|
--

-- Must run at beginning
vim.opt.runtimepath:prepend(debug.getinfo(1, 'S').source:sub(2):match '(.*/)')
vim.g.mapleader = ' '

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

require 'config.options'
require 'config.keymaps'
require 'config.autocmds'

-- Floating terminal
local state = {
  floating = {
    buf = -1,
    win = -1,
  }
}

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  -- Calculate the position to center the window
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Create a buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  end

  -- Define window configuration
  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal", -- No borders or extra UI elements
    border = "rounded",
  }

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local toggle_terminal = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

-- Example usage:
-- Create a floating window with default dimensions
vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})

-- vim: softtabstop=4 shiftwidth=4 expandtab
