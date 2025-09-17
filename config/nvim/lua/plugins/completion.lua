--[[

# Autopairs
Add closing brackets and quotes & open bracket after function completion
https://github.com/windwp/nvim-autopairs

# Blink Completion
Autocompletion and function signatures
https://github.com/saghen/blink.cmp

]]

local function completable()
    local cursor = vim.api.nvim_win_get_cursor(0)
    if cursor[2] == 0 then
        return false
    end
    local char = vim.api.nvim_buf_get_text(0, cursor[1] - 1, cursor[2] - 1, cursor[1] - 1, cursor[2], {})[1]
    return char:match '%S' ~= nil and char ~= ')' and char ~= '}'
end

return {
    { -- Auto brackets and quotes
        'windwp/nvim-autopairs',
        lazy = true,
        event = 'InsertEnter',
        opts = {},
    },

    {
        'saghen/blink.cmp',
        lazy = true,
        event = 'VeryLazy',
        version = '*',
        dependencies = {
            'rafamadriz/friendly-snippets',
        },
        opts = {
            keymap = {
                preset = 'none',
                ['<Tab>'] = {
                    function(cmp)
                        if cmp.snippet_active() then
                            if cmp.snippet_active { direction = 1 } == false then
                                vim.snippet.stop()
                                cmp.cancel()
                                return true
                            end
                            return cmp.snippet_forward()
                        elseif cmp.is_visible() then
                            return cmp.select_next()
                        elseif vim.bo.buftype ~= 'prompt' and completable() then
                            return cmp.show()
                        end
                    end,
                    'fallback',
                },
                ['<S-Tab>'] = {
                    function(cmp)
                        if cmp.snippet_active() then
                            if cmp.snippet_active { direction = -1 } == false then
                                return true
                            end
                            return cmp.snippet_backward()
                        elseif cmp.is_visible() then
                            return cmp.select_prev()
                        elseif vim.bo.buftype ~= 'prompt' and completable() then
                            return cmp.show()
                        end
                    end,
                    'fallback',
                },
                ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
                ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
                ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
                ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-y>'] = { 'select_and_accept' },
                ['<C-k>'] = { 'fallback' },
                ['<Up>'] = { 'fallback' },
                ['<Down>'] = { 'fallback' },
                ['<Left>'] = { 'fallback' },
                ['<Right>'] = { 'fallback' },
            },
            appearance = { nerd_font_variant = 'mono' },
            completion = {
                menu = {
                    auto_show = true,
                    border = 'rounded',
                    -- draw = { treesitter = { 'lsp' } },
                },
                accept = { auto_brackets = { enabled = true } },
                keyword = { range = 'prefix' },
                documentation = {
                    auto_show = true,
                    window = { border = 'rounded' },
                },
                list = { selection = { preselect = false, auto_insert = true } },
                trigger = { show_on_insert_on_trigger_character = true },
                ghost_text = { enabled = true },
            },
            signature = {
                enabled = true,
                window = { border = 'rounded' },
            },
            cmdline = {
                keymap = {
                    preset = 'none',
                    ['<Tab>'] = { 'select_next' },
                    ['<S-Tab>'] = { 'select_prev' },
                    ['<Up>'] = { 'select_prev', 'fallback' },
                    ['<Down>'] = { 'select_next', 'fallback' },
                    ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
                    ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
                    ['<C-y>'] = { 'select_and_accept' },
                },
                completion = {
                    menu = { auto_show = true },
                    list = { selection = { preselect = false, auto_insert = true } },
                },
            },
            snippets = {
                expand = function(snippet)
                    local col = vim.api.nvim_win_get_cursor(0)[2]
                    local line = vim.api.nvim_get_current_line()

                    if line:sub(col + 1, col + 1) ~= '(' then
                        vim.snippet.expand(snippet)
                        return
                    end

                    vim.snippet.expand(string.gsub(snippet, '%(.*', '') .. '$0')
                end,
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                providers = { snippets = { min_keyword_length = 4 } },
            },
        },
        config = function(_, opts)
            require('blink.cmp').setup(opts)

            -- Change border color from NormalFloat to FloatBorder
            vim.api.nvim_set_hl(0, 'BlinkCmpDocBorder', { link = 'FloatBorder' })
            vim.api.nvim_set_hl(0, 'BlinkCmpMenuBorder', { link = 'FloatBorder' })
            vim.api.nvim_set_hl(0, 'BlinkCmpSignatureHelpBorder', { link = 'FloatBorder' })

            -- Exit snippet when changing mode
            vim.api.nvim_create_autocmd('ModeChanged', {
                pattern = '*',
                callback = function(args)
                    local from = vim.v.event.old_mode
                    local to = vim.v.event.new_mode

                    -- Only stop if we leave insert/select *and* don't return immediately
                    if (from:match '^i' or from:match '^s') and not to:match '^[is]' then
                        -- Defer slightly to avoid breaking field jumps
                        vim.defer_fn(function()
                            local mode = vim.api.nvim_get_mode().mode
                            if not mode:match '^[is]' then
                                vim.snippet.stop()
                            end
                        end, 20)
                    end
                end,
            })
        end,
    },
}
