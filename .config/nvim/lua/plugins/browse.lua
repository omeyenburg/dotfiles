return {
    {
        dir = '/Users/oskar/Documents/GitHub/nvim-caps-lock',
        lazy = false,
        build = 'make',
    },

    {
        'oskarmeyenburg/browse.nvim',
        lazy = false,
        build = 'make',
        --config = function() print(require("browse").sum(5, 5)) end
    },
}
