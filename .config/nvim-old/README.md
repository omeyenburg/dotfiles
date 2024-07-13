

## Events

Plugins can be lazy-loaded on events, commands and keys.
List of all builtin events:
https://gist.github.com/dtr2300/2f867c2b6c051e946ef23f92bd9d1180
Some additional events of lazy: VeryLazy, ...

Good example of using events properly:
https://www.reddit.com/r/neovim/comments/1bk4sru/when_to_use_the_bufreadpost_event/

### After startup
event = 'VeryLazy'

### Entering a file:
event = { 'BufReadPre', 'BufNewFile' }

### Before saving a file:
event = 'BufWritePre'

### Alternative: cmd
cmd = [string/list of strings]
cmd = 'Telescope'

### Alternative: keys
keys = {[string: keys], [string/function: callback], (desc = [string: description]), (mode = [string/list of strings])}
keys = {'<leader>a', print, desc="Print", mode='n'}

## Debug

Some plugins seem to be broken (2024-5-17)

### lazy.nvim

File: help.lua

Replace this:
local files = vim.iter and vim.iter(tbl):flatten():totable() or vim.tbl_flatten(tbl)

With this:
local files = vim.tbl_flatten(tbl)


### mini.statusline

File: mini/statusline.lua

Replace this:
if vim.fn.has('nvim-0.10') == 1 then
  H.diagnostic_is_disabled = function(_) return not vim.diagnostic.is_enabled({ bufnr = 0 }) end
elseif vim.fn.has('nvim-0.9') == 1 then
  H.diagnostic_is_disabled = function(_) return vim.diagnostic.is_disabled(0) end
else
  H.diagnostic_is_disabled = function(_) return false end
end

With this:
if vim.fn.has('nvim-0.9') == 1 then
  H.diagnostic_is_disabled = function(_) return vim.diagnostic.is_disabled(0) end
else
  H.diagnostic_is_disabled = function(_) return false end
end

### indent-blankline.nvim

Replace this:
return vim.iter and vim.iter({ ... }):flatten():totable() or vim.tbl_flatten { ... }

with this:
return vim.tbl_flatten { ... }
