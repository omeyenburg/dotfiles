local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- Enable the autosnippet type
ls.config.setup { enable_autosnippets = true }

-- local simple = { "alpha", "beta", "gamma", "Gamma", "delta", "Delta", "epsilon", "varepsilon", "zeta", "eta", "theta", "vartheta", "Theta", "iota", "kappa", "lambda", "Lambda", "mu", "nu", "xi", "omicron", "pi", "rho", "varrho", "sigma", "Sigma", "tau", "upsilon", "Upsilon", "phi", "varphi", "Phi", "chi", "psi", "omega", "Omega" }

-- LaTeX Snippets
ls.add_snippets('tex', {
    -- Inline math
    s({ trig = 'mk', snippetType = 'autosnippet' }, {
        t '$',
        i(1, ''),
        t '$',
        i(2, ''),
    }),

    s({ trig = 'endl', snippetType = 'autosnippet' }, {
        t ' \\ ',
        i(2, ''),
    }),

    -- Display math
    s('display', {
        t '$$',
        i(1, 'expression'),
        t '$$',
    }),

    -- Fraction
    s('frac', {
        t '\\frac{',
        i(1, 'numerator'),
        t '}{',
        i(2, 'denominator'),
        t '}',
    }),

    -- Display fraction
    s('displayfrac', {
        t '\\[',
        t '\\frac{',
        i(1, 'numerator'),
        t '}{',
        i(2, 'denominator'),
        t '}',
        t '\\]',
    }),

    -- Section
    s('sec', {
        t '\\',
        i(1, ''),
        t 'section',
        i(2, '*'),
        t '{',
        i(3, 'Section Title'),
        t '}',
    }),
})
