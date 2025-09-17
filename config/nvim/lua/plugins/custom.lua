-- Searches for linkie plugin locally before loading it.
-- Temporary solution, as checking the filesystem during startup is usually not ideal.
local uv = vim.loop
local home = uv.os_homedir()
local linkiePlugin = home .. '/git/linkie.nvim'

local stat = uv.fs_stat(linkiePlugin)
if not stat or stat.type ~= 'directory' then
    return {}
end

return {
    {
        dev = true,
        dir = linkiePlugin,
        lazy = true,
        cmd = 'LinkieOpen',
        keys = {
            { '<leader>tk', '<cmd>LinkieOpen<cr>', desc = 'Open link', mode = 'n' },
        },
        opts = {},
    },
}
