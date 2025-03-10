--[[

# Treesitter
Highlight, edit, and navigate code
https://github.com/nvim-treesitter/nvim-treesitter

# Treesiter Context
Shows the context of the currently visible buffer contents
https://github.com/nvim-treesitter/nvim-treesitter-context

--]]

local function disable(_, buf)
    local max_size = 10 -- Kilobytes
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    if (not ok) or stats and stats.size > 1024 * max_size then
        return true
    end
end

return {
    { -- Syntax parser
        'nvim-treesitter/nvim-treesitter',
        lazy = true,
        event = { 'BufReadPost', 'BufNewFile' },
        build = ':TSUpdate',
        opts = {
            ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc', 'rust', 'python' },
            ignore_install = { 'latex', 'asm' }, -- Disable latex, because it requires nodejs
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { 'ruby' },
                disable = disable,
            },
            indent = {
                enable = true,
                disable = disable,
            },
            ts_context_commentstring = {
                enable = true,
                disable = disable,
            },
            incremental_selection = {
                enable = true,
                disable = disable,
            },
        },
        config = function(_, opts)
            require('nvim-treesitter.install').prefer_git = true
            require('nvim-treesitter.configs').setup(opts)

            local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
            parser_config.mips = {
                install_info = {
                    -- url = 'https://github.com/omeyenburg/tree-sitter-mips', -- You can use a local path for url if you prefer
                    url = vim.fn.expand '$HOME/git/tree-sitter-mips',
                    branch = 'main',
                    files = { 'src/parser.c' },
                    generate_requires_npm = false,
                    requires_generate_from_grammar = false,
                },
                filetype = 'asm',
            }
        end,
    },
}
