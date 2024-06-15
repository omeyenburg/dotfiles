local M = {}

-- Used for "keys" field of plugins
--
-- useless
function M:keybind(lhs, rhs, desc, mode)
    desc = desc or ''
    if type(mode) == 'string' then
        mode = { mode }
    else
        mode = mode or { 'n' }
    end

    return {
        lhs,
        rhs,
        mode = mode,
        desc = desc,
    }
end

return M
