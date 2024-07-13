-- Some default keymaps to remember in normal mode
--- C-^         open last file
--- G           move to end of file
--- gg          move to start of file
--- 0           move to start of line ignoring indentation
--- ^           move to first character of line (Remove dead key on MacOS using Ukulele)
--- $           move to end of line
--- >>          indent line
--- <<          dedent line
--- >>          indent line
--- <<          dedent line
--- .           repeat indentation
--- gv          reselect previous selection
--- [number] >> indent this lines and the following lines
--- [number] << dedent this lines and the following lines

-- Some default keymaps to remember in visual mode
--- >           indent selection
--- <           dedent selection
--- [number] >  indent selection by number of tabs
--- [number] <  dedent selection by number of tabs

------------------------------
-- Keymap options
------------------------------

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
-- : This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<nop>')
vim.keymap.set('n', '<right>', '<nop>')
vim.keymap.set('n', '<up>', '<nop>')
vim.keymap.set('n', '<down>', '<nop>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Indent line in insert mode
vim.keymap.set('i', '<C-lt>', function()
    vim.cmd 'normal! <<'
end)
vim.keymap.set('i', '<C->>', function()
    vim.cmd 'normal! >>'
end)

-- New line similar to "o" and "O" but without moving cursor
vim.keymap.set('n', '<leader>o', 'v<Esc>o<Esc>gv<Esc>')
-- see https://stackoverflow.com/a/16136133/6064933
-- keymap.set("n", "<space>o", "printf('m`%so<ESC>``', v:count1)", {
--   expr = true,
--   desc = "insert line below",
-- })
--
-- keymap.set("n", "<space>O", "printf('m`%sO<ESC>``', v:count1)", {
--   expr = true,
--   desc = "insert line above",
-- })

-- Enter file explorer using <Space>+"e"
vim.keymap.set('n', '<leader>e', vim.cmd.Ex, { desc = 'Goto [E]xplorer' })

-- Move selected content with "J" and "K"
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
-- vim.keymap.set('v', 'J', ":m '>+1<CR>gv") -- don't fix indentation without =gv

-- Prevent cursor from moving when deleting trailing "\n"
vim.keymap.set('n', 'J', 'mzJ`z')

-- Use Option+Shift+n for case toggle without moving
vim.keymap.set('n', '›', '~h')

-- Show function signature help with Ctrl+s
--vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help) -- moved to ray-x/lsp_signature.nvim

-- Keep cursor centered when half page jumping
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Keep cursor centered when cycling through options
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Keep clipboard when pasting only with <Space>+"p"
vim.keymap.set('x', '<leader>p', '"_dP')

-- Disable Q
vim.keymap.set('x', 'Q', '<nop>')

-- Quick fix navigation
vim.keymap.set('n', '<C-k', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-j', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

-- Replace all occurencies of the current word using <Space>+"s"
vim.keymap.set('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>')

-- Default indentation keymaps:
-- normal mode:
---
--- visual mode:

-- Tab indentation
vim.keymap.set('v', '<Tab>', '>gv', { desc = 'Indent selection' })
vim.keymap.set('v', '<S-Tab>', '<gv', { desc = 'Dedent selection' })

-- own implementation...
-- Problems:
-- A) Not reversible with undo
-- B) Does not fix offset indentation (e.g.: 3 spaces -> 3+4 -> 7 spaces)
vim.keymap.set('v', '<Tab>', function()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    --local on_space = col == 0 or vim.api.nvim_buf_get_lines(0, row - 1, row, true)[1]:sub(col, col):match '%s' ~= nil
    vim.api.nvim_buf_set_text(0, row - 1, 0, row - 1, 0, { '    ' })
    vim.api.nvim_win_set_cursor(0, { row, col + 4 })
end)
