local create_autocmd = function(opts)
    local event = opts.event
    opts.event = nil
    opts.group = vim.api.nvim_create_augroup(opts.group, { clear = true })
    vim.api.nvim_create_autocmd(event, opts)
end

-- Text file options
create_autocmd {
    event = { 'BufReadPre', 'BufNewFile' },
    group = 'nvim-text-files',
    pattern = { '*.md', '*.txt' },
    desc = 'Text file options',
    callback = function()
        vim.opt_local.wrap = true -- Enable wrapping
        vim.opt_local.breakindent = true -- Indent wrapped lines like parent line
        vim.opt_local.linebreak = true -- Don't split words
        vim.keymap.set('n', '<C-n>', function()
            vim.fn.search('^#', '') -- Go to next heading
        end, { buffer = 0, desc = 'Go to next heading' })
        vim.keymap.set('n', '<C-S-n>', function()
            vim.fn.search('^#', 'b') -- Go to last heading
        end, { buffer = 0, desc = 'Go to last heading' })
        vim.keymap.set('i', '->', '→ ', { buffer = 0 }) -- Create arrow
        vim.keymap.set('i', '=>', '⟹ ', { buffer = 0 }) -- Create double arrow
        vim.keymap.set('i', '_>', '󱞩 ', { buffer = 0 }) -- Create sequence arrow
    end,
}

-- Auto replacements triggered on file safe
create_autocmd {
    event = { 'BufWritePre' },
    group = 'nvim-auto-replace',
    pattern = { '*.txt', '*.md' },
    desc = 'Auto replacements triggered on file safe',
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

        for i = 1, #lines do
            lines[i] = string.gsub(lines[i], '[hH]2[oO]', 'H₂O')
            lines[i] = string.gsub(lines[i], '[cC][oO]2', 'CO₂')
        end

        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
    end,
}

-- Move to next headline in .md files
create_autocmd {
    event = { 'BufReadPre', 'BufNewFile' },
    group = 'nvim-markdown-jump',
    pattern = '*.md',
    desc = 'Move to next headline in .md files',
    callback = function() end,
}

-- Highlight when yanking text
create_autocmd {
    event = 'TextYankPost',
    group = 'nvim-highlight-yank',
    desc = 'Highlight when yanking text',
    callback = function()
        vim.highlight.on_yank()
    end,
}

-- Resize splits when window got resized
create_autocmd {
    event = 'VimResized',
    group = 'nvim-resize-splits',
    desc = 'Resize splits when window got resized',
    callback = function()
        vim.cmd 'tabdo wincmd ='
    end,
}

-- Go to previously selected line when opening a buffer
create_autocmd {
    event = 'BufReadPost',
    group = 'nvim-last-locoation',
    desc = 'Go to previously selected line when opening a buffer',
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
}

-- Disable automatic comments
vim.api.nvim_create_autocmd('FileType', {
    pattern = '*',
    callback = function()
        vim.opt.formatoptions:remove {
            'r', -- Automatically open comment in insert mode
            'o', -- Automatically create comment when starting a new line with o or O
            'c', -- Wrap comments
        }
    end,
})
