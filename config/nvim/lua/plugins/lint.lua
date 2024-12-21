--[[

# Nvim Lint
Linting
https://github.com/mfussenegger/nvim-lint

--]]

return {
    { -- Linting
        'mfussenegger/nvim-lint',
        event = 'VeryLazy',
        config = function()
            local lint = require 'lint'

            lint.linters_by_ft = {
                -- c = { 'clangd' }, -- Mason install, automatic
                -- javascript = { 'eslint' }, -- Mason install
                -- markdown = { 'vale' },
                python = { 'flake8' }, -- Mason install
                -- rust = { 'rust_analyzer' }, -- has its own implementation
                -- text = { 'vale' },
            }

            local function set_config(linter, path)
                table.insert(lint.linters[linter].args, 1, '--config')
                table.insert(lint.linters[linter].args, 2, vim.fn.expand(path))
            end

            -- Add path to global config file for flake8
            set_config('flake8', '~/.config/flake8/setup.cfg')
            -- set_config('vale', '~/.config/vale/.vale.ini')

            -- table.insert(lint.linters.flake8.args, 1, '--config') -- Add path to global config file for flake8
            -- table.insert(lint.linters.flake8.args, 2, vim.fn.expand '~/.config/flake8/setup.cfg')
            -- table.insert(lint.linters.vale.args, 1, '--config') -- Add path to global config file for flake8
            -- table.insert(lint.linters.vale.args, 2, vim.fn.expand '~/.config/vale/.vale.ini')

            -- Create autocommand which carries out the actual linting on the specified events.
            local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
            vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
                group = lint_augroup,
                callback = function()
                    require('lint').try_lint()
                end,
            })
        end,
    },
}
