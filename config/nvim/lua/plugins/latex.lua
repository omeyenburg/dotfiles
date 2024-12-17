--[[

# VimTex
Latex compilation & live preview
https://github.com/lervag/vimtex

--]]

return {
    'lervag/vimtex',
    lazy = true,
    ft = { 'tex' },
    init = function()
        vim.g.vimtex_view_method = 'zathura'
    end,
}
