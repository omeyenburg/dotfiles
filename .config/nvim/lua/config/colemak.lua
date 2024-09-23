-- TODO: Remove home row mods

-- Custom mappings
local custom_map = {
    move_down = ":m '>+1<CR>gv=gv",
    move_up = ":m '<-2<CR>gv=gv",
}

-- Table of mappings: { mode, old, new }
-- Upper row:   /, w, e, b, g, /, n, u, /, /
-- Home row:    a, r, i, v, d, o, h, j, k, l
-- Lower row:   y, p, x, v, /, /, q, ., /, /
local remap = {
    -- Movement keys
    { { 'n', 'x', 'o', 'v' }, 'h', 'n' }, -- Map left to n
    { { 'n', 'x', 'o', 'v' }, 'j', 'e' }, -- Map down to e
    { { 'n', 'x', 'o', 'v' }, 'k', 'i' }, -- Map up to i
    { { 'n', 'x', 'o', 'v' }, 'l', 'o' }, -- Map right to o

    { { 'n', 'x', 'o', 'v' }, 'e', 'f' }, -- Map end of word to f
    { { 'n', 'x', 'o', 'v' }, 'E', 'F' }, -- Map end of WORD (punctuation) to F
    { { 'n', 'x', 'o', 'v' }, 'b', 'p' }, -- Map previous word to p
    { { 'n', 'x', 'o', 'v' }, 'B', 'P' }, -- Map previous WORD (punctuation) to P

    { 'n', 'n', 'l' }, -- Map find next to l
    { 'n', 'N', 'L' }, -- Map find previous to L

    -- Edit keys
    { { 'n', 'x', 'o', 'v' }, 'i', 's' }, -- Map insert to s
    { { 'n', 'x', 'o', 'v' }, 'I', 'S' }, -- Map beginning insert to S
    { 'n', 'o', 'h' }, -- Map new line below to h
    { 'n', 'O', 'H' }, -- Map new line above to H

    { { 'n', 'x', 'o', 'v' }, 's', 'z' }, -- Map cut and insert to z
    { { 'n', 'x', 'o', 'v' }, 'S', 'Z' }, -- Map cut line and insert to Z
    { { 'n', 'x', 'o', 'v' }, 'x', 'c' }, -- Map cut to c
    { { 'n', 'x', 'o', 'v' }, 'X', 'C' }, -- Map cut to C

    { 'n', 'p', 'x' }, -- Map paste to x
    { 'n', 'P', 'X' }, -- Map unchanged paste to X

    { 'v', 'J', 'E', 'move_down' }, -- Map move selection down to E
    { 'v', 'K', 'I', 'move_up' }, -- Map move selection up to I

    -- Others
    { 'n', 'q', 'm' }, -- Map macro to m
}

-- Iterate through the remap table using ipairs
for _, mapping in ipairs(remap) do
    local mode = mapping[1]
    local old = mapping[2]

    -- Unmap the old key
    vim.keymap.set(mode, old, '<nop>', { noremap = true, silent = true })
end

-- Iterate through the remap table using ipairs
for _, mapping in ipairs(remap) do
    local mode = mapping[1]
    local old = mapping[2]
    local new = mapping[3]
    local custom = mapping[4] or false

    if custom then
        old = custom_map[custom]
    end

    -- Remap the new key; not recursively (noremap)
    vim.keymap.set(mode, new, old, { noremap = true, silent = true })
end
