local mappings = require 'config.latex_symbols'

for _, mapping in ipairs(mappings) do
    local symbol = mapping[1]
    local code = mapping[2]

    vim.keymap.set('i', code, symbol)
end
